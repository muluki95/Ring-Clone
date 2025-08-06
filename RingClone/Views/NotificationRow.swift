//
//  NotificationRow.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/16/25.
//

import SwiftUI
import AVKit


struct NotificationRow: View {
    
    let notification : NotificationItem
    
    var body: some View {
        NavigationStack{
            HStack(alignment: .top){
                
                    //Image(systemName: "person")
                
                VStack(alignment: .leading, spacing: 6){
                    Text(notification.title)
                        .font(.headline)
                    
                    Text(notification.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    VideoPlayer(player: AVPlayer(url: notification.videoURL))
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    
                    
                    if let message = notification.message,
                       !message.isEmpty {
                        Text("Message: \(message)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                        
                }
                .padding(.leading, 16)
                Spacer()
                
                
                VStack (alignment: . trailing){
                    Text("...")
                    Text(notification.timestamp.formatted())
                    
                }
                .padding(.trailing, 14)
            }
            .padding()
            Divider()
            
        }
        .navigationTitle("History")
    }
}



