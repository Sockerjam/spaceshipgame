//
//  Model.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import MetalKit

class Model {
    
    var transform: Transform = Transform()
    var mtkMesh: MTKMesh?
    var materialProperties: [MaterialProperty] = []
    
    init(fileName: String, device: MTLDevice?) {
        
        guard let device = device else { return }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "obj") else {
            fatalError("File deosn't exist")
        }
        
        let allocator = MTKMeshBufferAllocator(device: device)
        
        let asset = MDLAsset(url: url, vertexDescriptor: .mdlVertexDescriptor, bufferAllocator: allocator)
        
        if let modelMesh = asset.childObjects(of: MDLMesh.self).first as? MDLMesh {
            
            do {
                mtkMesh = try MTKMesh(mesh: modelMesh, device: device)
                loadMaterial(mdlMesh: modelMesh, device: device)
            } catch {
                print("MTK Mesh Error")
            }
        }
        
    }
    
    func loadMaterial(mdlMesh: MDLMesh, device: MTLDevice) {
        
        guard let submeshes = mdlMesh.submeshes as? [MDLSubmesh] else { return }
        
        for submesh in submeshes {
            guard let material = submesh.material else { return }
            
            var materialProperty = MaterialProperty(baseColorTexture: nil)
            
            guard
                let baseColorProperty = material.property(with: .baseColor),
                baseColorProperty.type == .string,
                let texturePath = baseColorProperty.stringValue,
                let textureURL = URL(string: texturePath)
            else {
                return
            }
            
            let texture = TextureLoader.texture(from: textureURL.absoluteString, device: device)
            
            materialProperty.baseColorTexture = texture
            
            self.materialProperties.append(materialProperty)
            
        }
    }
    
}

extension Model {
    
    func render(commandEncoder: MTLRenderCommandEncoder, uniform: Uniform, time: Float) {
        
        guard let mtkMesh = mtkMesh else { return }
        
        var uniform = uniform
        uniform.modelMatrix = transform.modelMatrix
        
        var time = time
        
        commandEncoder.setVertexBytes(&uniform, length: MemoryLayout<Uniform>.size, index: UniformIndex.index)
        commandEncoder.setVertexBytes(&time, length: MemoryLayout<Float>.size, index: TimeIndex.index)
        
        for (index, meshBuffer) in mtkMesh.vertexBuffers.enumerated() {
            commandEncoder.setVertexBuffer(meshBuffer.buffer, offset: 0, index: index)
        }
        
        for material in materialProperties {
            
            commandEncoder.setFragmentTexture(material.baseColorTexture, index: ForegroundTextureIndex.index)
        }
        
        for submesh in mtkMesh.submeshes {
            commandEncoder.drawIndexedPrimitives(
                type: .triangle,
                indexCount: submesh.indexCount,
                indexType: submesh.indexType,
                indexBuffer: submesh.indexBuffer.buffer,
                indexBufferOffset: submesh.indexBuffer.offset)
        }
    }
}
