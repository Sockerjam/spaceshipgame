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
    PerInstanceUniformIndex = 3
} BufferIndices;

typedef struct {
    matrix_float4x4 modelMatrix;
    matrix_float4x4 viewMatrix;
    matrix_float4x4 projectionMatrix;
} Uniform;

typedef struct {
    matrix_float4x4 modelMatrix;
    simd_float4 color;
    float speed;
} PerInstanceUniform;



#endif /* Common_h */
