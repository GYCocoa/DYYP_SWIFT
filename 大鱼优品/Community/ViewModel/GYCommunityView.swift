//
//  GYCommunityView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol CommunityToolProtocol {
    //MARK: -------------------------- 获取社区标题 -------------------------
    static func getCommunityTitlesData(fromViewController: String, completionHandler: @escaping ([TopicTitle], [GYCommunityOtherController]) -> (), errorCode: @escaping (NSDictionary) -> ())
    //MARK: -------------------------- 获取社区轮播图 -------------------------
    static func getCommunityBannersData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ())
    //MARK: -------------------------- 获取社区推荐和最新数据 -------------------------
    static func getCommunityRecommendData(pageId:Int,completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ())

}

class GYCommunityView: CommunityToolProtocol {
    //MARK: -------------------------- 获取社区推荐和最新数据 -------------------------
    static func getCommunityRecommendData(pageId: Int, completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        let param = ["pageId":pageId]
        GYNetworkTool.getRequest(urlString: COMMUNITY_RECOMMEND, params: param, success: { (response) in
            completionHandler(response)
        }) { (error) in
            errorCode(error as! NSDictionary)
        }
    }
    
    //MARK: -------------------------- 获取社区轮播图 -------------------------
    static func getCommunityBannersData(completionHandler: @escaping (NSDictionary) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        GYNetworkTool.getRequest(urlString: COM_COMMUNITY_BANNER, params:[:], success: { (response) in
//            print(response)
            completionHandler(response)
        }) { (error) in
            errorCode(error as! NSDictionary)
        }
    }
    
    //MARK: -------------------------- 获取社区标题 -------------------------
    static func getCommunityTitlesData(fromViewController: String, completionHandler: @escaping ([TopicTitle], [GYCommunityOtherController]) -> (), errorCode: @escaping (NSDictionary) -> ()) {
        SVProgressHUD.show(withStatus: "加载中...")
        Alamofire.request(COMMUNITY_TITLE, method: .get, parameters: nil).responseJSON { (response) in
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
                    // 添加推荐标题
                    let recommendDict = ["cid": 0, "cname": "推荐"] as [String : Any]
                    let recommend = TopicTitle(dict: recommendDict as [String : AnyObject])
                    titles.append(recommend)
                    var topicVCs = [GYCommunityOtherController]()
                    // 添加控制器
                    let firstVC = GYCommunityOtherController()
                    firstVC.topicTitle = recommend
                    topicVCs.append(firstVC)
                    for dict in data! {
                        let topicTitle = TopicTitle(dict: dict as! [String: AnyObject])
                        titles.append(topicTitle)
                        let topicVC = GYCommunityOtherController()
                        topicVC.topicTitle = topicTitle
                        topicVCs.append(topicVC)
                    }
                    completionHandler(titles, topicVCs)
                    print(titles.count)
                    print(topicVCs.count)
                }else{
                    errorCode(value.dictionary! as NSDictionary)
                }
            }
        }
    }
    
    
}


