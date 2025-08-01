//
//  NptificationViewModel.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/23/25.
//

import SwiftUI


class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    
    
    func addNotification(id: String = UUID().uuidString,
                         title: String = "Motion Detected",
                         location: String = "Front Door",
                         videoURL: URL = Bundle.main.url(forResource: "sample", withExtension: "mp4")!,
                         message: String = "A person was detected",
                         timestamp: Date = Date()){
        let newNotification = NotificationItem(
            id: UUID(),
            title: title,
            location: location,
            timestamp: timestamp,
            videoURL: videoURL,
            message: message,
            
            
        )
        notifications.insert(newNotification, at: 0)
        
    }
}
