//
//  NotificationList.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/16/25.
//

import SwiftUI


struct NotificationList: View {
    var body: some View {
       
           VStack{
                ForEach(0 ... 5, id:\.self){ item in
                    NotificationRow()
                }
            }
            .padding()
        }
    }








#Preview{
    NotificationList()
    }
