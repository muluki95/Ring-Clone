//
//  NptificationViewModel.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/23/25.
//

import SwiftUI


class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    
    
    func addNotification(id: String, title: String, location: String, videoURL: URL, message: String, timestamp: Date){
        let newNotification = NotificationItem(
            id: UUID(),
            title: title,
            location: location,
            timestamp: timestamp,
            videoURL: videoURL,
            message: message,
            
            
        )
        notifications.append(newNotification)
        
    }
}
