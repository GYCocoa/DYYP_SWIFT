//
//  GYCommunityModel.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityModel: NSObject {

    var comments:Int?
    var content:String?
    var ctime:String?
    var icon:String?
    var isKeep:Int?
    var isLike:Int?
    var isTurn:Int?
    var likes:Int?
    var nickName:String?
    var picture:NSDictionary?
    var tid:Int?
    var tname:String?
    var uid:Int?
    var wid:Int?
    var isFollow:Int?

    
    init(dict:[String:AnyObject]) {
        comments = dict["comments"] as! Int?
        content = dict["content"] as! String?
        ctime = dict["ctime"] as! String?
        icon = dict["icon"] as! String?
        isKeep = dict["isKeep"] as! Int?
        isLike = dict["isLike"] as! Int?
        isTurn = dict["isTurn"] as! Int?
        likes = dict["likes"] as! Int?
        nickName = dict["nickName"] as! String?
        picture = dict["picture"] as! NSDictionary?
        tid = dict["tid"] as! Int?
        tname = dict["tname"] as! String?
        uid = dict["uid"] as! Int?
        wid = dict["wid"] as! Int?
        isFollow = dict["isFollow"] as! Int?

        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    
}
