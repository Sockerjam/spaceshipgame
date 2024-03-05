//
//  MidgroundRenderer.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 05/03/2024.
//

import MetalKit

class MidgroundRenderer: Renderer {
    
    override func setupPipelineState(with device: MTLDevice?) {
        
        guard let device = device else { return }
        
        guard let library = device.makeDefaultLibrary() else { return }
        let vertex = library.makeFunction(name: "midgroundVertex")
        let fragment = library.makeFunction(name: "midgroundFragment")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertex
        pipelineDescriptor.fragmentFunction = fragment
        pipelineDescriptor.vertexDescriptor = .mtlVertexDescriptor
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        
        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            print("Couldn't create pipeline state")
            return
        }
    }
    
    override func setupDepthStencilState(with device: MTLDevice?) {
        
        guard let device = device else { return }
        
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.depthCompareFunction = .greaterEqual
        depthStencilDescriptor.isDepthWriteEnabled = false
        self.depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, uniform: Uniform, time: Float) {
    }
}
