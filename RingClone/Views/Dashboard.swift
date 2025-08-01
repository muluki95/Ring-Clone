//
//  Dashboard.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/15/25.
//
 
import SwiftUI

struct Dashboard: View {
    @StateObject var notificationVM = NotificationViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack( spacing: 8){
                    NavigationLink(destination: NotificationList(viewModel: notificationVM)) {
                        VStack(spacing: 8){
                            Image(systemName: "play.circle")
                                .font(.system(size:30))
                            Text("Neighbors")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        
                        .font(.headline)
                        .padding()
                        .frame(width: 100,height: 100)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                        NavigationLink(destination: NotificationList(viewModel: notificationVM)) {
                            VStack(spacing: 8){
                                Image(systemName: "play.circle")
                                    .font(.system(size:30))
                                Text("History")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                                .font(.headline)
                                .padding()
                                .frame(width: 100,height: 100)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        
                    }
                    NavigationLink(destination: NotificationList(viewModel: notificationVM)) {
                        VStack(spacing: 8){
                            Image(systemName: "play.circle")
                                .font(.system(size:30))
                            Text("Edit")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .font(.headline)
                        .padding()
                        .frame(width: 100,height: 100)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    
                    
                }
                
                
                Spacer()
                
                
                
                
                
                
                
                SimulatedVideoView(videoName: "sample"){
                    notificationVM.addNotification()
                    //print("Person detected in video!")
                }
                .frame(height: 250)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(12)
                
                Spacer()
            }
            
        }
        
    }
}
#Preview {
    Dashboard()
}
