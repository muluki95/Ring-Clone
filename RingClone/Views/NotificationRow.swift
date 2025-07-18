//
//  NotificationRow.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/16/25.
//

import SwiftUI


struct NotificationRow: View {
    var body: some View {
        NavigationStack{
            HStack(alignment: .top){
                
                    Image(systemName: "person")
                
                VStack(alignment: .leading, spacing: 6){
                    Text("Person Detected")
                    Text("Front Door")
                    Image(systemName:"person")
                        
                }
                .padding(.leading, 16)
                Spacer()
                
                
                VStack (alignment: . trailing){
                    Text("...")
                    Text("11.46am")
                    
                }
                .padding(.trailing, 14)
            }
            .padding()
            Divider()
            
        }
        .navigationTitle("History")
    }
}


#Preview {
    NotificationRow()
}
