#define XR_USE_PLATFORM_ANDROID
#include <jni.h>
#include <string>
#include <sstream>
#include <cstdio>
#include <vector>
#include <unistd.h>
#include <android/log.h>
#include <pthread.h>
#include <raylib.h>
#include <raymath.h>
#include <rlOpenXR.h>
#include <android_native_app_glue.h>
#include <dlfcn.h>
#include <iostream>
#include <array>

static int fd[2];
static pthread_t thr;
static bool redirect_initialized = false;

// https://codelab.wordpress.com/2014/11/03/how-to-use-standard-output-streams-for-logging-in-android-apps/
static void *thread_func(void*)
{
    ssize_t rdsz;
    char buf[128];
    __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "Waiting for content...");
    while((rdsz = read(fd[0], buf, sizeof buf - 1))) {
        if (rdsz <= 0) continue;
        if(buf[rdsz - 1] == '\n') --rdsz;
        buf[rdsz] = 0;  /* add null-terminator */
        __android_log_print(ANDROID_LOG_DEBUG, ".squeakxrnative", "STDOUT: %s", buf);
    }
    return 0;
}

void initStdStreamRedirect() {
    if (redirect_initialized) return;

    setvbuf(stdout, 0, _IOLBF, 0);
    setvbuf(stderr, 0, _IONBF, 0);
    pipe(fd);
    dup2(fd[1], 1);
    dup2(fd[1], 2);

    if(pthread_create(&thr, 0, thread_func, 0) != 0) {
        __android_log_write(ANDROID_LOG_ERROR, ".squeakxrnative", "Failed to create thread");
    } else {
        pthread_detach(thr);
        __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "Created thread");
    }

    redirect_initialized = true;
}

char *squeakImagePath;
extern "C" JNIEXPORT void JNICALL Java_com_swalab_squeakxrnative_MainActivity_storeImagePath(JNIEnv *env, jobject /* jobj */, jstring jImagePath) {
    squeakImagePath = strdup(env->GetStringUTFChars(jImagePath, nullptr));
}

char *startScript;
extern "C" JNIEXPORT void JNICALL Java_com_swalab_squeakxrnative_MainActivity_storeStartScript(JNIEnv *env, jobject /* jobj */, jstring jStartScript) {
    startScript = strdup(env->GetStringUTFChars(jStartScript, nullptr));
}

extern "C" struct android_app *GetAndroidApp(void);

extern "C" void initOpenxr() {
    auto app = GetAndroidApp();
    JNIEnv *env;
    app->activity->vm->AttachCurrentThread(&env, nullptr);

    // https://registry.khronos.org/OpenXR/specs/1.1/html/xrspec.html#XR_KHR_loader_init
    // Load xrInitializeLoaderKHR() function pointer. On Android, the loader must be initialized with variables from android_app *.
    // Without this, there's is no loader and thus our function calls to OpenXR would fail.
    XrInstance m_xrInstance = XR_NULL_HANDLE;  // Dummy XrInstance variable for OPENXR_CHECK macro.
    PFN_xrInitializeLoaderKHR xrInitializeLoaderKHR = nullptr;
    XR_SUCCEEDED(xrGetInstanceProcAddr(XR_NULL_HANDLE, "xrInitializeLoaderKHR", (PFN_xrVoidFunction *)&xrInitializeLoaderKHR));
    if (!xrInitializeLoaderKHR) {
        return;
    }

    // Fill out an XrLoaderInitInfoAndroidKHR structure and initialize the loader for Android.
    XrLoaderInitInfoAndroidKHR loaderInitializeInfoAndroid{XR_TYPE_LOADER_INIT_INFO_ANDROID_KHR};
    loaderInitializeInfoAndroid.applicationVM = app->activity->vm;
    loaderInitializeInfoAndroid.applicationContext = app->activity->clazz;
    XR_SUCCEEDED(xrInitializeLoaderKHR((XrLoaderInitInfoBaseHeaderKHR *)&loaderInitializeInfoAndroid));
}

