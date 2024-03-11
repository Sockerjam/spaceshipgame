//
//  StaticCamera.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

import Foundation

class StaticCamera {
    
    var aspect: CGFloat = 1
    var viewSize: CGFloat = 10
    var near: Float = 0.1
    var far: Float = 10
    
    var viewMatrix: float4x4 {
        return float4x4(translation: [0, 0, 0]).inverse
    }
    
    var orthographicMatrix: float4x4 {
        let rect = CGRect(x: -viewSize * aspect * 0.5, y: viewSize * 0.5, width: viewSize * aspect, height: viewSize)
        return float4x4(orthographic: rect, near: near, far: far)
    }
    
    var projectionMatrix: float4x4 {
        float4x4(projectionFov: Float(70).degreesToRadians, near: 0.1, far: 10, aspect: Float(aspect))
    }
    
    func update(size: CGSize) {
        aspect = size.width / size.height
    }
}
