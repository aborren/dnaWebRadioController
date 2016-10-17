//
//  WebRadioController.swift
//  WebRadio
//
//  Created by Dan Isacson on 04/07/16.
//  Copyright © 2016 dna. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

open class WebRadioController: NSObject {
    
    open static let sharedInstance = WebRadioController()
    
    open var isPlaying: Bool { get { return player != nil } }
    open var delegate: WebRadioDelegate?
    
    fileprivate var player: AVPlayer?
    fileprivate var streamUrl: URL?
    fileprivate var nowPlaying: String?
    
    override init() {
        super.init()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(WebRadioController.play))
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget(self, action: #selector(WebRadioController.pause))
        
        let session: AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            //catching the error.
        }
    
    }
    
    open func setStreamUrl(string: String) {
        streamUrl = URL(string: string)
    
    }
    
    open func setStreamUrl(url: URL) {
        streamUrl = url
    }

    open func setNowPlaying(_ string: String) {
        nowPlaying = string
        updateNowPlaying()
    }
    
    open dynamic func pause() {
        player = nil
        delegate?.didStopPlaying?(self)
    }
    
    open dynamic func play() {
        guard let url = streamUrl else {
            return
        }
        
        updateNowPlaying()
        player = AVPlayer(url: url)
        player?.play()
        delegate?.didStartPlaying?(self)
    }
    
    fileprivate func updateNowPlaying() {
        if let title = nowPlaying {
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: title]
        }
    }
    
}
