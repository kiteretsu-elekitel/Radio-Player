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

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func tapStartButton(_ sender: Any) {
		player.play()
	}
	
	
	@IBAction func tapStopButton(_ sender: Any) {
		player.pause()
	}
	
	func audioPlayerDif(){
		
		// 音声ファイルのパスを定義 ファイル名, 拡張子を定義
		let audioPath = Bundle.main.path(forResource: "baka_20180312", ofType: "m4a")
		//let audioURL = URL(fileURLWithPath: audioPath!)

		//ファイルが存在しない、拡張子が誤っている、などのエラーを防止するために実行テスト(try)する。
		
		if let path = audioPath {
			print("ditected audio file")
			do{
				//tryで、ファイルが問題なければ player変数にaudioPathを定義
				try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: path) as URL)
			}catch{
				print("file type is not supporting")
			}
		}
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		audioPlayerDif()
		
		// Do any additional setup after loading the view, typically from a nib.
	}
}

