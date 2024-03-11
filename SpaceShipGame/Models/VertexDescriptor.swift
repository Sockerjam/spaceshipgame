//
//  VertexDescriptor.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import MetalKit

extension MDLVertexDescriptor {
    
    static var mdlVertexDescriptor: MDLVertexDescriptor {
        
        let descriptor = MDLVertexDescriptor()
        
        var offset = 0
                
        descriptor.attributes[0] = MDLVertexAttribute(
            name: MDLVertexAttributePosition,
            format: .float3,
            offset: 0,
            bufferIndex: 0)
        
        offset += MemoryLayout<SIMD3<Float>>.stride
        
        descriptor.attributes[1] = MDLVertexAttribute(
            name: MDLVertexAttributeNormal,
            format: .float3,
            offset: offset,
            bufferIndex: 0)
        
        offset += MemoryLayout<SIMD3<Float>>.stride
        
        descriptor.attributes[2] = MDLVertexAttribute(
            name: MDLVertexAttributeTextureCoordinate,
            format: .float2,
            offset: offset,
            bufferIndex: 0)
        
        offset += MemoryLayout<SIMD2<Float>>.stride

        descriptor.layouts[0] = MDLVertexBufferLayout(stride: offset)
        
        return descriptor
    }
}

extension MTLVertexDescriptor {
    
    static var mtlVertexDescriptor: MTLVertexDescriptor {
        
        let descriptor = MTLVertexDescriptor()
        
        descriptor.attributes[0].format = .float3
        descriptor.attributes[0].offset = 0
        descriptor.attributes[0].bufferIndex = 0
        
        descriptor.attributes[1].format = .float2
        descriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
        descriptor.attributes[1].bufferIndex = 0
        
        descriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride + MemoryLayout<SIMD2<Float>>.stride
        
        return descriptor
    }
    
}

extension BufferIndices {
    
    var index: Int {
        Int(self.rawValue)
    }
}
