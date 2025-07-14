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
    XrAction gripPoseAction;
    std::array<XrPath, 2> handPaths;
    std::array<XrSpace, 2> gripPoseSpaces;
    std::array<XrActionStatePose, 2> gripPoseState;
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
//    auto createAction = [](XrAction &xrAction, const char* name, XrActionType actionType, bool useHandSubactionPaths) -> void {
//        XrActionCreateInfo actionCreateInfo {XR_TYPE_ACTION_CREATE_INFO};
//        strncpy(actionCreateInfo.actionName, name, XR_MAX_ACTION_NAME_SIZE);
//        strncpy(actionCreateInfo.localizedActionName, name, XR_MAX_LOCALIZED_ACTION_NAME_SIZE);
//        actionCreateInfo.actionType = XR_ACTION_TYPE_POSE_INPUT;
//        if (useHandSubactionPaths) {
//            actionCreateInfo.countSubactionPaths = xrInput.handPaths.size();
//            actionCreateInfo.subactionPaths = xrInput.handPaths.data();
//        } else {
//            actionCreateInfo.countSubactionPaths = 0;
//            actionCreateInfo.subactionPaths = nullptr;
//        }
//
//        if (XR_FAILED(xrCreateAction(xrInput.actionSet, &actionCreateInfo, &xrInput.gripPoseAction))) {
//            std::cerr << "Failed to create Action" << name << '\n';
//            return nullptr;
//        }
//    };

//    createAction(xrInput.gripPoseAction, "grip-pose", XR_ACTION_TYPE_POSE_INPUT, true);

    XrActionCreateInfo actionCreateInfo {XR_TYPE_ACTION_CREATE_INFO};
    strncpy(actionCreateInfo.actionName, "grip-pose", XR_MAX_ACTION_NAME_SIZE);
    strncpy(actionCreateInfo.localizedActionName, "grip-pose", XR_MAX_LOCALIZED_ACTION_NAME_SIZE);
    actionCreateInfo.actionType = XR_ACTION_TYPE_POSE_INPUT;
    actionCreateInfo.countSubactionPaths = xrInput.handPaths.size();
    actionCreateInfo.subactionPaths = xrInput.handPaths.data();

    if (XR_FAILED(xrCreateAction(xrInput.actionSet, &actionCreateInfo, &xrInput.gripPoseAction))) {
        std::cerr << "Failed to create Action grip-pose\n";
        return nullptr;
    }

    // Suggest bindings
    XrInteractionProfileSuggestedBinding interactionProfileSuggestedBinding {XR_TYPE_INTERACTION_PROFILE_SUGGESTED_BINDING};
    interactionProfileSuggestedBinding.interactionProfile = createXrPath("/interaction_profiles/oculus/touch_controller");
    std::array<XrActionSuggestedBinding, 2> suggestedBindings = {{
        {xrInput.gripPoseAction, createXrPath("/user/hand/right/input/aim/pose")},
        {xrInput.gripPoseAction, createXrPath("/user/hand/left/input/aim/pose")}
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
        actionSpaceCreateInfo.action = xrInput.gripPoseAction;
        actionSpaceCreateInfo.subactionPath = xrInput.handPaths[i];
        actionSpaceCreateInfo.poseInActionSpace = {{0.0f, 0.0f, 0.0f, 1.0f}, {0.0f, 0.0f, 0.0f}};
        if (XR_FAILED(xrCreateActionSpace(xrSession, &actionSpaceCreateInfo, &xrInput.gripPoseSpaces[i]))) {
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
    XrPosef gripPoses[2];
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
    actionStateGetInfo.action = xrInput.gripPoseAction;
    for (size_t i = 0; i < xrInput.handPaths.size(); ++i) {
        actionStateGetInfo.subactionPath = xrInput.handPaths[i];
        if (XR_FAILED(xrGetActionStatePose(session, &actionStateGetInfo, &xrInput.gripPoseState[i]))) {
            std::cerr << "Failed to get grip action state pose for " << fromXrPath(xrInput.handPaths[i]) << "\n";
            continue;
        }
        if (xrInput.gripPoseState[i].isActive) {
            XrSpaceLocation spaceLocation {XR_TYPE_SPACE_LOCATION};
            if (XR_SUCCEEDED(xrLocateSpace(xrInput.gripPoseSpaces[i], rlGetPlaySpace(), time, &spaceLocation))) {
                if ((spaceLocation.locationFlags & XR_SPACE_LOCATION_POSITION_VALID_BIT != 0)
                    && (spaceLocation.locationFlags & XR_SPACE_LOCATION_ORIENTATION_VALID_BIT != 0)) {
                    actionStates.gripPoses[i] = spaceLocation.pose;
//                    std::cout << fromXrPath(xrInput.handPaths[i])
//                        << " position: x = " << spaceLocation.pose.position.x
//                        << ", y = " << spaceLocation.pose.position.y
//                        << ", z = " << spaceLocation.pose.position.z
//                        << '\n';
                }
            } else {
                std::cerr << "Failed to locate grip space for "<< fromXrPath(xrInput.handPaths[i]) << "\n";
                continue;
            }
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