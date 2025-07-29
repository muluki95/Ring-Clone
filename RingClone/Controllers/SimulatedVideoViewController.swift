//
//  Untitled.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/20/25.
//
import UIKit
import AVFoundation


class SimulatedVideoViewController: UIViewController {
    
    let viewModel = SimulatedVideoViewModel()
    private var playerLayer: AVPlayerLayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()   //when the screen loads call setupvideoplayback method to start playing sample video
       
        view.backgroundColor = .black
        viewModel.setupVideoPlayback()
        
        
        
        if let layer = viewModel.getPlayerLayer(frame: view.bounds) {
                    playerLayer = layer
                    view.layer.addSublayer(playerLayer!)
                } else {
                    print(" Player layer not created")
                }
            }
            
            override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                // Make sure the player layer fills the view after layout
                playerLayer?.frame = view.bounds
            }
    deinit {
           print("Controller deallocated")
       }
}
