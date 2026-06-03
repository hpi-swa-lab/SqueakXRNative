#include <rlOpenXR.h>
#include <string>
#include <vector>
#include <iostream>
#include <array>

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
