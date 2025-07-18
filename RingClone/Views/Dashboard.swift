//
//  Dashboard.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/15/25.
//
 
import SwiftUI

struct Dashboard: View {
    
    
    let buttonsData = [
        (icon: "person.3.fill", title: "Neighbors", subtitle: "New Posts"),
        (icon:"play.circle", title: "History", subtitle:"New Activity"),
        (icon:"doc.text", title: "What's New", subtitle:""),
        (icon:"square.and.pencil", title: "Edit", subtitle:"")
    ]
    var body: some View {
        VStack{
           HStack( spacing: 8){
                ForEach(buttonsData , id: \.title){ button in
                    Button{
                        
                    } label: {
                        VStack{
                            Image(systemName: button.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width:50, height:50)
                                .foregroundColor(.black)
                            
                            Text(button.title)
                                .foregroundColor(.black)
                                .font(.caption)
                            Text(button.subtitle)
                                .font(.caption)
                                 
                        }
                        
                        
                       
                        .frame(maxWidth: .infinity)
                        .frame(height: 110)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        
                    }
                    
                }
                
            }
           .padding(.horizontal)
           Spacer()
        }
        
    }
   
}

#Preview {
    Dashboard()
}
