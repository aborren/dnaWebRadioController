//
//  ViewController.swift
//  dnaWebRadioController
//
//  Created by Dan Isacson on 07/04/2016.
//  Copyright (c) 2016 Dan Isacson. All rights reserved.
//

import UIKit
import dnaWebRadioController

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    
    let webradio = WebRadioController.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webradio.delegate = self
        webradio.setStreamUrl(string: "http://stream.ueteknik.se:8000/siljan/;stream.mp3")
        webradio.setNowPlaying("Radio Siljan")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playPausePressed(sender: AnyObject) {
        if webradio.isPlaying {
            webradio.pause()
        } else {
            webradio.play()
        }
    }
    
}

extension ViewController: WebRadioDelegate {
    
    func didStartPlaying(webRadioController: WebRadioController) {
        self.playButton.setTitle("PAUSE", forState: .Normal)
    }
    
    func didStopPlaying(webRadioController: WebRadioController) {
        self.playButton.setTitle("PLAY", forState: .Normal)
    }
    
}
