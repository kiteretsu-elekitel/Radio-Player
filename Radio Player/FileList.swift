//
//  FileList.swift
//  Radio Player
//
//  Created by Darjeeling on 2018/06/17.
//  Copyright © 2018年 Darjeeling. All rights reserved.
//

import Foundation
import UIKit

class GenerateFileList {
	var filelistArray: [String] = []
	
	func detectFile() -> Array<URL> {
		var fileList: Array<URL> = Array<URL>()
		
		return fileList
	}
	
	func getProgramNum(URL url: String) -> Int {
		let bakaurl = URL(string: "http://192.168.0.10/baka")

		let request = URLRequest(url: bakaurl!)
		let session = URLSession.shared
		var sHttp: String = ""
		session.dataTask(with: request) { (data, response, error) in
			if error == nil, let data = data, let response = response as? HTTPURLResponse {
				sHttp = String(data: data, encoding: .utf8)!
				// HTTPヘッダの取得
				//print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
				// HTTPステータスコード
				print("statusCode: \(response.statusCode)")
			}
		}.resume()
		//session.dataTask(with: request).resume()
		while sHttp == "" {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
			}
		}
		
		//while result.contains("4") {
		let pattern = "<a href=\\\"(.+)\\\">(.+)<\\/a>"
		//let pattern = "http.*"
		let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
		let matches = regex.matches(in: sHttp, options: [], range: NSMakeRange(0, sHttp.count))
		matches.forEach { (match) -> () in self.filelistArray.append( (sHttp as NSString).substring(with: match.range(at: 1)) )
		}
		print(filelistArray)

		return filelistArray.count
	}
}


