//
//  Untitled.swift
//  RingClone
//
//  Created by Esther Nzomo on 7/20/25.
//
import UIKit


class SimulatedVideoViewController: UIViewController {
    
    let viewModel = SimulatedVideoViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()          //when the screen loads call setupvideoplayback method to start playing sample video
        viewModel.setupVideoPlayback()
        
        
        
        if let playerLayer = viewModel.getPlayerLayer(frame: view.bounds) {
            view.layer.addSublayer(playerLayer)
        }
        
    }
    deinit {
           print("Controller deallocated")
       }
}
