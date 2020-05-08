//
//  SizeFit.swift
//  WQRxSwift
//
//  Created by weiqiang chen on 2019/8/20.
//  Copyright © 2019 cwq. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width

let SCREEN_HEIGHT = UIScreen.main.bounds.height

let SCREEN_BOUND = UIScreen.main.bounds

let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let safeTopAreaHeight: CGFloat = (is_iPhoneX || is_iPhoneXs || is_iPhoneXsMax) ? 88.0 : 64.0

let tabbarHeight: CGFloat = (is_iPhoneX || is_iPhoneXs || is_iPhoneXsMax) ? 90.0 : 56.0

let safeBottomAreaHeight: CGFloat = (is_iPhoneX || is_iPhoneXs || is_iPhoneXsMax) ? 34.0 : 0.0

let is_iPhoneSE: Bool = (SCREEN_WIDTH == 320.0 && SCREEN_HEIGHT == 568.0) ? true : false

let is_iPhone6: Bool = (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 667.0) ? true : false

let is_iPhoneX: Bool = (SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 812.0) ? true : false

let is_iPhoneXs: Bool = (SCREEN_WIDTH == 414.0 && SCREEN_HEIGHT == 896.0) ? true : false

let is_iPhoneXsMax: Bool = (SCREEN_WIDTH == 414.0 && SCREEN_HEIGHT == 896.0) ? true : false
