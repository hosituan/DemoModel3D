//
//  SocketManager.swift
//  3DModelDemo
//
//  Created by Ho Si Tuan on 04/03/2023.
//

import Foundation
import SocketIO
import Model3DView
import UIKit


import Foundation
extension Dictionary {
    var jsonStringRepresentation: Data? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                              options: [.prettyPrinted]) else {
            return nil
        }
        
        return theJSONData
    }
}

struct CameraResponse: Codable {
    var position: Vector3Codable?
    var rotation: Vector3Codable?
    var near: Float?
    var far: Float?
    var scale: Float?
    
    init(position: Vector3, rotation: Euler, near: Float, far: Float, scale: Float) {
        self.position = Vector3Codable(x: position.x, y: position.y, z: position.z)
        self.rotation = Vector3Codable(x: Float(rotation.x.degrees), y: Float(rotation.y.degrees), z: Float(rotation.z.degrees))
        self.near = near
        self.far = far
        self.scale = scale
    }
    
    init(camera: OrthographicCamera) {
        self.init(position: camera.position, rotation: camera.rotation, near: camera.near, far: camera.far, scale: camera.scale)
    }
    
    var dictionary: [String: Any] {
        let dict: [String: Any] = [
            "postion": position?.dictionary ?? [:],
            "rotation": rotation?.dictionary ?? [:],
            "near": near ?? 0,
            "far": far ?? 0,
            "scale": scale ?? 0
        ]
        return dict
    }
    
    func toCamera() -> OrthographicCamera {
        return OrthographicCamera(
            position: Vector3(position?.x ?? 0, position?.y ?? 0, position?.z ?? 0),
            rotation: Euler(x: Angle.degrees(Double(rotation?.x ?? 0)), y: Angle.degrees(Double(rotation?.y ?? 0)), z: Angle.degrees(Double(rotation?.z ?? 0))),
            near: near ?? 0,
            far: far ?? 0,
            scale: scale ?? 0
        )
    }
}

struct Vector3Codable: Codable {
    var x: Float?
    var y: Float?
    var z: Float?
    var dictionary: [String: Any] {
        let dict: [String: Any] = [
            "x": x ?? 0,
            "y": y ?? 0,
            "z": z ?? 0
        ]
        return dict
    }
}
class DemoSocketManager {
    static let shared = DemoSocketManager()
    let socketManager = SocketManager(socketURL: URL(string: "https://2bf7-183-81-124-211.ap.ngrok.io")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    private init() {
        socket = socketManager.defaultSocket
    }
    
    func connectSocket() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        socketManager.connect()
    }
    
    func syncData(camera: OrthographicCamera) {
        let data = CameraResponse(camera: camera)
        socket.emit("syncPosition", with: [data.dictionary])
    }
    
    func subscribe() {
        
    }
    
    func send() {
        let data: Any = ["Position data": 1]
        socket.emit("syncPosition", with: [data])
    }
    
}



import SocketIO
import SwiftUI




