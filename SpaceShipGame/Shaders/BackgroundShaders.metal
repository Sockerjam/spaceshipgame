//
//  BackgroundShaders.metal
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

#include <metal_stdlib>
#include "Common.h"
#include "Helpers.h"

using namespace metal;

vertex VertexOut backgroundVertex(const VertexIn in [[stage_in]],
                                  constant float &time [[buffer(TimeIndex)]],
                                  constant Uniform &uniform [[buffer(UniformIndex)]])
{
    float4 position = in.position;
    float2 uvRotated = rotateUV(in.uv);
    float2 scaledUV = uvRotated;
    VertexOut out {
        .position = position,
        .uv = in.uv,
        .time = time
    };
    
    return out;
};

fragment float4 backgroundFragment(const VertexOut in [[stage_in]],
                                   texture2d<float> backgroundTexture [[texture(BackgroundTextureIndex)]])
{
    float speed = in.time * 0.0005;
    float colorSpeed = saturate(cos(speed));
    float2 uv = in.uv;
    uv.x += speed;
    
    constexpr sampler textureSampler(filter::linear,
                                     
                                     mip_filter::linear,
                                     max_anisotropy(8),
                                     address::repeat);
    
    float4 color = backgroundTexture.sample(textureSampler, uv) * 2;
    
    return float4(color.r * (1 - colorSpeed), color.g * colorSpeed, color.b, color.a);
};