XrPath createXrPath(const char *pathString) {
    XrPath xrPath;
    if (XR_FAILED(xrStringToPath(rlGetXRInstance(), pathString, &xrPath))) {
        std::cerr << "Failed to get xrPath for " << pathString << "\n";
    }
    return xrPath;
}

std::string fromXrPath(XrPath path) {
    uint32_t length;
    char content[XR_MAX_PATH_LENGTH];
    std::string str;
    if (XR_SUCCEEDED(xrPathToString(rlGetXRInstance(), path, XR_MAX_PATH_LENGTH, &length, content))) {
        str = content;
    } else {
        std::cerr << "Failed to retrieve string for XrPath";
    }
    return str;
}

struct SqueakXrInput {
    XrActionSet actionSet;
    XrAction aimPoseAction;
    XrAction triggerAction;
    XrAction squeezeAction;
    XrAction aPressAction;
    XrAction bPressAction;
    XrAction xPressAction;
    XrAction yPressAction;
    XrAction menuPressAction;
    XrAction thumbstickXAction;
    XrAction thumbstickYAction;
    std::array<XrPath, 2> handPaths;
    std::array<XrSpace, 2> aimPoseSpaces;
    std::array<XrActionStatePose, 2> aimPoseState;
    std::array<XrActionStateFloat, 2> triggerState;
    std::array<XrActionStateFloat, 2> squeezeState;
    XrActionStateBoolean aPressState;
    XrActionStateBoolean bPressState;
    XrActionStateBoolean xPressState;
    XrActionStateBoolean yPressState;
    XrActionStateBoolean menuPressState;
    std::array<XrActionStateFloat, 2> thumbstickXState;
    std::array<XrActionStateFloat, 2> thumbstickYState;
};

SqueakXrInput xrInput;

