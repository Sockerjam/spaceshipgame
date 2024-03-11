//
//  Vertex.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import Foundation
import simd

struct Position {
    let x: Float
    let y: Float
    let z: Float
}

struct Vertex {
    
    let position: Position
    let textureCoordinate: SIMD2<Float>
}
