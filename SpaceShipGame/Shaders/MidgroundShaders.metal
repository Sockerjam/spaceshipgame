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
    if (in.time > 10)
    {
        float time = in.time - 10;
        
        float4 centers = float4(time, cos(time), sin(time / 2), cos(time / 4));
        
        float animation = saturate(sin(time / 8));
        
        float radius = 0.0025;
        
        float4 colorInsideCircle = float4(1, 0.5, 1, animation);
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
    }
    
    return float4(0);
    
};
