//
//  MidgroundShaders.metal
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 05/03/2024.
//

#include <metal_stdlib>
#include "Helpers.h"
#include "Common.h"

using namespace metal;

vertex VertexOut midgroundVertex(const VertexIn in [[stage_in]],
                                 constant Uniform &uniform [[buffer(UniformIndex)]],
                                 constant float &time [[buffer(TimeIndex)]])
{
    VertexOut out {
        .position = in.position,
        .uv = in.uv,
        .time = time
    };
    
    return out;
};

fragment float4 midgroundFragment(const VertexOut in [[stage_in]])
{
    
    float4 centers = float4(in.time, 1 - cos(in.time), sin(in.time / 2), cos(in.time / 4));
    
    float animation = saturate(sin(in.time / 8));
    
    float radius = 0.001;
    
    
    float4 colorInsideCircle = float4(1, 1, 1, animation);
    float4 colorOutsideCircle = float4(0);
    
    for (int i = 0; i < 4; i++)
    {
        float2 center = float2(centers[i], animation * saturate(sin(animation)));
        float2 directionVector = in.uv - center;
        float magnitude = length(directionVector);
        
        if (magnitude <= radius)
        {
            return colorInsideCircle;
        }
        
    }
    
    return colorOutsideCircle;
    
};