// Adapted from https://openxr-tutorial.com/android/opengles/4-actions.html#interactions
extern "C" SqueakXrInput* initXrInput() {
    std::cout << "Initializing XR input\n";
    auto xrInstance = rlGetXRInstance();
    auto xrSession = rlGetXRSession();

    // Create ActionSet

    XrActionSetCreateInfo actionSetCreateInfo {XR_TYPE_ACTION_SET_CREATE_INFO};
    strncpy(actionSetCreateInfo.actionSetName, "squeakxr-actionset", XR_MAX_ACTION_SET_NAME_SIZE);
    strncpy(actionSetCreateInfo.localizedActionSetName, "SqueakXR ActionSet", XR_MAX_LOCALIZED_ACTION_SET_NAME_SIZE);
    actionSetCreateInfo.priority = 0;

    if (XR_FAILED(xrCreateActionSet(xrInstance, &actionSetCreateInfo, &xrInput.actionSet))) {
        std::cerr << "Failed to create ActionSet\n";
        return nullptr;
    }

    // Create Actions
    xrInput.handPaths = {createXrPath("/user/hand/left"), createXrPath("/user/hand/right")};
    #define LEFT_HAND_PATH xrInput.handPaths[0]
    #define RIGHT_HAND_PATH xrInput.handPaths[1]
    bool createActionsSuccessful = true;
    auto createAction = [&](XrAction &xrAction, const char* name, XrActionType actionType, std::vector<XrPath> subactionPaths) -> void {
        XrActionCreateInfo actionCreateInfo {XR_TYPE_ACTION_CREATE_INFO};
        strncpy(actionCreateInfo.actionName, name, XR_MAX_ACTION_NAME_SIZE);
        strncpy(actionCreateInfo.localizedActionName, name, XR_MAX_LOCALIZED_ACTION_NAME_SIZE);
        actionCreateInfo.actionType = actionType;
        actionCreateInfo.countSubactionPaths = subactionPaths.size();
        actionCreateInfo.subactionPaths = subactionPaths.data();

        auto result = xrCreateAction(xrInput.actionSet, &actionCreateInfo, &xrAction);
        if (XR_FAILED(result)) {
            createActionsSuccessful = false;
            char desc[XR_MAX_RESULT_STRING_SIZE];
            xrResultToString(xrInstance, result, desc);
            std::cerr << "Failed to create Action " << name << ": " << desc << '\n';
        }
    };

    createAction(xrInput.aimPoseAction, "aim-pose", XR_ACTION_TYPE_POSE_INPUT, {LEFT_HAND_PATH, RIGHT_HAND_PATH});
    createAction(xrInput.triggerAction, "trigger", XR_ACTION_TYPE_FLOAT_INPUT, {LEFT_HAND_PATH, RIGHT_HAND_PATH});
    createAction(xrInput.squeezeAction, "squeeze", XR_ACTION_TYPE_FLOAT_INPUT, {LEFT_HAND_PATH, RIGHT_HAND_PATH});
    createAction(xrInput.aPressAction, "a-press", XR_ACTION_TYPE_BOOLEAN_INPUT, {RIGHT_HAND_PATH});
    createAction(xrInput.bPressAction, "b-press", XR_ACTION_TYPE_BOOLEAN_INPUT, {RIGHT_HAND_PATH});
    createAction(xrInput.xPressAction, "x-press", XR_ACTION_TYPE_BOOLEAN_INPUT, {LEFT_HAND_PATH});
    createAction(xrInput.yPressAction, "y-press", XR_ACTION_TYPE_BOOLEAN_INPUT, {LEFT_HAND_PATH});
    createAction(xrInput.menuPressAction, "menu-press", XR_ACTION_TYPE_BOOLEAN_INPUT, {LEFT_HAND_PATH});
    createAction(xrInput.thumbstickXAction, "thumbstick-x", XR_ACTION_TYPE_FLOAT_INPUT, {LEFT_HAND_PATH, RIGHT_HAND_PATH});
    createAction(xrInput.thumbstickYAction, "thumbstick-y", XR_ACTION_TYPE_FLOAT_INPUT, {LEFT_HAND_PATH, RIGHT_HAND_PATH});

    if (!createActionsSuccessful) {
        std::cerr << "Creating actions failed!\n";
        return nullptr;
    }

    // Suggest bindings
    XrInteractionProfileSuggestedBinding interactionProfileSuggestedBinding {XR_TYPE_INTERACTION_PROFILE_SUGGESTED_BINDING};
    interactionProfileSuggestedBinding.interactionProfile = createXrPath("/interaction_profiles/oculus/touch_controller");
    std::vector<XrActionSuggestedBinding> suggestedBindings = {{
        {xrInput.aimPoseAction, createXrPath("/user/hand/right/input/aim/pose")},
        {xrInput.aimPoseAction, createXrPath("/user/hand/left/input/aim/pose")},
        {xrInput.triggerAction, createXrPath("/user/hand/right/input/trigger/value")},
        {xrInput.triggerAction, createXrPath("/user/hand/left/input/trigger/value")},
        {xrInput.squeezeAction, createXrPath("/user/hand/left/input/squeeze/value")},
        {xrInput.squeezeAction, createXrPath("/user/hand/right/input/squeeze/value")},
        {xrInput.aPressAction, createXrPath("/user/hand/right/input/a/click")},
        {xrInput.bPressAction, createXrPath("/user/hand/right/input/b/click")},
        {xrInput.xPressAction, createXrPath("/user/hand/left/input/x/click")},
        {xrInput.yPressAction, createXrPath("/user/hand/left/input/y/click")},
        {xrInput.menuPressAction, createXrPath("/user/hand/left/input/menu/click")},
        {xrInput.thumbstickXAction, createXrPath("/user/hand/left/input/thumbstick/x")},
        {xrInput.thumbstickXAction, createXrPath("/user/hand/right/input/thumbstick/x")},
        {xrInput.thumbstickYAction, createXrPath("/user/hand/left/input/thumbstick/y")},
        {xrInput.thumbstickYAction, createXrPath("/user/hand/right/input/thumbstick/y")}
    }};
    interactionProfileSuggestedBinding.countSuggestedBindings = suggestedBindings.size();
    interactionProfileSuggestedBinding.suggestedBindings = suggestedBindings.data();

    if (XR_FAILED(xrSuggestInteractionProfileBindings(xrInstance, &interactionProfileSuggestedBinding))) {
        std::cerr << "Failed to suggest bindings for /interaction_profiles/oculus/touch_controller\n";
        return nullptr;
    }

    // Create pose spaces
    for (size_t i = 0; i < xrInput.handPaths.size(); ++i) {
        XrActionSpaceCreateInfo actionSpaceCreateInfo {XR_TYPE_ACTION_SPACE_CREATE_INFO};
        actionSpaceCreateInfo.action = xrInput.aimPoseAction;
        actionSpaceCreateInfo.subactionPath = xrInput.handPaths[i];
        actionSpaceCreateInfo.poseInActionSpace = {{0.0f, 0.0f, 0.0f, 1.0f}, {0.0f, 0.0f, 0.0f}};
        if (XR_FAILED(xrCreateActionSpace(xrSession, &actionSpaceCreateInfo, &xrInput.aimPoseSpaces[i]))) {
            std::cerr << "Failed to get create action space for " << fromXrPath(xrInput.handPaths[i]) << '\n';
        };
    }

    // Attach ActionSet
    XrSessionActionSetsAttachInfo sessionActionSetsAttachInfo {XR_TYPE_SESSION_ACTION_SETS_ATTACH_INFO};
    sessionActionSetsAttachInfo.countActionSets = 1;
    sessionActionSetsAttachInfo.actionSets = &xrInput.actionSet;
    if (XR_FAILED(xrAttachSessionActionSets(xrSession, &sessionActionSetsAttachInfo))) {
        std::cerr << "Failed to attach ActionSet to session\n";
        return nullptr;
    }

    // Report bindings
    XrInteractionProfileState interactionProfile = {XR_TYPE_INTERACTION_PROFILE_STATE, 0, 0};
    for (const auto path : xrInput.handPaths) {
        if (XR_FAILED(xrGetCurrentInteractionProfile(rlGetXRSession(), path, &interactionProfile))) {
            std::cerr << "Failed to get interaction profile for " << fromXrPath(path) << '\n';
            return nullptr;
        }
        if (interactionProfile.interactionProfile) {
            std::cout << "Interaction profile for " << fromXrPath(path) << " is " << fromXrPath(interactionProfile.interactionProfile) << '\n';
        }
    }

    return &xrInput;
}

