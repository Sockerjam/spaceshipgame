//
//  GameScene.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 01/03/2024.
//

import MetalKit

class GameScene {
    
    lazy var backgroundModel: Quad = {
        Quad(depth: 1, device: MainRenderer.device)
    }()
    
    lazy var backgroundTexture: MTLTexture? = {
        TextureLoader.texture(from: "milkywayHD", device: MainRenderer.device)
    }()
    
    lazy var midgroundModel: Quad = {
        Quad(depth: 0.9, device: MainRenderer.device)
    }()
    
    lazy var foregroundModel: Model = {
        Model(fileName: "earth", device: MainRenderer.device)
    }()
    
    let staticCamera = StaticCamera()
        
    init() {
    
    }
    
    func update(time: Float) {
        
        //TODO: Input Controller stuff
        
        
    }
    
    func update(size: CGSize) {
        
        staticCamera.update(size: size)
    }
}
