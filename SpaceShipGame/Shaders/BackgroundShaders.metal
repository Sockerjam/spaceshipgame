//
//  BackgroundShaders.metal
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

#include <metal_stdlib>
#include "Common.h"

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

float2 rotateUV(float2 uv)
{
    float2x2 matrix (cos(M_PI_2_F), -sin(M_PI_2_F),
                     sin(M_PI_2_F), cos(M_PI_2_F));
    
    return matrix * uv;
};

vertex VertexOut backgroundVertex(const VertexIn in [[stage_in]],
                                  constant Uniform &uniform [[buffer(UniformIndex)]],
                                  constant float &time [[buffer(TimeIndex)]])
{
    float4 position = in.position;
    float2 uvRotated = rotateUV(in.uv);
    float2 scaledUV = uvRotated * 2;
    VertexOut out {
        .position = position,
        .uv = scaledUV,
        .time = time
    };
    
    return out;
};

fragment float4 backgroundFragment(const VertexOut in [[stage_in]],
                                   texture2d<float> backgroundTexture [[texture(BackgroundTextureIndex)]])
{
    float speed = in.time * 0.0025;
    float colorSpeed = saturate(cos(speed));
    float2 uv = in.uv;
    uv.x += speed;
    
    constexpr sampler textureSampler(filter::linear,
                                     
                                     mip_filter::linear,
                                     max_anisotropy(8),
                                     address::mirrored_repeat);
    
    float4 color = backgroundTexture.sample(textureSampler, uv) * 2;
    
    return float4(color.r * (1 - colorSpeed), color.g * colorSpeed, color.b, color.a);
};
