//
//  SceneKitUIKit.swift
//  3DModelDemo
//
//  Created by Ho Si Tuan on 04/03/2023.
//

import Foundation
//struct SceneKitView: UIViewRepresentable {
//    typealias UIViewType = SCNView
//    @Binding var rotation: SCNVector3
//
//    func makeUIView(context: Context) -> SCNView {
//        let sceneView = SCNView()
//        sceneView.scene = SCNScene(named: "SubTool-0-8302662.OBJ")!
//        sceneView.allowsCameraControl = true
//        sceneView.autoenablesDefaultLighting = true
//        sceneView.backgroundColor = UIColor.white
//        sceneView.frame = CGRect(x: 0, y: 10, width: 0, height: 1)
//        sceneView.delegate = context.coordinator
//        return sceneView
//    }
//
//    func updateUIView(_ sceneView: SCNView, context: UIViewRepresentableContext<SceneKitView>) {
//
//    }
//
//
//    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
//        print(renderer.pointOfView?.position ?? "")
//        print(renderer.pointOfView?.rotation ?? "")
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    final class Coordinator: NSObject, SCNSceneRendererDelegate {
//        var control: SceneKitView
//
//        init(_ control: SceneKitView) {
//            self.control = control
//        }
//
//        func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
//            control.renderer(renderer, didRenderScene: scene, atTime: time)
//        }
//    }
//}
