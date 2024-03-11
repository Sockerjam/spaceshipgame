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
    TimeIndex = 2
} BufferIndices;

typedef struct {
    matrix_float4x4 modelMatrix;
    matrix_float4x4 viewMatrix;
    matrix_float4x4 projectionMatrix;
} Uniform;



#endif /* Common_h */
