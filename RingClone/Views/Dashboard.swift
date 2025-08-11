import SwiftUI

struct Dashboard: View {
    @ObservedObject var notificationVM: NotificationViewModel
    @ObservedObject var detectionVM: PersonDetectionViewModel
    
    @State private var url: URL? = Bundle.main.url(forResource: "sample", withExtension: "mp4")
    
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
    let notificationVM = NotificationViewModel()
    let detectionVM = PersonDetectionViewModel(notificationVM: notificationVM)
    Dashboard(notificationVM: notificationVM, detectionVM: detectionVM)
}

