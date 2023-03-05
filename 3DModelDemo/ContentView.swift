//
//  ContentView.swift
//  3DModelDemo
//
//  Created by Ho Si Tuan on 03/03/2023.
//

import SwiftUI
import Model3DView
import Combine
import SocketIO

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    var body: some View {
        
        VStack {
            Button {
                DemoSocketManager.shared.connectSocket()
                subsribe()
            } label: {
                Text("Connect Socket")
            }

            Button {
                viewModel.camera = OrthographicCamera()
            } label: {
                Text("Rotate")
            }
            
            Model3DView(named: "SubTool-0-8302662.OBJ")
                .cameraControls(OrbitControls(
                    camera: $viewModel.camera,
                    sensitivity: 0.5,
                    friction: 0.1
                ))
//            Model3DView(named: "SubTool-0-8302662.OBJ")
//                .cameraControls(OrbitControls(
//                    camera: $viewModel.camera2,
//                    sensitivity: 0.5,
//                    friction: 0.1
//                ))
            
        }
        .onAppear {
            viewModel.subsribe()
            
        }
    }
    
    func subsribe() {
        DemoSocketManager.shared.socket.on("syncPosition") { data, ack in
            guard let dataInfo = data.first as? [String: Any], let json = dataInfo.jsonStringRepresentation  else { return }
            do {
                let result = try JSONDecoder().decode(CameraResponse.self, from: json)
                print(result)
                self.viewModel.camera = result.toCamera()
            }
            catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    class ViewModel: ObservableObject {
        @Published var camera = OrthographicCamera()
        @Published var camera2 = OrthographicCamera()
        var subscription = Set<AnyCancellable>()
        func subsribe() {
            $camera
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .sink { value in
                    print(value.position)
                    print(value.rotation)
                    print(value.near)
                    print(value.scale)
//                    self.camera2 = value
                }.store(in: &subscription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
