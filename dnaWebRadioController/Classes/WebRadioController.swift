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
    
    public static let sharedInstance = WebRadioController()
    
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
            if #available(iOS 10.0, *) {
                try session.setCategory(AVAudioSession.Category.playback, mode: .default, options: [])
            } else {
                // Workaround until https://forums.swift.org/t/using-methods-marked-unavailable-in-swift-4-2/14949 isn't fixed
                session.perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.playback)
            }
        } catch {
            //catching the error. :)
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
    
    @objc open dynamic func pause() {
        player = nil
        delegate?.didStopPlaying?(self)
    }
    
    @objc open dynamic func play() {
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
