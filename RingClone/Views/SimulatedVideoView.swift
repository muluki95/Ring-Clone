//
//  SimulatedMotionCameraView.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/19/25.
//

import SwiftUI
import UIKit

struct SimulatedVideoView: UIViewControllerRepresentable {
   
    
    let videoName: String
        let onPersonDetected: () -> Void
        
        
      func makeUIViewController(context: Context) -> SimulatedVideoViewController {
            let controller = SimulatedVideoViewController()
            controller.viewModel.videoName = videoName
            controller.viewModel.onPersonDetected = onPersonDetected
            return controller
        }
      func updateUIViewController(_ uiViewController: SimulatedVideoViewController, context: Context) {
    
    }
    
}
