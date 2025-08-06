import SwiftUI

struct Dashboard: View {
    @StateObject var viewModel = NotificationViewModel()
    @StateObject var detectionVM = PersonDetectionViewModel()
    
    @State private var url: URL? = Bundle.main.url(forResource: "sample", withExtension: "mp4")
    
    var body: some View {
        TabView {
            if let videoURL = url {
                SimulatedVideoView(videoURL: videoURL, detectionVM: detectionVM)
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
            if let videoURL = url {
                detectionVM.notificationVM = viewModel

                detectionVM.notificationVM?.addNotification(
                    title: "Motion detected",
                    location: "Garage",
                    videoURL: videoURL
                )
                
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
    Dashboard()
}