struct SqueakXrActionStates {
    XrPosef aimPoses[2];
    float triggers[2];
    float squeeze[2];
    bool a;
    bool b;
    bool x;
    bool y;
    bool menu;
    float thumbstickX[2];
    float thumbstickY[2];
};

SqueakXrActionStates actionStates;

extern "C" SqueakXrActionStates pollActions() {
    const auto time = rlOpenXRGetTime(); // alternatively rlGetPredictedDisplayTime()
    const auto session = rlGetXRSession();

    XrActiveActionSet activeActionSet {};
    activeActionSet.actionSet = xrInput.actionSet;
    activeActionSet.subactionPath = XR_NULL_PATH;
    XrActionsSyncInfo actionsSyncInfo {XR_TYPE_ACTIONS_SYNC_INFO};
    actionsSyncInfo.countActiveActionSets = 1;
    actionsSyncInfo.activeActionSets = &activeActionSet;
    if (XR_FAILED(xrSyncActions(session, &actionsSyncInfo))) {
        std::cerr << "Failed to sync Actions\n";
    }

    XrActionStateGetInfo actionStateGetInfo {XR_TYPE_ACTION_STATE_GET_INFO};
    for (size_t i = 0; i < xrInput.handPaths.size(); ++i) {
        actionStateGetInfo.subactionPath = xrInput.handPaths[i];

        // aim-pose
        actionStateGetInfo.action = xrInput.aimPoseAction;
        if (XR_FAILED(xrGetActionStatePose(session, &actionStateGetInfo, &xrInput.aimPoseState[i]))) {
            std::cerr << "Failed to get aim action state pose for " << fromXrPath(xrInput.handPaths[i]) << "\n";
            continue;
        }
        if (xrInput.aimPoseState[i].isActive) {
            XrSpaceLocation spaceLocation {XR_TYPE_SPACE_LOCATION};
            if (XR_SUCCEEDED(xrLocateSpace(xrInput.aimPoseSpaces[i], rlGetPlaySpace(), time, &spaceLocation))) {
                if ((spaceLocation.locationFlags & XR_SPACE_LOCATION_POSITION_VALID_BIT != 0)
                    && (spaceLocation.locationFlags & XR_SPACE_LOCATION_ORIENTATION_VALID_BIT != 0)) {
                    actionStates.aimPoses[i] = spaceLocation.pose;
                }
            } else {
                std::cerr << "Failed to locate aim space for "<< fromXrPath(xrInput.handPaths[i]) << "\n";
            }
        }

        // trigger
        actionStateGetInfo.action = xrInput.triggerAction;
        if (XR_SUCCEEDED(xrGetActionStateFloat(session, &actionStateGetInfo, &xrInput.triggerState[i]))) {
            actionStates.triggers[i] = xrInput.triggerState[i].currentState;
        } else {
            std::cerr << "Failed to get action state of trigger\n";
        }

        // squeeze
        actionStateGetInfo.action = xrInput.squeezeAction;
        if (XR_SUCCEEDED(xrGetActionStateFloat(session, &actionStateGetInfo, &xrInput.squeezeState[i]))) {
            actionStates.squeeze[i] = xrInput.squeezeState[i].currentState;
        } else {
            std::cerr << "Failed to get action state of squeeze\n";
        }

        if (i == 0) {
            // x
            actionStateGetInfo.action = xrInput.xPressAction;
            if (XR_SUCCEEDED(
                    xrGetActionStateBoolean(session, &actionStateGetInfo, &xrInput.xPressState))) {
                actionStates.x = xrInput.xPressState.currentState;
            } else {
                std::cerr << "Failed to get action state of x\n";
            }

            // y
            actionStateGetInfo.action = xrInput.yPressAction;
            if (XR_SUCCEEDED(
                    xrGetActionStateBoolean(session, &actionStateGetInfo, &xrInput.yPressState))) {
                actionStates.y = xrInput.yPressState.currentState;
            } else {
                std::cerr << "Failed to get action state of y\n";
            }

            // menu
            actionStateGetInfo.action = xrInput.menuPressAction;
            if (XR_SUCCEEDED(xrGetActionStateBoolean(session, &actionStateGetInfo,
                                                     &xrInput.menuPressState))) {
                actionStates.menu = xrInput.menuPressState.currentState;
            } else {
                std::cerr << "Failed to get action state of menu\n";

            }
        }

        if (i == 1) {
            // a
            actionStateGetInfo.action = xrInput.aPressAction;
            if (XR_SUCCEEDED(xrGetActionStateBoolean(session, &actionStateGetInfo, &xrInput.aPressState))) {
                actionStates.a = xrInput.aPressState.currentState;
            } else {
                std::cerr << "Failed to get action state of a\n";
            }

            // b
            actionStateGetInfo.action = xrInput.bPressAction;
            if (XR_SUCCEEDED(xrGetActionStateBoolean(session, &actionStateGetInfo, &xrInput.bPressState))) {
                actionStates.b = xrInput.bPressState.currentState;
            } else {
                std::cerr << "Failed to get action state of b\n";
            }
        }

        // thumbstickX
        actionStateGetInfo.action = xrInput.thumbstickXAction;
        if (XR_SUCCEEDED(xrGetActionStateFloat(session, &actionStateGetInfo, &xrInput.thumbstickXState[i]))) {
            actionStates.thumbstickX[i] = xrInput.thumbstickXState[i].currentState;
        } else {
            std::cerr << "Failed to get action state of thumbstickX\n";
        }

        // thumbstickY
        actionStateGetInfo.action = xrInput.thumbstickYAction;
        if (XR_SUCCEEDED(xrGetActionStateFloat(session, &actionStateGetInfo, &xrInput.thumbstickYState[i]))) {
            actionStates.thumbstickY[i] = xrInput.thumbstickYState[i].currentState;
        } else {
            std::cerr << "Failed to get action state of thumbstickY\n";
        }
    }

    return actionStates;
}

