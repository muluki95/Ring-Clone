//
//  SimulatedMotionCameraView.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/19/25.
//

import SwiftUI
import UIKit

struct SimulatedVideoView: UIViewControllerRepresentable {
   
    
   
        let onPersonDetected: () -> Void
        
        
      func makeUIViewController(context: Context) -> SimulatedVideoViewController {
            let controller = SimulatedVideoViewController()
            controller.viewModel.onPersonDetected = onPersonDetected
            return controller
        }
      func updateUIViewController(_ uiViewController: SimulatedVideoViewController, context: Context) {
    
    }
    
}
