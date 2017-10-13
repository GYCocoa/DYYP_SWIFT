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

let imageView_nodata = "community_nodata"
/// 屏幕的宽
let kWidth = UIScreen.main.bounds.width
/// 屏幕的高
let kHeight = UIScreen.main.bounds.height

let scaleW = kWidth/375
let scaleH = kHeight/667

// 左右间距
let kMargin:CGFloat = 15.0
// 状态栏高度
let kNavStatusHeight: CGFloat = 20.0
// 导航栏高度
let kNavBarHeight: CGFloat = 64.0
// 导航栏高度
let kTabBarHeight: CGFloat = 49.0

/// iPhone 5
let isIPhone5 = kHeight == 568 ? true : false
/// iPhone 6
let isIPhone6 = kHeight == 667 ? true : false
/// iPhone 6P
let isIPhone6P = kHeight == 736 ? true : false

//MARK: -------------------------- 登录基础URL -------------------------
let BASE_LOGIN               = "http://api.deepbaytech.com/mobile/api/v0.0.1/conf/"
/// 三方登录
let LOGIN_THIRD             = BASE_LOGIN + "third-login"
/// 获取验证码
let LOGIN_GETCODE       = BASE_LOGIN + "getsms"
/// 三方绑定手机号
let LOGIN_BIND                = BASE_LOGIN + "bindPhone"
/// 手机号验证码登录
let LOGIN_CODE               = BASE_LOGIN + "phoneLogin"
/// 登录存储路径
let Login_Cache = "/userAccount.data"
/// 第三方登录
let LOGIN_THIRDPARTY   =                     BASE_LOGIN + "third-login"
/// 第三方账号绑定手机号
let LOGIN_THIRDPARTY_BINDPHONE       =      BASE_LOGIN + "bindPhone"

//MARK: -------------------------- 全网基础URL -------------------------
let   BASEURL = "http://api.deepbaytech.com/mobile/api/v0.0.1/"
/// 图片域名
let IMAGEURL = "http://redirect.deepbaytech.com/img?url="

/// 首页轮播图
let HOME_BANNER =                                                              "\(BASEURL)daily-update"
/// 限时抢购
let HOME_FLASHSALE  =                                                       "\(BASEURL)panic-buy"
/// 热门专场
let HOME_HOTDATA =                                                           "\(BASEURL)hot-special"
let HOME_SHOP_RECOMMEND =                                          "\(BASEURL)group-search-text"


//MARK: -------------------------- 商城基础URL -------------------------
let SHOPING_BASE      =                                                            "http://api.deepbaytech.com/shop/api/v0.0.1/"
let AU_HOME_CATEGORY  =                                                   SHOPING_BASE + "primaryCategory"
let AU_BANNER   =                                                                     SHOPING_BASE + "carousel-figure"
/// 限时秒杀
let AU_LIMITED_KILL              =                                                SHOPING_BASE + "buy-now"
/// 每日上新
let  AU_DAILY_NEW         =                                                         SHOPING_BASE + "daily-new"
/// 精品推荐
let AU_COMMEND_GOOD      =                                                   SHOPING_BASE + "commendation"
/// 抢购专区
let AU_SNAP_UP           =                                                               SHOPING_BASE + "seckill-info"
/// 抢购专区分页数据
let AU_SECKILL_PRODUCT     =                                                 SHOPING_BASE + "seckill-product"
/// 活动专区
let AU_ACTIVITY               =                                                          SHOPING_BASE + "activity-product"

//MARK: -------------------------- 社区基础URL -------------------------
let COMMUNITY_BASE =                                                              "http://api.deepbaytech.com/community/api/v0.0.1/"
let COMMUNITY_TITLE =                                                              COMMUNITY_BASE + "cate/all"
/// 商城轮播图
let COM_COMMUNITY_BANNER           =                                    COMMUNITY_BASE + "home-rotation"
//MARK: -------------------------- 相机搜索界面URL -------------------------
let CAREMA_REAULT =                                                                 BASEURL + "search-picture"

//MARK: -------------------------- 个人中心数据 -------------------------
let MYSELF_DATA =                                                                        COMMUNITY_BASE + "myInfo"
