//extern "C" void reportBindings() {
//    XrInteractionProfileState interactionProfile = {XR_TYPE_INTERACTION_PROFILE_STATE, 0, 0};
//    for (const auto path : xrInput.handPaths) {
//        if (XR_FAILED(xrGetCurrentInteractionProfile(rlGetXRSession(), path, &interactionProfile))) {
//            std::cerr << "Failed to get interaction profile for " << fromXrPath(path) << '\n';
//        }
//        if (interactionProfile.interactionProfile) {
//            std::cout << "Interaction profile for " << fromXrPath(path) << " is " << fromXrPath(interactionProfile.interactionProfile) << '\n';
//        }
//    }
//}

extern "C" int run_squeak(int argc, char **argv, char **envp);

struct SqueakFuncArgs {
    std::vector<char*> argv;
};

static void *squeak_func(void* args) {
    __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "button c");
    if (args == nullptr) {
        printf("Cannot start squeak without args");
        return nullptr;
    }

    auto func_args = static_cast<SqueakFuncArgs*>(args);

//    char *imagePath = strdup(env->GetStringUTFChars(jImagePath, nullptr));
//# define NUM_ARGS 5
//    char *argv[NUM_ARGS] = {"squeak", squeakImagePath, "-vm-display-null", "-doit", "ExternalAddress allBeNull. SRSyncServer start"};
    char *envp[1]= {nullptr};
    __android_log_print(ANDROID_LOG_DEBUG, ".squeakxrnative", "Launching squeak with image %s", squeakImagePath);
    run_squeak(static_cast<int>(func_args->argv.size()), func_args->argv.data(), envp);

    delete func_args;

    return nullptr;
}

