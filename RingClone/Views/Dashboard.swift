import SwiftUI
import Foundation

struct Dashboard: View {
    @ObservedObject var notificationVM: NotificationViewModel
    @ObservedObject var detectionVM: PersonDetectionViewModel
    
    @State var url: URL? = Bundle.main.url(forResource: "sample", withExtension: "mp4")
    
    var body: some View {
        TabView {
            if let videoURL = url {
                SimulatedVideoView(videoURL: videoURL, detectionVM: detectionVM)
                    .tabItem {
                        Label("Live", systemImage: "video")
                    }
            }

            HistoryView(notificationVM: notificationVM)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
        .onAppear {
            guard !ProcessInfo.processInfo.isPreview else { return }
            if let videoURL = url {
                            notificationVM.addNotification(
                                title: "Motion detected",
                                location: "Garage",
                                videoURL: videoURL)
                
                Task {
                    do {
                        try await detectionVM.detectPersonInVideo(url: videoURL)
                    } catch {
                        print("Detection failed: \(error.localizedDescription)")
                    }
                }
            } else {
                print("❌ Failed to load video URL.")
            }
        }
    }
}

#Preview {
    let mockVM = NotificationViewModel()
    if let videoURL = Bundle.main.url(forResource: "sample", withExtension: "mp4") {
        mockVM.addNotification(
            title: "Preview Motion",
            location: "Garage",
            videoURL: videoURL
        )
        
        class MockDetectionVM: PersonDetectionViewModel {
            override func detectPersonInVideo(url: URL) async throws {
                await MainActor.run {
                    self.isDetected = true
                    self.addNotification(videoURL: url)
                }
            }
        }
        
        let mockDetectionVM = MockDetectionVM(notificationVM: mockVM)
        
        return Dashboard(notificationVM: mockVM, detectionVM: mockDetectionVM)
    } else {
        return Text(" sample.mp4 not found in bundle")
    }
}
