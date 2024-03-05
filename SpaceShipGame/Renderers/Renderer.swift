//
//  Renderer.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 05/03/2024.
//

import MetalKit

class Renderer {
    
    var pipelineState: MTLRenderPipelineState?
    var depthStencilState: MTLDepthStencilState?
    var gameScene: GameScene
    var elapsedTime: Float = 0
    
    init(gameScene: GameScene, device: MTLDevice?) {
        
        self.gameScene = gameScene
        setupPipelineState(with: device)
        setupDepthStencilState(with: device)
    }
    
    func setupPipelineState(with: MTLDevice?) {
        fatalError("Must be overriden")
    }
    
    func setupDepthStencilState(with: MTLDevice?) {
        fatalError("Must be overriden")
    }
    
    func render(commandEncoder: MTLRenderCommandEncoder, uniform: Uniform, time: Float) {
        fatalError("Must be overriden")
    }
}
