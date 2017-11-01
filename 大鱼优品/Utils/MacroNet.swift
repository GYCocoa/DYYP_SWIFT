//
//  MacroNet.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation


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
/// 商品详情
let AU_PRODUCT_DETAIL         =                                                SHOPING_BASE + "product-detail"


//MARK: -------------------------- 相机搜索界面URL -------------------------
let CAREMA_REAULT =                                                                 BASEURL + "search-picture"

//MARK: -------------------------- 个人中心数据 -------------------------
let MYSELF_DATA =                                                                        COMMUNITY_BASE + "myInfo"

//MARK: -------------------------- 社区基础URL -------------------------
let COMMUNITY_BASE =                                                              "http://api.deepbaytech.com/community/api/v0.0.1/"
/// 社区title
let COMMUNITY_TITLE =                                                              COMMUNITY_BASE + "cate/all"
/// 社区轮播图
let COM_COMMUNITY_BANNER           =                                    COMMUNITY_BASE + "home-rotation"
/// 首页推荐内容
let COMMUNITY_RECOMMEND     =                                            COMMUNITY_BASE + "home-recommend"
/// 其他最新内容
let COM_CATEGORY_NEW     =                                                      COMMUNITY_BASE + "cate/new"
/// 话题全部
let COM_TOPIC_ALL                =                                                       COMMUNITY_BASE + "topic/all"
/// 精选
let COM_CHOOSE_COMMEND   =                                                   COMMUNITY_BASE + "cate/chosen"

