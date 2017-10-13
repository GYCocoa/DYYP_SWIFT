//
//  GYCommunityOtherController+GYExtension.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/12.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation
import SVProgressHUD

extension GYCommunityOtherController {
    
    func getBannerdata() {
        if topicTitle?.cname == "推荐" {
            tableView.tableHeaderView = self.cycleScrollView
            /// 给轮播图赋值
            GYNetworkTool.getRequest(urlString: COM_COMMUNITY_BANNER, params: [:], success: { (response) in
//                print(response)
                if GYNetworkTool.success(response: response) {
                    self.bannerArray.removeAllObjects()
                    if let data = response["data"] as?NSArray {
                        for index in 0..<data.count {
                            let dict = data[index] as? NSDictionary
                            self.bannerArray.add(dict!["image"] as! String)
                        }
                    }
                    self.cycleScrollView.imageURLStringsGroup = self.bannerArray as! [Any]
                }else{
                    SVProgressHUD.showError(withStatus: response["stateMsg"] as? String)
                }
            }, failture: { (error) in
            })
        }
    }

    
    
}
