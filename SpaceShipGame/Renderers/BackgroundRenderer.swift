//
//  BackgroundRenderer.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

import MetalKit

class BackgroundRenderer {
    
    private var pipelineState: MTLRenderPipelineState?
    private var depthStencilState: MTLDepthStencilState?
    
    var gameScene: GameScene
    
    private var elapsedTime: Float = 0
    
    init(gameScene: GameScene, device: MTLDevice?) {
        
        self.gameScene = gameScene
        setupPipelineState(with: device)
        setupDepthStencilState(with: device)
    }
    
    private func setupPipelineState(with device: MTLDevice?) {
        
        guard let device = device else { return }
        
        guard let library = device.makeDefaultLibrary() else { return }
        let vertex = library.makeFunction(name: "backgroundVertex")
        let fragment = library.makeFunction(name: "backgroundFragment")
        
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
    
    private func setupDepthStencilState(with device: MTLDevice?) {
        
        guard let device = device else { return }
        
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilDescriptor.isDepthWriteEnabled = false
        self.depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    private func textureDescriptor() {
        let descriptor = MTLTextureDescriptor()
       
    }
    
    func render(commandEncoder: MTLRenderCommandEncoder, uniform: Uniform, time: Float) {
        
        guard let pipelineState = pipelineState,
              let depthStencilState = depthStencilState
        else {
            return
        }
        
        commandEncoder.setRenderPipelineState(pipelineState)
        commandEncoder.setDepthStencilState(depthStencilState)
        
        var uniform = uniform
        
        uniform.modelMatrix = matrix_identity_float4x4
        
        elapsedTime += time
        
        commandEncoder.setVertexBuffer(gameScene.backgroundModel.vertexBuffer, offset: 0, index: BackgroundVertexIndex.index)
        commandEncoder.setVertexBytes(&uniform, length: MemoryLayout<Uniform>.size, index: UniformIndex.index)
        commandEncoder.setVertexBytes(&elapsedTime, length: MemoryLayout<Float>.size, index: TimeIndex.index)
        
        commandEncoder.setFragmentTexture(gameScene.backgroundTexture, index: BackgroundTextureIndex.index)
        
        guard let indexBuffer = gameScene.backgroundModel.indexBuffer else { return }
        
        commandEncoder.drawIndexedPrimitives(
            type: .triangle,
            indexCount: gameScene.backgroundModel.indices.count,
            indexType: .uint16,
            indexBuffer: indexBuffer,
            indexBufferOffset: 0)
    }
}
