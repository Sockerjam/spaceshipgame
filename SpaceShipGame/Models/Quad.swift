//
//  Quad.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import MetalKit

class Quad {
    
    let oldvertices: [OldVertex] = [
        OldVertex(position: [-1, 1, 1], textureCoordinate: [0, 1]),
        OldVertex(position: [1, 1, 1], textureCoordinate: [1, 1]),
        OldVertex(position: [1, -1, 1], textureCoordinate: [1, 0]),
        OldVertex(position: [-1, -1, 1], textureCoordinate: [0, 0])
    ]
    
    let vertices: [Vertex] = [
        Vertex(position: Position(x: -1, y: 1, z: 1), textureCoordinate: [0, 1]),
        Vertex(position: Position(x: 1, y: 1, z: 1), textureCoordinate: [1, 1]),
        Vertex(position: Position(x: 1, y: -1, z: 1), textureCoordinate: [1, 0]),
        Vertex(position: Position(x: -1, y: -1, z: 1), textureCoordinate: [0, 0])
    ]
    
    let indices: [UInt16] = [
        0, 2, 3,
        0, 1, 2
    ]
    
    var vertexBuffer: MTLBuffer?
    var indexBuffer: MTLBuffer?
    
    init(device: MTLDevice?) {
        
        guard let device = device,
              let vertexBuffer = device.makeBuffer(bytes: &vertices, length: MemoryLayout<Vertex>.stride * vertices.count),
              let indexBuffer = device.makeBuffer(bytes: &indices, length: MemoryLayout<UInt16>.stride * indices.count)
        else {
            return
        }
        
        self.vertexBuffer = vertexBuffer
        self.indexBuffer = indexBuffer
        
//        print(
//          MemoryLayout<Vertex>.stride,
//          MemoryLayout<SIMD3<Float>>.stride,
//          MemoryLayout<SIMD2<Float>>.stride,
//          MemoryLayout<SIMD3<Float>>.stride +
//                MemoryLayout<SIMD2<Float>>.stride)
        
        print(MemoryLayout<Vertex>.size, MemoryLayout<Vertex>.stride)
    }
    
    
}
