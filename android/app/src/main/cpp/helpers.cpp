#include <raylib.h>

extern "C" Mesh createRaylibMeshFromArrays(int vertexCount, int triangleCount, float *vertices, float *normals, float *texcoords, unsigned char *colors, unsigned short *indices) {
    return {
        .vertexCount = vertexCount,
        .triangleCount = triangleCount,
        .vertices = vertices,
        .texcoords = texcoords,
        .normals = normals,
        .colors = colors,
        .indices = indices,
    };
}