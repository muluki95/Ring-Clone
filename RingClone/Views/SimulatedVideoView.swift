//
//  SimulatedMotionCameraView.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/19/25.
//

import SwiftUI
import AVKit

struct SimulatedVideoView: View {
    let videoURL: URL
    @ObservedObject var detectionVM: PersonDetectionViewModel
    
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(url: videoURL))
                .frame(height: 250)
                .onAppear {
                    guard !ProcessInfo.processInfo.isPreview else { return }
                    Task {
                        do{
                            try await detectionVM.detectPersonInVideo(url: videoURL)
                        } catch {
                            print("Detection failed: \(error.localizedDescription)")
                        }
                    }
                }
            
            if detectionVM.isDetected {
                Text("Person detected.")
                    .foregroundColor(.green)
            } else {
                Text("Scanning for person...")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
