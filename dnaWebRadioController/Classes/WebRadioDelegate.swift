//
//  WebRadioDelegate.swift
//  Webradio
//
//  Created by Dan Isacson on 04/07/16.
//  Copyright © 2016 dna. All rights reserved.
//

import Foundation

@objc public protocol WebRadioDelegate {
    @objc optional func didStartPlaying(_ webRadioController: WebRadioController) -> Void
    @objc optional func didStopPlaying(_ webRadioController: WebRadioController) -> Void
}
