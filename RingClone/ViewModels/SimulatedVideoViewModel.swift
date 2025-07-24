//
//  Simulated.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/19/25.
//
import UIKit
import AVFoundation
import Combine
import Vision



class SimulatedVideoViewModel: ObservableObject {
    
    private var player : AVPlayer?
    private var displayLink: CADisplayLink?
    private var videoOutput: AVPlayerItemVideoOutput?    // lets us extract individual frames from video player
    
    @Published var isPersonDetected = false
    
    var onPersonDetected: (() -> Void)?
    
    
    func setupVideoPlayback() {
        guard let path = Bundle.main.path(forResource:"", ofType: "") else {
            print("Video not found")
            return
            
        }
        
        let asset = AVURLAsset(url: URL(fileURLWithPath: path))
        let item = AVPlayerItem(asset: asset)   // a player ready version of the video that AVPlayer can use
        
        
        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: [kCVPixelBufferWidthKey as String:1280,kCVPixelBufferHeightKey as String: 720])  //sets up a system to grab frames from the video in a pixel format that Vision can understand.
        item.add(videoOutput!)
        
        player = AVPlayer(playerItem: item)
        
        let playerLayer = AVPlayerLayer(player: player)   //makes video visible on screen
        player?.play()  //start playing the video
        
        displayLink = CADisplayLink(target: self, selector: #selector(captureFrame))
        displayLink?.add(to: .main, forMode: .common)

    }
    @objc private func captureFrame() {
        guard let output = videoOutput,
              let player = player else {return}
        
              let hostTime = CACurrentMediaTime()  //Get the current host time (real-world clock time)
              let itemTime = output.itemTime(forHostTime: hostTime ) //Convert host time to the video’s item time (timeline of the video)
        
             //Check if there's a new video frame at this time
              if output.hasNewPixelBuffer(forItemTime:itemTime),
                 let buffer = output.copyPixelBuffer(forItemTime: itemTime, itemTimeForDisplay: nil){
                  
                  // Create a Vision request to detect people in the frame
                  let request = VNDetectHumanRectanglesRequest { [weak self] request, error in
                                  DispatchQueue.main.async {
                                      self?.isPersonDetected = !( (request.results as? [VNHumanObservation])?.isEmpty ?? true )

                                  }
                              }

                  
                  //hand the current video frame over to Vision and ask it to run the person detection request.
                  let handler = VNImageRequestHandler(cvPixelBuffer: buffer, orientation: .up, options: [:])
                  try? handler.perform([request])
              }
       }
    
    func getPlayerLayer(frame: CGRect) -> AVPlayerLayer? {
        guard let player = player else { return nil }
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = frame
                return playerLayer
        
    }
        deinit {
            displayLink?.invalidate()  // when the screen is destroyed stop the timer (displayLink)
        
    }
    
}
