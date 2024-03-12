//
//  ForegroundRenderer.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 11/03/2024.
//

import MetalKit

class ForegroundRenderer: Renderer {
    
    override func setupPipelineState(with device: MTLDevice?) {
        
        guard let device = device else { return }
        
        guard let library = device.makeDefaultLibrary() else { return }
        let vertex = library.makeFunction(name: "foregroundVertex")
        let fragment = library.makeFunction(name: "foregroundFragment")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertex
        pipelineDescriptor.fragmentFunction = fragment
        pipelineDescriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(.mdlVertexDescriptor)
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
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilDescriptor.isDepthWriteEnabled = true
        self.depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder, uniform: Uniform, elapsedTime: Float) {
        
        guard let pipelineState = pipelineState,
              let depthStencilState = depthStencilState
        else {
            return
        }
        
        commandEncoder.setRenderPipelineState(pipelineState)
        commandEncoder.setDepthStencilState(depthStencilState)
        
        gameScene.foregroundModel.render(commandEncoder: commandEncoder, uniform: uniform, time: elapsedTime)
    }
}
