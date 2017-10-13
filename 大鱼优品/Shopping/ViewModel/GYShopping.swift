
//
//  GYShopping.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/27.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYShopping: NSObject {

    var content:String?
    var id:Int?
    var image:String?
    var title:String?
    var type:String?

    init(dict:[String:AnyObject]) {
        content = dict["content"] as! String?
        id = dict["id"] as! Int?
        image = dict["image"] as! String?
        title = dict["title"] as! String?
        type = dict["type"] as! String?
    }
    
}

class GYSnapupModel: NSObject {
    
    var price:NSNumber?
    var productId:Int?
    var productImage:String?
    var productName:String?
    
    init(dict:[String:AnyObject]) {
        price = dict["price"] as! NSNumber?
        productId = dict["productId"] as! Int?
        productImage = dict["productImage"] as! String?
        productName = dict["productName"] as! String?
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
