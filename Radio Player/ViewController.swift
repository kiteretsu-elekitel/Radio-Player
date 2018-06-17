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
	//var player = Player(file: "baka_20180312", type: "m4a")
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
				self.timeSlider.value = Float(floor(self.player.currentTime / self.player.duration * 10000) / 10000)
				//print("current time is \(Float(floor(self.player.currentTime / self.player.duration * 10000) / 10000))")
				print("current time is \(self.player.currentTime)")

			})
		} else {
			player.pause()
			isPlaying = false
			let buttonImage = UIImage(named: "start")
			button.setImage(buttonImage, for: UIControlState())
			currentTimer?.invalidate()
		}
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
		let timeFormat = TimeFormat()
		endTimeLabel.text = timeFormat.secToHourFormat(argSec: duration)
	}

	@IBAction func moveSlider(_ sender: Any) {
		self.player.currentTime = TimeInterval(Double(timeSlider.value) * player.duration)
	}

	func displayCurrentTime() {
		let formatter = TimeFormat()
		let rawCurrenTime = player.currentTime
		let currentTime = Int(rawCurrenTime)
		//currentTimeLabel.text = secToHourFormat(argSec: currentTime)
		currentTimeLabel.text = formatter.secToHourFormat(argSec: currentTime)
	}

	@IBAction func pushedSeekButton(_ sender: UIButton) {
		var seektime:Double = 0
		if sender.tag == 1 {
			seektime = 30
		} else {
			seektime = -30
		}
		let timeFormatter = TimeFormat()
		var currentTime = player.currentTime
		player.currentTime = currentTime + seektime
		currentTime = player.currentTime
		currentTimeLabel.text = timeFormatter.secToHourFormat(argSec: Int(currentTime))
	}


	override func viewDidLoad() {
		super.viewDidLoad()

		audioPlayerDif(audioPath: audioPath!)

		// Do any additional setup after loading the view, typically from a nib.
	}
}

