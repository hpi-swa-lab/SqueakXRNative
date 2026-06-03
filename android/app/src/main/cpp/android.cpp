#include <jni.h>
#include <android/log.h>
#include <android_native_app_glue.h>
#include <pthread.h>
#include <unistd.h>
#include <sstream>
#include <cstdio>
#include <cstring>
#include "squeak.h"

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

extern "C" void initOpenxr();

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
        .argv = {"squeak", /*"-vm-display-null",*/ squeakImagePath, "-doit", fullStartScript, "--", "--xr"},
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
