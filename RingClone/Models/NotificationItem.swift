//
//  NotificationItem.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/16/25.
//


import Foundation


struct NotificationItem: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let location: String
    let timestamp: Date
    let videoURL: URL
    var message: String?
}