extern "C" void pollAndroidEvents() {
    int pollResult = 0;
    int pollEvents = 0;
    struct android_poll_source *source;
    auto app = GetAndroidApp();

    int i = 0;
    while ((pollResult = ALooper_pollOnce(0, NULL, &pollEvents, (void **)&source)) > ALOOPER_POLL_TIMEOUT)
    {
        ++i;
        if (source != NULL) source->process(app, source);
    }

    if (i > 0) {
        printf("=============>>>> I had to poll something  %i\n", i);
    }
}

extern "C" void jit_test();

int main(int argc, char *argv[]) {

    initStdStreamRedirect();

//    jit_test();
//    return 0;

    __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "================= MAIN CALLED =================");
    printf("====== test =====\n");

    initOpenxr();

    // prevent ANR
    int pollResult = 0;
    int pollEvents = 0;
    struct android_poll_source *source;
    auto app = GetAndroidApp();

//    int i = 0;
//    while ((pollResult = ALooper_pollOnce(100, NULL, &pollEvents, (void **)&source)) > ALOOPER_POLL_TIMEOUT)
//    {
//        ++i;
//        if (source != NULL) {
//            __android_log_print(ANDROID_LOG_DEBUG, ".squeakxrnative", "GOT AN EVENT");
//            source->process(app, source); }
//    }

    std::ostringstream startScriptStream;
    startScriptStream << "Project current addDeferredUIMessage: [" << startScript << "]";
    auto fullStartScript= strdup(startScriptStream.str().c_str());
    __android_log_print(ANDROID_LOG_DEBUG, ".squeakxrnative", "DoIt: %s", fullStartScript);

    //"-doit", "Project current addDeferredUIMessage: [Transcript showln: 'THIS SHOULD SHOW UP ON STDOUT'. SRSyncServer start. [Processor activeProcess name: 'RENDERER'. SRRenderer new simpleDrawLoop] fork]",
//    std::vector<char*> argv2 = {"squeak", squeakImagePath, "-vm-display-null", "-doit", fullStartScript/*, "--", "-repl"*/};
//    char *envp[1]= {nullptr};
//    __android_log_print(ANDROID_LOG_DEBUG, ".squeakxrnative", "Launching squeak with image %s", squeakImagePath);

    auto *squeak_func_args = new SqueakFuncArgs {
        .argv = {"squeak", squeakImagePath, "-vm-display-null", "-doit", fullStartScript},
//        .argc = argv2.size(),
    };

