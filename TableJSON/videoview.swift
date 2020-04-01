//
//  videoview.swift
//  TableJSON
//
//  Created by Falgun Patel on 3/28/18.
//  Copyright © 2018 Falgun Patel. All rights reserved.
//

import UIKit
import AVKit

class videoview: UIView, AVPlayerViewControllerDelegate {
    
        
        
        let videoURL = URL(string: "https://shareurvideo.000webhostapp.com/video/dddd.mp4")
        let player = AVPlayer(url: videoURL)
        let playervc = AVPlayerViewController()
        
        playervc.delegate = self
        playervc.player = player
    
    let topVC = topMostController()
        
        topVC.present(playervc, animated: true) {
            playervc.player?.play()
        }
        super.viewDidLoad()
        
        
    }
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


