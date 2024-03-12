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

struct ModelVertexIn {
    float4 position [[attribute(0)]];
    float2 normal [[attribute(1)]];
    float2 uv [[attribute(2)]];
};

struct ModelVertexOut {
    float4 position [[position]];
    float2 uv;
    float4 color;
    float time;
};


vertex ModelVertexOut foregroundVertex(const ModelVertexIn in [[stage_in]],
                                 constant Uniform &uniform [[buffer(UniformIndex)]],
                                 constant float &time [[buffer(TimeIndex)]],
                                 constant PerInstanceUniform *instanceUniform [[buffer(PerInstanceUniformIndex)]],
                                 ushort iid [[instance_id]])
{
    float speed = time / instanceUniform[iid].speed;
    float4 color = instanceUniform[iid].color;
    float4 position = uniform.projectionMatrix * uniform.viewMatrix * instanceUniform[iid].modelMatrix * rotatePlanet(speed) * in.position;
    position.y -= speed;
    ModelVertexOut out {
        .position = position,
        .uv = float2(1 - in.uv.x, in.uv.y),
        .time = time,
        .color = color
    };
    
    return out;
};

fragment float4 foregroundFragment(const ModelVertexOut in [[stage_in]],
                                   texture2d<float> foregroundTexture [[texture(ForegroundTextureIndex)]])
{
    
    constexpr sampler textureSampler(filter::linear,
                                     address::repeat,
                                     mip_filter::linear,
                                     max_anisotropy(8));
    
    float4 color = foregroundTexture.sample(textureSampler, in.uv) * in.color;
    
    return color;
    
};
