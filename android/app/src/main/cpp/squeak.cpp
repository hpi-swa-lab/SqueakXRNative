#include <vector>
#include <sstream>
#include <cstdio>
#include <android/log.h>
#include "squeak.h"

extern "C" int run_squeak(int argc, char **argv, char **envp);

void *squeak_func(void* args) {
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
    std::stringstream argsStringStream;
    for (auto arg : func_args->argv) {
        argsStringStream << arg << " ";
    }
    __android_log_print(ANDROID_LOG_DEBUG, ".squeakxrnative", "Launching squeak with args '%s'", argsStringStream.str().c_str());
    run_squeak(static_cast<int>(func_args->argv.size()), func_args->argv.data(), envp);

    delete func_args;

    return nullptr;
}
