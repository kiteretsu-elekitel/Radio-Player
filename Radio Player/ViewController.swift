//
//  ViewController.swift
//  Radio Player
//
//  Created by Darjeeling on 2018/02/12.
//  Copyright © 2018年 Darjeeling. All rights reserved.
//
import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

	var player = AVAudioPlayer()
	var currentTimer: Timer?
	var isPlaying: Bool = false

	@IBOutlet var endTimeLabel: UILabel!
	@IBOutlet var currentTimeLabel: UILabel!
	@IBOutlet var timeSlider: UISlider!

	let audioPath = Bundle.main.path(forResource: "baka_20180312", ofType: "m4a")

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func tapStartButton(_ sender: Any) {
		let button = (sender as! UIButton)
		if isPlaying == false {
			player.play()
			isPlaying = true
			let buttonImage = UIImage(named: "pause")

			button.setImage(buttonImage, for: UIControlState())

			currentTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(currentTimer) in
				self.displayCurrentTime()
				self.timeSlider.value = Float(floor(self.player.currentTime / self.player.duration * 100) / 100)
			})
		} else {
			player.pause()
			isPlaying = false
			let buttonImage = UIImage(named: "start")
			button.setImage(buttonImage, for: UIControlState())
			currentTimer?.invalidate()
		}
	}
	@IBAction func moveTimeSlider(_ sender: Any) {
		let slider = (sender as! UISlider)
		let duration = player.duration

		slider.minimumValue = 0
		slider.maximumValue = Float(duration)

	
	}

	//make audio Player instance
	func audioPlayerDif(audioPath: String){
		// 音声ファイルのパスを定義 ファイル名, 拡張子を定義
		//let audioPath = Bundle.main.path(forResource: "baka_20180312", ofType: "m4a")
		//let audioURL = URL(fileURLWithPath: audioPath!)
		do {
			try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath) as URL)
		} catch {
			print("file type is not supporting")
		}

		let duration = Int(player.duration)
		endTimeLabel.text = secToHourFormat(argSec: duration)
	}


	func displayCurrentTime() {
		let rawCurrenTime = player.currentTime
		let currentTime = Int(rawCurrenTime)
		currentTimeLabel.text = secToHourFormat(argSec: currentTime)
	}

	func secToHourFormat(argSec: Int) -> String {
		var hour: Int
		var min: Int
		var sec: Int
		print(argSec)

		if argSec < 60 {
			print("sec time is less then 60")
			return "00:" + "00:" + String(format: "%02d", argSec)
		}
		
		min = argSec / 60
		if min == 1 {
			sec = argSec - 60
		} else {
			sec = argSec % min
		}

		if argSec < 3600 {
			return "00:" + String(format: "%02d", min) + ":" + String(format: "%02d", sec)
		}
		if argSec >= 3600 {
			hour = min / 60
			if hour == 1 {
				min = min - 60
			} else {
				min = min % hour
			}
			return String(format: "%02d", hour) + ":" + String(format: "%02d", min) + ":" + String(format: "%02d", sec)
		}
		return String(0)

	}

	override func viewDidLoad() {
		super.viewDidLoad()

		audioPlayerDif(audioPath: audioPath!)

		// Do any additional setup after loading the view, typically from a nib.
	}
}

