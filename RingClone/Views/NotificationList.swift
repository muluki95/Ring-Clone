//
//  NotificationList.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/16/25.
//

import SwiftUI


struct NotificationList: View {
    
    @StateObject var viewModel: NotificationViewModel
    
    var body: some View {
       
        VStack(spacing: 16){
            ForEach(viewModel.notifications.reversed()){item in
                NotificationRow(notification: item)
                
                }
            }
            .padding()
        }
    }








#Preview{
    NotificationList(viewModel: NotificationViewModel())
    }
