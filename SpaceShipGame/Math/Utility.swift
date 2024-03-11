//
//  Utility.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

import Foundation
import simd


extension Float {
    
    var degreesToRadians: Float {
        self * Float.pi / 180
    }
}

extension float4x4 {
    
    init(translation: SIMD3<Float>) {
        let matrix = float4x4(
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [translation.x, translation.y, translation.z, 1]
        )
        
        self = matrix
    }
    
    init(rotation: SIMD3<Float>) {
        let rotationX = float4x4(rotationX: rotation.x)
        let rotationY = float4x4(rotationY: rotation.y)
        let rotationZ = float4x4(rotationZ: rotation.z)
        self = rotationZ * rotationY * rotationX
    }
    
    init(rotationY: Float) {
        let matrix = float4x4(
            [cos(rotationY), 0, -sin(rotationY), 0],
            [0,              1, 0,               0],
            [sin(rotationY), 0, cos(rotationY),  0],
            [0,              0, 0,               1]
        )
        
        self = matrix
    }
    
    init(rotationX: Float) {
        let matrix = float4x4(
            [1, 0,              0,               0],
            [0, cos(rotationX), sin(rotationX), 0],
            [0, -sin(rotationX), cos(rotationX),  0],
            [0, 0,              0,               1]
        )
        
        self = matrix
    }
    
    init(rotationZ: Float) {
        let matrix = float4x4(
            [cos(rotationZ), -sin(rotationZ), 0, 0],
            [sin(rotationZ), cos(rotationZ), 0,  0],
            [0,              0,             1,   0],
            [0,              0,             0,   1]
        )
        
        self = matrix
    }
    
    init(scale: SIMD3<Float>) {
        let matrix = float4x4(
            [scale.x, 0, 0, 0],
            [0, scale.y, 0, 0],
            [0, 0, scale.z, 0],
            [0, 0, 0, 1]
        )
        
        self = matrix
    }
    
    init(orthographic rect: CGRect, near: Float, far: Float) {
        let left = Float(rect.origin.x)
        let right = Float(rect.origin.x + rect.width)
        let top = Float(rect.origin.y)
        let bottom = Float(rect.origin.y - rect.height)
        let X = SIMD4<Float>(2 / (right - left), 0, 0, 0)
        let Y = SIMD4<Float>(0, 2 / (top - bottom), 0, 0)
        let Z = SIMD4<Float>(0, 0, 1 / (far - near), 0)
        let W = SIMD4<Float>(
            (left + right) / (left - right),
            (top + bottom) / (bottom - top),
            near / (near - far),
            1)
        self.init()
        columns = (X, Y, Z, W)
    }
    
    // MARK: - Left handed projection matrix
    init(projectionFov fov: Float, near: Float, far: Float, aspect: Float, lhs: Bool = true) {
        let y = 1 / tan(fov * 0.5)
        let x = y / aspect
        let z = lhs ? far / (far - near) : far / (near - far)
        let X = SIMD4<Float>( x,  0,  0,  0)
        let Y = SIMD4<Float>( 0,  y,  0,  0)
        let Z = lhs ? SIMD4<Float>( 0,  0,  z, 1) : SIMD4<Float>( 0,  0,  z, -1)
        let W = lhs ? SIMD4<Float>( 0,  0,  z * -near,  0) : SIMD4<Float>( 0,  0,  z * near,  0)
        self.init()
        columns = (X, Y, Z, W)
    }
    
    // For normal model matrix
    var upperleft: float3x3 {
        float3x3(
            [self.columns.0.x, self.columns.0.y, self.columns.0.z],
            [self.columns.1.x, self.columns.1.y, self.columns.1.z],
            [self.columns.2.x, self.columns.2.y, self.columns.2.z]
        )
    }
    
}
