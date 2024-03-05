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
