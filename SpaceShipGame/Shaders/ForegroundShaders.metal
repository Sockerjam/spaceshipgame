//
//  ForegroundShaders.metal
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 11/03/2024.
//

#include <metal_stdlib>
#include "Common.h"
#include "Helpers.h"
using namespace metal;


vertex VertexOut foregroundVertex(const VertexIn in [[stage_in]],
                                 constant Uniform &uniform [[buffer(UniformIndex)]],
                                 constant float &time [[buffer(TimeIndex)]])
{
    float4 position = uniform.projectionMatrix * uniform.viewMatrix * uniform.modelMatrix * in.position;
    VertexOut out {
        .position = position,
        .uv = in.uv,
        .time = time
    };
    
    return out;
};

fragment float4 foregroundFragment(const VertexOut in [[stage_in]],
                                   texture2d<float> backgroundTexture [[texture(ForegroundTextureIndex)]])
{
    
    constexpr sampler textureSampler(filter::linear,
                                     address::repeat,
                                     mip_filter::linear,
                                     max_anisotropy(8));
    
    float4 color = backgroundTexture.sample(textureSampler, in.uv);
    
    return color;
    
};
