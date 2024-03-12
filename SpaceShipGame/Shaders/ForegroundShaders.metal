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
    float3 normal [[attribute(1)]];
    float2 uv [[attribute(2)]];
};

struct ModelVertexOut {
    float4 position [[position]];
    float2 uv;
    float3 color;
    float3 worldNormal;
    float time;
};


vertex ModelVertexOut foregroundVertex(const ModelVertexIn in [[stage_in]],
                                 constant Uniform &uniform [[buffer(UniformIndex)]],
                                 constant float &time [[buffer(TimeIndex)]],
                                 constant PerInstanceUniform *instanceUniform [[buffer(PerInstanceUniformIndex)]],
                                 ushort iid [[instance_id]])
{
    float speed = time / instanceUniform[iid].speed;
    
    float4x4 modelMatrix = instanceUniform[iid].modelMatrix * rotatePlanet(speed);
    float3 color = instanceUniform[iid].color;
    float4 position = uniform.projectionMatrix * uniform.viewMatrix * modelMatrix * in.position;
    
    float3x3 normalMatrix = float3x3(modelMatrix[0].xyz,
                                     modelMatrix[1].xyz,
                                     modelMatrix[2].xyz);
    
    position.y -= speed;
   
    ModelVertexOut out {
        .position = position,
        .uv = float2(1 - in.uv.x, in.uv.y),
        .time = time,
        .color = color,
        .worldNormal = normalMatrix * in.normal
    };
    
    return out;
};

fragment float4 foregroundFragment(const ModelVertexOut in [[stage_in]],
                                   texture2d<float> foregroundTexture [[texture(ForegroundTextureIndex)]],
                                   constant Light *light [[buffer(LightIndex)]])
{
    
    constexpr sampler textureSampler(filter::linear,
                                     address::repeat,
                                     mip_filter::linear,
                                     max_anisotropy(8));
    
    float3 baseColor = foregroundTexture.sample(textureSampler, in.uv).rgb * in.color;
    float3 noise = randomColor(in.color);
    
    float3 normal = normalize(in.worldNormal);
    
    float3 color = phongLighting(noise, normal, light);
    
    return float4(color, 1);
    
};
