//
//  PersonDetectionViewModel.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/31/25.
//

import AVFoundation
import Vision
import SwiftUI

class PersonDetectionViewModel: ObservableObject {
    @Published var isDetected: Bool = false
    var videoURL: URL?
    var notificationVM: NotificationViewModel?
    
    
    //load video file
    func detectPersonInVideo(url: URL) async throws{
        self.videoURL = url
        try await extractFrames(from: url)
        
    }
    
    //extracts each frame from the video
    private func extractFrames(from videoURL: URL) async throws{
        let asset = AVURLAsset(url: videoURL)     // loads the video in AVAsset
        let reader = try! AVAssetReader(asset: asset)  //reader extract data from the asset.
        
        
        guard let videoTrack = try await asset.loadTracks(withMediaType: .video).first else {return}
        
        let outputSettings: [String: Any] = [ kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        let readerOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: outputSettings) //Configures how to read video frames with the desired format
        reader.add(readerOutput)
        reader.startReading()
        
        while let sampleBuffer = readerOutput.copyNextSampleBuffer(){
            if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer){   //convert each CMSampleBuffer to CIImage
                let ciImage = CIImage(cvImageBuffer: imageBuffer)
                detectPerson(in: ciImage)  //Pass it to the detectPerson function to analyze the frame.
            }
            
        }
        
    }
    //run person detection with Vision
    private func detectPerson(in ciImage: CIImage){
        let request = VNDetectHumanRectanglesRequest{ [weak self] request, error in
            guard let self = self else {return}
            if let results = request.results as? [VNHumanObservation], !results.isEmpty{  //checks if people were found in the frame
                DispatchQueue.main.async {
                    self.isDetected = true
                    if let url = self.videoURL {
                        self.notificationVM?.addNotification(title: "Person Detected",location:"Front Door", videoURL: url) //if videoURL is valid add a new notification
                    }
                }
            }
            
        }
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])  //Sets up a Vision request handler using the frame image
        try? handler.perform([request])
    }
}
