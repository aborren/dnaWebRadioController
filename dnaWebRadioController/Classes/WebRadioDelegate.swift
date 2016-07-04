//
//  WebRadioDelegate.swift
//  Webradio
//
//  Created by Dan Isacson on 04/07/16.
//  Copyright © 2016 dna. All rights reserved.
//

import Foundation

@objc public protocol WebRadioDelegate {
    optional func didStartPlaying(webRadioController: WebRadioController) -> Void
    optional func didStopPlaying(webRadioController: WebRadioController) -> Void
}