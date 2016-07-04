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

public class WebRadioController: NSObject {
    
    public static let sharedInstance = WebRadioController()
    
    public var isPlaying: Bool { get { return player != nil } }
    public var delegate: WebRadioDelegate?
    
    private var player: AVPlayer?
    private var streamUrl: NSURL?
    private var nowPlaying: String?
    
    override init() {
        super.init()
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
        
        let commandCenter = MPRemoteCommandCenter.sharedCommandCenter()
        commandCenter.playCommand.enabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(WebRadioController.play))
        commandCenter.pauseCommand.enabled = true
        commandCenter.pauseCommand.addTarget(self, action: #selector(WebRadioController.pause))
        
        let session: AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            //catching the error.
        }
    
    }
    
    public func setStreamUrl(string string: String) {
        streamUrl = NSURL(string: string)
    
    }
    
    public func setStreamUrl(url url: NSURL) {
        streamUrl = url
    }

    public func setNowPlaying(string: String) {
        nowPlaying = string
        updateNowPlaying()
    }
    
    public dynamic func pause() {
        player = nil
        delegate?.didStopPlaying?(self)
    }
    
    public dynamic func play() {
        guard let url = streamUrl else {
            return
        }
        
        updateNowPlaying()
        player = AVPlayer(URL: url)
        player?.play()
        delegate?.didStartPlaying?(self)
    }
    
    private func updateNowPlaying() {
        if let title = nowPlaying {
            MPNowPlayingInfoCenter.defaultCenter().nowPlayingInfo = [MPMediaItemPropertyTitle: title]
        }
    }
    
}