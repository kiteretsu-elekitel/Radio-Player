//
//  TimeFormat.swift
//  Radio Player
//
//  Created by Darjeeling on 2018/05/29.
//  Copyright © 2018年 Darjeeling. All rights reserved.
//

import Foundation

class TimeFormat {
	
	func secToHourFormat(argSec: Int) -> String {
		var hour: Int
		var min: Int
		var sec: Int

		if argSec < 60 {
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
	
}
