//
//  GYHomeBanner.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYHomeBanner: NSObject {
    var content :String?
    var image :String?
    var title :String?
    var type :String?
    
    init(dict:[String:AnyObject]) {
        content = dict["content"] as! String?
        image = dict["image"] as! String?
        title = dict["title"] as! String?
        type = dict["type"] as! String?
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
