//
//  NotificationList.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/16/25.
//

import SwiftUI


struct HistoryView: View {
    
    @ObservedObject var notificationVM: NotificationViewModel
    
    var body: some View {
       
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: 0) {
                    ForEach(notificationVM.notifications){ notification in NotificationRow(notification: notification)
                        
                    }
                    
                }
            }
            
         }
        .navigationTitle ("Notifications")
        }
    }









