//
//  MetalView.swift
//  SpaceShipGame
//
//  Created by Niclas Jeppsson on 29/02/2024.
//

import SwiftUI
import MetalKit

struct MetalView: View {
    
    @State private var mainRenderer: MainRenderer?
    @State private var metalView = MTKView()
    
    
    var body: some View {
        VStack {
            MetalViewRepresentable(mainRenderer: $mainRenderer, metalView: $metalView)
            .onAppear {
                do {
                    mainRenderer = try MainRenderer(metalView: metalView)
                } catch {
                    print(error)
                }
            }
        }
    }
}

#if os(macOS)
typealias ViewRepresentable = NSViewRepresentable
typealias MyMetalView = NSView
#elseif os(iOS)
typealias ViewRepresentable = UIViewRepresentable
typealias MyMetalView = UIView
#endif

struct MetalViewRepresentable: ViewRepresentable {
    @Binding var mainRenderer: MainRenderer?
    @Binding var metalView: MTKView
    
    
#if os(macOS)
    func makeNSView(context: Context) -> some NSView {
        metalView
    }
    func updateNSView(_ uiView: NSViewType, context: Context) {
        updateMetalView()
    }
#elseif os(iOS)
    func makeUIView(context: Context) -> MTKView {
        metalView
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
        updateMetalView()
    }
#endif
    
    func makeMetalView(_ metalView: MyMetalView) {
    }
    
    func updateMetalView() {
    }
}
