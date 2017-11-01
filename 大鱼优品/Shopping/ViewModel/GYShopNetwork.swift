//
//  GYShopNetwork.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/1.
//  Copyright © 2017年 GYZ. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol GYShopNetworkProtocal {
    //MARK: -------------------------- 获取商品详情页面 -------------------------
    static func getShopDetailData(goodId: Int, completionHandler: @escaping (_ data:NSDictionary) -> (), errorCode: @escaping (_ error:NSError) -> ())
    
    
    
}

class GYShopNetwork: GYShopNetworkProtocal {
    //MARK: -------------------------- 获取商品详情页面 -------------------------
    static func getShopDetailData(goodId: Int, completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSError) -> ()) {
        let param = ["productId":goodId]
        GYNetworkTool.getRequest(urlString: AU_PRODUCT_DETAIL, params: param, success: { (response) in
            print(response)
            completionHandler(response)
        }) { (error) in
            errorCode(error as NSError)
        }
    }
//    //MARK: -------------------------- 获取商品详情页面 -------------------------
//    static func getCommunityChooseData(cId: Int, pageId: Int, completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSError) -> ()) {
//        let param = ["pageId":pageId,"cid":cId]
//        GYNetworkTool.getRequest(urlString: COM_CHOOSE_COMMEND, params: param, success: { (response) in
//            completionHandler(response)
//        }) { (error) in
//            errorCode(error as NSError)
//        }
//    }
    

    
    
}




