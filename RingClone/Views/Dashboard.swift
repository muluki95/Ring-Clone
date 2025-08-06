//
//  Dashboard.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/15/25.
//
 
import SwiftUI

struct Dashboard: View {
    @StateObject var viewModel = NotificationViewModel()
    @StateObject var detectionVM = PersonDetectionViewModel()
    
    
    let simulatedVideoURL = Bundle.main.url(forResource: "sample", withExtension: "mp4")
    
    var body: some View {
        TabView {
            if let url = simulatedVideoURL {
                            SimulatedVideoView(videoURL: url, detectionVM: detectionVM)
                                .tabItem {
                                    Label("Live", systemImage: "video")
                                }
                        }
            HistoryView(viewModel: viewModel)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
        .onAppear {
            detectionVM.notificationVM = viewModel
        }
    }
}
    
#Preview {
    Dashboard()
}
