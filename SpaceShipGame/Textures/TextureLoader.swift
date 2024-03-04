//
//  TextureLoader.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import MetalKit

enum TextureLoader {
    
    static var textures: [String: MTLTexture] = [:]
    
    static func loadTexture(from fileName: String, device: MTLDevice) -> MTLTexture? {
        let textureLoader = MTKTextureLoader(device: device)
        let textureOptions: [MTKTextureLoader.Option: Any] = [
            .SRGB: false,
            .origin: MTKTextureLoader.Origin.bottomLeft,
            .generateMipmaps: NSNumber(value: true)
        ]
        
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "jpg") else {
            print("Texture url not found")
            return nil
        }
        
        guard let texture = try? textureLoader.newTexture(URL: filePath, options: textureOptions) else {
            print("Texture loading failed")
            return nil
        }
        
        return texture
    }
    
    static func texture(from fileName: String, device: MTLDevice?) -> MTLTexture? {
        
        guard let device = device else { return nil }
        
        if let texture = textures[fileName] {
            return texture
        }
        
        guard let texture = loadTexture(from: fileName, device: device) else {
            return nil
        }
        
        textures[fileName] = texture
        
        return texture
        
    }
}
