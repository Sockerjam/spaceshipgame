//
//  Model.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import MetalKit

class Model {
    
    // TODO: Remove optional and initialise below
    var mtkMesh: MTKMesh?
    
    init(fileName: String, device: MTLDevice) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "obj") else {
            fatalError("File deosn't exist")
        }
        
    }
    
}
