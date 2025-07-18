//
//  NotificationTest.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/18/25.
//
import XCTest
@testable import RingClone

class NotificationTest: XCTestCase {
    func testDecodeNotificationJSON() {
        guard let url = Bundle(for:type(of:self)).url(forResource: "notification", withExtension: "json") else {
            XCTFail("Missing file: notification.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            
            let notification = try decoder.decode([NotificationItem].self, from: data)
            guard let notification = notification.first else {
                XCTFail("No notification found in JSON")
                return
            }
            XCTAssertEqual(notification.title, "Motion detected")
            XCTAssertEqual(notification.location, "Front Door")
            XCTAssertEqual(notification.message, "Call me back, I couldn't reach your phone.")
            XCTAssertEqual(notification.videoURL,URL(string: "https://example.com/videos/motion_2025_07_18.mp4"))
            
            let expectedDate = ISO8601DateFormatter().date(from:"2025-07-18T14:45:00Z")
            XCTAssertEqual(notification.timestamp, expectedDate)
            
        }catch {
            XCTFail("Failed to decode Notification:\(error)")
            
        }
    }
}
