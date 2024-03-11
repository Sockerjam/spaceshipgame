//
//  Quad.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import MetalKit

class Quad {
    
    var vertices: [Vertex] = []
    
    let indices: [UInt16] = [
        0, 2, 3,
        0, 1, 2
    ]
    
    var vertexBuffer: MTLBuffer?
    var indexBuffer: MTLBuffer?
    
    init(depth: Float, device: MTLDevice?) {
        
        vertices = [
            Vertex(position: Position(x: -1, y: 1, z: depth), textureCoordinate: [0, 1]),
            Vertex(position: Position(x: 1, y: 1, z: depth), textureCoordinate: [1, 1]),
            Vertex(position: Position(x: 1, y: -1, z: depth), textureCoordinate: [1, 0]),
            Vertex(position: Position(x: -1, y: -1, z: depth), textureCoordinate: [0, 0])
            ]
        
        guard let device = device,
              let vertexBuffer = device.makeBuffer(bytes: &vertices, length: MemoryLayout<Vertex>.stride * vertices.count),
              let indexBuffer = device.makeBuffer(bytes: &indices, length: MemoryLayout<UInt16>.stride * indices.count)
        else {
            return
        }
        
        self.vertexBuffer = vertexBuffer
        self.indexBuffer = indexBuffer
        
    }
    
    
}
