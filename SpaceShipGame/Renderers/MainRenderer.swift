//
//  MainRenderer.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import MetalKit

enum DeviceError: Error {
    case noDeviceOrCommandQueue
}

class MainRenderer: NSObject {
    
    static var device: MTLDevice?
    static var commandQueue: MTLCommandQueue?
    
    private var gameScene: GameScene
    private var backgroundRenderer: BackgroundRenderer
    private var midgroundRenderer: MidgroundRenderer
    
    private var uniform = Uniform()
    private var startTime: Double = CFAbsoluteTimeGetCurrent()
    
    init(metalView: MTKView) throws {
        
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue()
        else {
            throw DeviceError.noDeviceOrCommandQueue
        }
        
        MainRenderer.device = device
        MainRenderer.commandQueue = commandQueue
        
        self.gameScene = GameScene()
        self.backgroundRenderer = BackgroundRenderer(gameScene: gameScene, device: MainRenderer.device)
        self.midgroundRenderer = MidgroundRenderer(gameScene: gameScene, device: MainRenderer.device)
        
        super.init()
        metalView.depthStencilPixelFormat = .depth32Float
        metalView.device = MainRenderer.device
        metalView.delegate = self
        mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
    }
    
}

extension MainRenderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
        gameScene.update(size: size)
    }
    
    func draw(in view: MTKView) {
        
        guard let commandBuffer = MainRenderer.commandQueue?.makeCommandBuffer(),
              let renderPassDescriptor = view.currentRenderPassDescriptor
        else {
            print("draw(in_:) error")
            return
        }
        
        guard  let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else { return }
        
        let currentTime = CFAbsoluteTimeGetCurrent()
        let deltaTime = Float(currentTime - startTime)
        startTime = currentTime
        
        gameScene.update(time: deltaTime)
        
        uniform.viewMatrix = gameScene.staticCamera.viewMatrix
        uniform.projectionMatrix = gameScene.staticCamera.orthographicMatrix
        
        backgroundRenderer.render(commandEncoder: commandEncoder, uniform: uniform, time: deltaTime)
        
        midgroundRenderer.render(commandEncoder: commandEncoder, uniform: uniform, time: deltaTime)
        
        commandEncoder.endEncoding()
        guard let drawable = view.currentDrawable else { return }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