//    pollAndroidEvents();
    squeak_func(squeak_func_args);
//    pthread_t sqthr;
//    if(pthread_create(&sqthr, nullptr, squeak_func, squeak_func_args) != 0) {
//        __android_log_write(ANDROID_LOG_ERROR, ".squeakxrnative", "Failed to create squeak thread");
//    } else {
//        pthread_detach(sqthr);
//        __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "Created squeak thread");
//    }

//    run_squeak(argv2.size(), argv2.data(), envp);
//    free(imagePath);
    free(fullStartScript);

    return 0;





    initOpenxr();
//    InitWindow(0, 0, "raylib [core] example - basic window");
//    SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    const int screenWidth = 1200;
    const int screenHeight = 900;

    InitWindow(screenWidth, screenHeight, "rlOpenXR - Hello Vr");

    // Define the camera to look into our 3d world
    Camera camera = { 0 };
    camera.position = (Vector3){10.0f, 10.0f, 10.0f}; // Camera position
    camera.target = (Vector3){0.0f, 3.0f, 0.0f};      // Camera looking at point
    camera.up = (Vector3){0.0f, 1.0f, 0.0f};          // Camera up vector (rotation towards target)
    camera.fovy = 45.0f;                       // Camera field-of-view Y
    camera.projection = CAMERA_PERSPECTIVE;    // Camera mode type

//    SetCameraMode(camera, CAMERA_FREE);

    SetTargetFPS(-1); // OpenXR is responsible for waiting in rlOpenXRUpdate()

    const bool initialised_rlopenxr = rlOpenXRSetup();
    if (!initialised_rlopenxr)
    {
        printf("Failed to initialise rlOpenXR!");
        return 1;
    }


    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
//        BeginDrawing();
//
//        ClearBackground(RAYWHITE);
//
//        DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);
//
//        EndDrawing();
        //----------------------------------------------------------------------------------

        rlOpenXRUpdate(); // Update OpenXR State.
        // Should be called at the start of each frame before other rlOpenXR calls.

        UpdateCamera(&camera, CAMERA_FREE); // Use mouse control as a debug option when no HMD is available
        rlOpenXRUpdateCamera(&camera); // If the HMD is available, set the camera position to the HMD position

        // Draw
        //----------------------------------------------------------------------------------

        ClearBackground(RAYWHITE); // Clear window, in case rlOpenXR skips rendering the frame

        // rlOpenXRBegin() returns false when OpenXR reports to skip the frame (The HMD is inactive).
        // Optionally rlOpenXRBeginMockHMD() can be chained to always render. It will render into a "Mock" backbuffer.
        if (rlOpenXRBegin()) // Render to OpenXR backbuffer
        {
            ClearBackground(BLUE);

            BeginMode3D(camera);

            // Draw Scene
            DrawCube((Vector3) { -3, 0, 0 }, 2.0f, 2.0f, 2.0f, RED);
            DrawGrid(10, 1.0f);

            EndMode3D();

            const bool keep_aspect_ratio = true;
            rlOpenXRBlitToWindow(RLOPENXR_EYE_BOTH, keep_aspect_ratio); // Copy OpenXR backbuffer to window backbuffer
            // Useful for viewing the image on a flatscreen
        }
        rlOpenXREnd();


        BeginDrawing(); // Draw to the window, eg, debug overlays

        DrawFPS(10, 10);

        EndDrawing();

    }

    rlOpenXRShutdown();

    CloseWindow();              // Close window and OpenGL context

    // De-Initialization
    //--------------------------------------------------------------------------------------
//    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
    
    return 0;
}

extern "C" JNIEXPORT void JNICALL Java_com_swalab_squeakxrnative_MainActivity_launch(JNIEnv *env, jobject /* jobj */, jstring jImagePath) {
    pthread_t sqthr;
    if(pthread_create(&sqthr, 0, squeak_func, 0) != 0) {
        __android_log_write(ANDROID_LOG_ERROR, ".squeakxrnative", "Failed to create thread");
    } else {
        pthread_detach(sqthr);
        __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "Created thread");
    }
}