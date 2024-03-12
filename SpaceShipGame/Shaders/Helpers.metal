//
//  Helpers.metal
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 05/03/2024.
//

#include <metal_stdlib>
#include "Helpers.h"

using namespace metal;


float2 rotateUV(float2 uv)
{
    float2x2 matrix (cos(M_PI_2_F), -sin(M_PI_2_F),
                     sin(M_PI_2_F), cos(M_PI_2_F));
    
    return matrix * uv;
};

float4x4 rotatePlanet(float angle)
{
 
    float4x4 rotateX = float4x4(1, 0,          0,          0,
                                0, cos(angle), sin(angle), 0,
                                0, -sin(angle), cos(angle), 0,
                                0, 0,           0,          1
                                );
    
    float4x4 rotateY = float4x4(cos(angle), 0, -sin(angle), 0,
                                0,          1, 0,           0,
                                sin(angle), 0, cos(angle),  0,
                                0,          0, 0,           1
                                );
    
    return rotateX * rotateY;
};
