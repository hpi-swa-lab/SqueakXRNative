#include <jni.h>
#include <string>
#include <stdio.h>
#include <unistd.h>
#include <android/log.h>
#include <pthread.h>

int fd[2];
pthread_t thr;

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

extern "C" JNIEXPORT jstring JNICALL
Java_com_swalab_squeakxrnative_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    setvbuf(stdout, 0, _IOLBF, 0);
    setvbuf(stderr, 0, _IONBF, 0);
    pipe(fd);
    dup2(fd[1], 1);
    dup2(fd[1], 2);

    std::string hello = "Hello from C+++++++++";
    if(pthread_create(&thr, 0, thread_func, 0) != 0) {
        __android_log_write(ANDROID_LOG_ERROR, ".squeakxrnative", "Failed to create thread");
    } else {
        pthread_detach(thr);
        __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "Created thread");
    }
//    __android_log_write(ANDROID_LOG_VERBOSE, ".squeakxrnative", "========================================test");
    return env->NewStringUTF(hello.c_str());
    printf("============ HELLOOOO WORLLDLDLDL ========");
}

extern "C" int run_squeak(int argc, char **argv, char **envp);

extern "C" JNIEXPORT void JNICALL Java_com_swalab_squeakxrnative_MainActivity_printSomething() {
    __android_log_write(ANDROID_LOG_DEBUG, ".squeakxrnative", "button c");
    printf("============ HELLOOOO WORLLDLDLDL ========");
    char *argv[1] = {"squeak"};
    char *envp[1]= {nullptr};
    run_squeak(1, argv, envp);
}