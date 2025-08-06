//
//  NptificationViewModel.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/23/25.
//

import SwiftUI


class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = []
    
    
    func addNotification(title: String,location: String, videoURL: URL ){
        let newNotification = NotificationItem(id: UUID(), title: title, location: location, timestamp:Date() , videoURL: videoURL, message: "")
        notifications.append(newNotification)
        
    }
}
