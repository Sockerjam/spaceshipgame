//
//  StaticCamera.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

import Foundation

class StaticCamera {
    
    private var aspectRatio: Float = 1
    private let fov = Float(70).degreesToRadians
    private let near: Float = 0.01
    private let far: Float = 100
    
    var viewMatrix: float4x4 {
        float4x4(translation: [0, 0, -3]).inverse
    }
    
    var projectionMatrix: float4x4 {
        float4x4(projectionFov: fov, near: near, far: far, aspect: aspectRatio)
    }
    
    func update(size: CGSize) {
        aspectRatio = Float(size.width / size.height)
    }
}
