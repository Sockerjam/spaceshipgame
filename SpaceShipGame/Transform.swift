//
//  Transform.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

import Foundation
import simd

struct Transform {
    
    var translation: SIMD3<Float> = [0, 0, 0]
    var rotation: SIMD3<Float> = [0, 0, 0]
    var scale: SIMD3<Float> = [1, 1, 1]
    
    var modelMatrix: float4x4 {
        let translationMatrix = float4x4(translation: translation)
        let rotationMatrix = float4x4(rotation: rotation)
        let scale = float4x4(scale: scale)
        return translationMatrix * rotationMatrix * scale
    }
}
