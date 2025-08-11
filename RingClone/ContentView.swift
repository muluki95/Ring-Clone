





import SwiftUI

struct ContentView: View {
    // Create your shared view models here
    @StateObject private var notificationVM: NotificationViewModel
    @StateObject private var detectionVM: PersonDetectionViewModel

    init() {
        // Initialize detectionVM with notificationVM dependency
        let notifVM = NotificationViewModel()
        _notificationVM = StateObject(wrappedValue: notifVM)
        _detectionVM = StateObject(wrappedValue: PersonDetectionViewModel(notificationVM: notifVM))
    }

    var body: some View {
        Dashboard(notificationVM: notificationVM,detectionVM: detectionVM)
    }
}

#Preview {
    ContentView()
}
