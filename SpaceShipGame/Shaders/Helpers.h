//
//  Helpers.h
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 05/03/2024.
//

#ifndef Helpers_h
#define Helpers_h
#include <metal_stdlib>

using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
    float2 uv [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float2 uv;
    float time;
};

float2 rotateUV(float2 uv);

float4x4 rotatePlanet(float angle);


#endif /* Helpers_h */
