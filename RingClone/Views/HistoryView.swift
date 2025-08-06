//
//  NotificationList.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/16/25.
//

import SwiftUI


struct HistoryView: View {
    
    @ObservedObject var viewModel: NotificationViewModel
    
    var body: some View {
       
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.notifications){ notification in NotificationRow(notification: notification)
                        
                    }
                    
                }
            }
            
         }
        .navigationTitle ("Notifications")
        }
    }









