#pragma once
#include <vector>

struct SqueakFuncArgs {
    std::vector<char*> argv;
};

void* squeak_func(void* args);
