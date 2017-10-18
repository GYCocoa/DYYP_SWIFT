//
//  Const.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/19.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation
import UIKit

let APPID_QQ   =             "101388383"
let APPKEY_QQ     =          "617c10ec36678fd3a21e93223a113786"

let APPID_WECHAT  =          "wx1e462d875cc8e029"
let APPSecrect_WECHAT   =    "8e83674df427953e96ab4535d4422347"

let APPKEY_SINA      =       "1695649619"
let APPSecrect_SINA    =     "bdb851ece8d231f7855e8257a469d1c3"
let kSinaRedirectURI   =     "http://www.deepbaytech.com"

let SHARESDK_APPKEY   =      "1ba0ad4a5b1aa"

//RSA 公钥
let PubKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCmBmsntcJSGnb8PIQTFdswg3vp41IjTvdatt9IOObS4peFRW9esAyiUsvEz0ZI9m+4FWlvxYpmP9c55/uLeRcE/LX06wsjU4xuVHmY4wWi9hmCT/WPGqn1ERLVuC9e8CtFU6t5GQqB1vRlN0U0NGvZL6L4m5lXTzdTSFO/aAW4nQIDAQAB"

//RSA 私钥
let PriKey  = "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKYGaye1wlIadvw8hBMV2zCDe+njUiNO91q230g45tLil4VFb16wDKJSy8TPRkj2b7gVaW/FimY/1znn+4t5FwT8tfTrCyNTjG5UeZjjBaL2GYJP9Y8aqfUREtW4L17wK0VTq3kZCoHW9GU3RTQ0a9kvovibmVdPN1NIU79oBbidAgMBAAECgYBLLaTf+mHfo7Q1S4HS0pbKRP+bTSAodN106lH49isvWwOZiXOAwN83sZ4rpGADMfQsuyVfQ2gEHOxsgCtbYJ2XHRBsAGV+GTq/nG0E9RHstGm/rh25rH8aLpaRdvu5XCnyYJvafHhly/kUMpWv374rwTqWNkuzReKEsRXIozTIUQJBAOGXX41ZihuhxUNDNUP725tP5AcBREhicaNvTRRUCfMgOj1c484ZEewV0u44b+/40umbHE1iWpD/MvIIWYARrY8CQQC8Z43wrSkEFNHKm5VTjHjeKk2lR7rGMg/jOpDoepvUigDixTAnIrEzGaTr5uRy+vKt6HcF1tcMf3ZmAgYBXzkTAkAocF4slHRxZ5pY6F9QBIHlYXja2JtI7ny4c2c50abG8mv+O/yKIWxZCcB5+5v1RIFqZue3532cqGKViHGix4h5AkA3aspQac6vuaP/0YW53o7K4myWWiPxGlacAuUOzMm7WaBrE49XY5f1rOxayz6VJ4Vsa/1ehVQaBAACf0Pe8XBrAkA04UIjIGtWBDvTYEWFczsx7WlS0ZnG7shNBd7PRlnu5c7LXa78UMIZCLCqEfipf3GnDLGYAajSzTmTvCvvqvcf"


func SearchPathFordocumentDirectory() -> String {return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]}
/// 默认图片
let imageView_nodata = "community_nodata"
/// 屏幕的宽
let kWidth = UIScreen.main.bounds.width
/// 屏幕的高
let kHeight = UIScreen.main.bounds.height

let scaleW = kWidth/375
let scaleH = kHeight/667

/// iPhone 5
let isIPhone5 = kHeight == 568 ? true : false
/// iPhone 6
let isIPhone6 = kHeight == 667 ? true : false
/// iPhone 6P
let isIPhone6P = kHeight == 736 ? true : false
/// iPhoneX 判断
let is_IPhoneX = kHeight == 812 ? true:false

// 左右间距
let kMargin:CGFloat = 15.0
// 状态栏高度
let kNavStatusHeight: CGFloat = is_IPhoneX ?44 :20
// 导航栏高度
let kNavBarHeight: CGFloat = is_IPhoneX ?88 :64
// 导航栏高度
let kTabBarHeight: CGFloat = is_IPhoneX ? 83 :49
/// 导航栏背景图片
let kNavBar_Bg_Image    =   (is_IPhoneX ? "iphoneX_nav_bg_image" :"nav_background_image")
/// 状态栏高度
let kNavOr_BarHeight = UIApplication.shared.statusBarFrame.size.height
















