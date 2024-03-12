//
//  Helpers.metal
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 05/03/2024.
//

#include <metal_stdlib>
#include "Helpers.h"
#include "Common.h"

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

float3 phongLighting(float3 baseColor, float3 normal, constant Light *light)
{
    
    float3 sunLightDirection = normalize(-light->position);
    
    float dotProduct = saturate(-dot(sunLightDirection, normal));
    
    return baseColor * dotProduct;
    
};

// Simple hash function to create pseudorandomness
float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

// Generate a random color based on the baseColor
float3 randomColor(float3 baseColor) {
    // Combine and hash the baseColor components to get a pseudorandom value
    float n = hash(baseColor.x + baseColor.y * 1.1 + baseColor.z * 1.3);
    
    // Use the hashed value to modulate the baseColor
    float3 modColor = float3(hash(n + 0.1), hash(n + 0.2), hash(n + 0.3));
    
    // Mix the modulated color with the baseColor to get the final color
    // Adjust the mixing ratio as needed
    float mixRatio = 0.5; // Adjust this value to get more or less of the original color
    float3 finalColor = mix(baseColor, modColor, mixRatio);
    
    return finalColor;
}
