//
//  Player.swift
//  Radio Player
//
//  Created by Darjeeling on 2018/05/29.
//  Copyright © 2018年 Darjeeling. All rights reserved.
//

import Foundation
import AVFoundation

class Player {
	let audioPath: String?
	var player: AVAudioPlayer

	init(file: String, type: String) {
		self.audioPath = Bundle.main.path(forResource: file, ofType: type)
		self.player = AVAudioPlayer()
		do {
			try self.player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: self.audioPath!) as URL)
		} catch {
			print("file type is not supporting")
		}
	}
	
	func getAudioDuration() -> Int {
		return Int(player.duration)
	}
	
}
