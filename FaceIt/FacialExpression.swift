//
//  FacialExpression.swift
//  FaceIt
//
//  Created by liguiyan on 2017/2/20.
//  Copyright © 2017年 partrick. All rights reserved.
//

import Foundation

struct FacialExpression {
    
	enum Eyes: Int {
		case open
		case closed
		case squinting
	}

	enum EyeBrows: Int {
		case relaxed
		case normal
		case furrowed
		
		var moreRelaxed: EyeBrows {
			return EyeBrows(rawValue: rawValue - 1) ?? .relaxed
		}
		var moreFurrowed: EyeBrows {
			return EyeBrows(rawValue: rawValue + 1) ?? .furrowed
		}
	}

	enum Mouth: Int {
		case frown
		case smirk
		case neutral
		case grin
		case smile

		var happier: Mouth {
			return Mouth(rawValue: rawValue + 1) ?? .smile
		}
		var sadder: Mouth {
			return Mouth(rawValue: rawValue - 1) ?? .frown
		}
	}
	
	var eyes: Eyes
	var eyeBrows: EyeBrows
	var mouth: Mouth
}
