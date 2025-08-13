//
//  PreviewHelper.swift
//  RingClone
//
//  Created by Esther Nzomo on 8/12/25.
//

import Foundation

extension ProcessInfo {
    //Returns true if app is runninf in preview mode
    var isPreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    // Returns true if app is running is ios simulator
    var isSimulator: Bool {
                environment["SIMULATOR_DEVICE_NAME"] != nil
            }
    
}
