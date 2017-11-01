//
//  GYNetworkTool.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/20.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol NetworkToolProtocol {
    //MARK: -------------------------- 获取验证码 手机号登录 -------------------------
    static func getphoneCodeData(phone:String, completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 手机号登录按钮 -------------------------
    static func getloginData(phone: String,code: String,os: String,completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 全网banner -------------------------
    static func getHomeBannerData(completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 精品推荐 -------------------------
    static func getHomeRecommendData(completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 必买专场 -------------------------
    static func getHomeSpecialData(completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 商品推荐 -------------------------
    static func getShopRecommendData(pageId:Int,completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 获取商城标题组 -------------------------
    static func getShoppingTitlesData(fromViewController: String,completionHandler:@escaping(_ topTitles:[TopicTitle],_ homeTopicVCs:[GYShopTopicController])->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 获取商城banner -------------------------
    static func getShoppingBannerData(completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 获取商城抢购专区数据 -------------------------
    static func getShoppingSnapupData(completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ eerror:NSDictionary)->())
    //MARK: -------------------------- 获取商城抢购专区下面的分类 -------------------------
    static func getShoppingHotData(completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 获取商城推荐或者分类的数据 -------------------------
    static func getShoppingCategoryData(pageId:Int,categoryId:Int,completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
    //MARK: -------------------------- 获取我的界面数据 -------------------------
    static func getMyselfData(completionHandler:@escaping(_ data:NSDictionary)->(),errorCode:@escaping(_ error:NSDictionary)->())
}

class GYNetworkTool: NetworkToolProtocol {
    //MARK: -------------------------- 获取我的界面数据 -------------------------
    static func getMyselfData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        let model:GYUserModel = GYUserModel.account()
        var autoToken = ""
        if let token = model.autoToken {
            autoToken = token
        }else{
            autoToken = ""
        }
        let requestHeader:HTTPHeaders = ["dpbay-token":autoToken]
        Alamofire.request(MYSELF_DATA, method: .post, parameters: nil,headers: requestHeader).responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "服务器出小差了，请稍后重试")
                errorCode(["stateMsg":"服务器出错"])
                return
            }
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 获取商城推荐或者分类的数据 -------------------------
    static func getShoppingCategoryData(pageId: Int, categoryId: Int, completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        let param = ["categoryId":categoryId,
                     "pageId":pageId] as [String:AnyObject]
        Alamofire.request(AU_COMMEND_GOOD, method: .get, parameters: param).responseJSON { (response) in
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "服务器出小差了，请稍后重试")
                return
            }
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 获取抢购专区下面的分类 -------------------------
    static func getShoppingHotData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        Alamofire.request(AU_DAILY_NEW, method: .get, parameters: nil).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 获取商城抢购专区数据 -------------------------
    static func getShoppingSnapupData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        Alamofire.request(AU_LIMITED_KILL, method: .get, parameters: nil).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 获取商城banner -------------------------
    static func getShoppingBannerData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        Alamofire.request(AU_BANNER, method: .get, parameters: nil).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 获取商城标题组 -------------------------
    static func getShoppingTitlesData(fromViewController: String, completionHandler: @escaping ([TopicTitle], [GYShopTopicController]) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        SVProgressHUD.show(withStatus: "加载中...")
        Alamofire.request(AU_HOME_CATEGORY, method: .get, parameters: nil).responseJSON { (response) in
//            print(response)
            SVProgressHUD.dismiss()
            guard response.result.isSuccess else{
                SVProgressHUD.showError(withStatus: "服务器出小差了，请稍后重试")
                errorCode(["stateMsg":"服务器出错"])
                return
            }
            if let value = response.result.value {
                let value = JSON(value)
                if (value["state"].intValue == 0) {
                    let data = value["data"].arrayObject
                    var titles = [TopicTitle]()
                    var topicVCs = [GYShopTopicController]()
                    for dict in data! {
                        let topicTitle = TopicTitle(dict: dict as! [String: AnyObject])
                        titles.append(topicTitle)
                        let topicVC = GYShopTopicController()
                        topicVC.topicTitle = topicTitle
                        topicVCs.append(topicVC)
                    }
                    completionHandler(titles, topicVCs)
                }else{
                    errorCode(value.dictionary! as NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 商品推荐 -------------------------
    static func getShopRecommendData(pageId:Int,completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        let param = ["text":"牛奶",
                     "pageId":pageId,"sortId":0] as [String:AnyObject]
        Alamofire.request(HOME_SHOP_RECOMMEND, method: .get, parameters: param).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 必买专场 -------------------------
    static func getHomeSpecialData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        Alamofire.request(HOME_HOTDATA, method: .get, parameters: nil).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 精品推荐 -------------------------
    static func getHomeRecommendData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        Alamofire.request(HOME_FLASHSALE, method: .get, parameters: nil).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 全网banner -------------------------
    static func getHomeBannerData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        Alamofire.request(HOME_BANNER, method: .get, parameters: nil).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 获取验证码 手机号登录 -------------------------
    static func getphoneCodeData(phone: String, completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        let param = ["phone":phone,
                     "type":2] as [String:AnyObject]
        Alamofire.request(LOGIN_GETCODE, method: .post, parameters: param).responseJSON { (response) in
            guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
    //MARK: -------------------------- 手机号登录按钮 -------------------------
    static func getloginData(phone: String,code: String,os: String,completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        let param = ["phone":phone,
                     "random":code,"os":os] as [String:AnyObject]
        Alamofire.request(LOGIN_CODE, method: .post, parameters: param).responseJSON { (response) in
             guard response.result.isSuccess else{return}
            if let value = response.result.value {
                let data = JSON(value)
                if (data["state"].intValue == 0) {
                    completionHandler(value as! NSDictionary)
                }else{
                    errorCode(value as! NSDictionary)
                }
            }
        }
    }
}

extension GYNetworkTool {
    
    //MARK: -------------------------- 异地登录 -------------------------
    class func longDistancelogin() {
        let model:GYUserModel = GYUserModel.account()
        if model.autoToken == nil {
            let nav = GYNavigationController.init(rootViewController: GYLoginController())
            UIApplication.shared.keyWindow?.rootViewController = nav;
        }
    }
    /// 请求成功
    class func success(response:NSDictionary)-> Bool {
        let json = JSON(response)
        if json["state"].intValue == 0 {
            return true
        }
        return false
    }
    /// 异地登录
    class func longDistance(response:NSDictionary)-> Bool {
        let json = JSON(response)
        if json["state"].intValue == 10 {
            return true
        }
        return false
    }
    //MARK: - GET 请求
    //    let tools : NetworkRequest.shareInstance!
    
    class func getRequest(urlString: String, params : [String : Any], success : @escaping (_ response : NSDictionary)->(), failture : @escaping (_ error : Error)->()) {
        let model:GYUserModel = GYUserModel.account()
        var autoToken = ""
        if let token = model.autoToken {
            autoToken = token
        }else{
            autoToken = ""
        }
        let requestHeader:HTTPHeaders = ["dpbay-token":autoToken]
        Alamofire.request(urlString, method: .get, parameters: params,headers: requestHeader).responseJSON { (response) in/*这里使用了闭包*/
                //使用switch判断请求是否成功，也就是response的result
                switch response.result {
                case .success(let value):
                    success(value as! NSDictionary)
                    if longDistance(response: value as! NSDictionary) {
                        SVProgressHUD.show(withStatus: "异地登录")
                        GYUserModel.resetAccount()
                        self.longDistancelogin()
                    }
//                    let json = JSON(value)
//                    print(json)
                case .failure(let error):
                    failture(error)
//                    print("error:\(error)")
                }
        }
        
    }
    //MARK: - POST 请求
    class func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : NSDictionary)->(), failture : @escaping (_ error : Error)->()) {
        let model:GYUserModel = GYUserModel.account()
        var autoToken = ""
        if let token = model.autoToken {
            autoToken = token
        }else{
            autoToken = ""
        }
        let requestHeader:HTTPHeaders = ["dpbay-token":autoToken]
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params,headers: requestHeader).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? NSDictionary {
                    success(value)
                    if longDistance(response: value) {
                        SVProgressHUD.show(withStatus: "异地登录")
                        GYUserModel.resetAccount()
                        self.longDistancelogin()
                    }
                }
            case .failure(let error):
                failture(error)
//                print("error:\(error)")
            }
            
        }
    }
    //MARK: --------------------------图片上传 -------------------------
    class func upLoadImageRequest(urlString : String, data: [Data],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        var headers = ["content-type":"multipart/form-data"]
        let model:GYUserModel = GYUserModel.account()
        var autoToken = ""
        if let token = model.autoToken {
            autoToken = token
            headers = ["content-type":"multipart/form-data","dpbay-token":autoToken]
        }else{
            autoToken = ""
            headers = ["content-type":"multipart/form-data"]
        }
        Alamofire.upload(multipartFormData: { multipartFormData in
                for i in 0..<data.count {
                    let name = "\(i).png"
                    multipartFormData.append(data[i], withName: "file", fileName: name, mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            if longDistance(response: value as NSDictionary) {
                                SVProgressHUD.show(withStatus: "异地登录")
                                GYUserModel.resetAccount()
                                self.longDistancelogin()
                            }
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                }
        }
        )
    }
    
}
