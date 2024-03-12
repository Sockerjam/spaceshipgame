//
//  Common.h
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

#ifndef Common_h
#define Common_h

#import <simd/simd.h>


typedef enum {
    BackgroundVertexIndex = 0,
    BackgroundTextureIndex = 0,
    ForegroundTextureIndex = 1,
    UniformIndex = 1,
    TimeIndex = 2,
    PerInstanceUniformIndex = 3,
    LightIndex = 4
} BufferIndices;

typedef struct {
    matrix_float4x4 modelMatrix;
    matrix_float4x4 viewMatrix;
    matrix_float4x4 projectionMatrix;
} Uniform;

typedef struct {
    matrix_float4x4 modelMatrix;
    simd_float3 color;
    float speed;
} PerInstanceUniform;

typedef struct {
    simd_float3 position;
    simd_float3 color;
} Light;



#endif /* Common_h */
