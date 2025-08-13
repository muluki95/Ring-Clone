import Foundation
import Vision
import AVFoundation
import UIKit

class PersonDetectionViewModel: ObservableObject {
    @Published var isDetected = false
    @Published var notifications: [NotificationItem] = []
    var notificationVM: NotificationViewModel
    
    init(notificationVM: NotificationViewModel) {
            self.notificationVM = notificationVM
        }

    private let frameInterval: Int = 30 // Process every 30th frame
    private let detectionQueue = DispatchQueue(label: "person.detection.queue")

    func detectPersonInVideo(url: URL) async throws {
        if ProcessInfo.processInfo.isSimulator || ProcessInfo.processInfo.isPreview {
                // Simulate detection on preview/simulator
                await MainActor.run {
                    self.isDetected = true
                    self.addNotification(videoURL: url)
                }
                return
            }
        
        
        //real detection on physical device
        self.isDetected = false
        self.notifications = []

        let asset = AVURLAsset(url: url)
        let reader = try AVAssetReader(asset: asset)

        guard let videoTrack = try await asset.loadTracks(withMediaType: .video).first else {
            throw NSError(domain: "No video track found", code: -1)
        }

        let outputSettings: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]

        let trackOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: outputSettings)
        reader.add(trackOutput)
        reader.startReading()

        var frameCount = 0
        while let sampleBuffer = trackOutput.copyNextSampleBuffer() {
            if frameCount % frameInterval == 0 {
                print("📸 Got frame \(frameCount), running detection")

                if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
                    try await detectPerson(in: imageBuffer)

                    if self.isDetected {
                        print("✅ Person detected!")
                        addNotification(videoURL: url)
                        break
                    }
                } else {
                    print("❌ Could not get image buffer")
                }
            }
            frameCount += 1
        }

        print("✅ Finished scanning frames")
    }

    private func detectPerson(in pixelBuffer: CVPixelBuffer) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            let request = VNDetectHumanRectanglesRequest { request, error in
                if let error = error {
                    print("❌ Vision request error: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }

                guard let results = request.results as? [VNHumanObservation], !results.isEmpty else {
                    DispatchQueue.main.async {
                        self.isDetected = false
                        continuation.resume()
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.isDetected = true
                    continuation.resume()
                           }
            }

            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            do {
                try handler.perform([request])
            } catch {
                print("❌ Vision request failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                  continuation.resume(throwing: error)
                            }
            }
        }
    }

    func addNotification(videoURL: URL) {
        let newNotification = NotificationItem(
            title: "Person Detected",
            location: "Garage", // You can customize this
            timestamp: Date(),
            videoURL: videoURL,
            message: ""
        )

        DispatchQueue.main.async {
            self.notifications.append(newNotification)
        }
    }
}
