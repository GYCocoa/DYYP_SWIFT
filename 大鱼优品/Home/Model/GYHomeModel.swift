//
//  GYHomeModel.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYHomeModel: NSObject {

    var brandId :Int?
    var categoryId :Int?
    var Description :String?
    var detailAppUrl :String?
    var detailUrl :String?
    var goodCount :Int?
    var htmlUrl :String?
    var id :Int?
    var image :String?
    var pfrom :String?
    var pfromId :String?
    var pfromImage :String?
    var pname :String?
    var price :NSNumber?
    var remarkCount :String?
    var symbol :String?
    var typeVal :String?

    init(dict:[String:AnyObject]) {
        brandId = dict["brandId"] as! Int?
        categoryId = dict["categoryId"] as! Int?
        Description = dict["description"] as! String?
        detailAppUrl = dict["detailAppUrl"] as! String?
        detailUrl = dict["detailUrl"] as! String?
        goodCount = dict["goodCount"] as! Int?
        htmlUrl = dict["htmlUrl"] as! String?
        id = dict["id"] as! Int?
        image = dict["image"] as! String?
        pfrom = dict["pfrom"] as! String?
        pfromId = dict["pfromId"] as! String?
        pfromImage = dict["pfromImage"] as! String?
        pname = dict["pname"] as! String?
        price = dict["price"] as! NSNumber?
        remarkCount = dict["remarkCount"] as! String?
        symbol = dict["symbol"] as! String?
        typeVal = dict["typeVal"] as! String?

    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            Description = value as? String
        }
    }
    
}

class GYHomeSpecial: NSObject {
    var content :String?
    var Description :String?
    var image :String?
    var type :String?

    init(dict:[String:AnyObject]) {
        content = dict["content"] as! String?
        Description = dict["Description"] as! String?
        image = dict["image"] as! String?
        type = dict["type"] as! String?
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            Description = value as? String
        }
    }
}

class GYShopModel: NSObject {
    var detailUrl :String?
    var fromat :String?
    var id :String?
    var keywords :String?
    var picUrl :String?
    var platform :String?
    var platformCount :NSNumber?
    var price :Int?
    var shopCount :Int?
    var title :String?
    var type :Int?
    var viewSales :Int?

    init(dict:[String:AnyObject]) {
        detailUrl = dict["detailUrl"] as! String?
        fromat = dict["fromat"] as! String?
        id = dict["id"] as! String?
        keywords = dict["keywords"] as! String?
        picUrl = dict["picUrl"] as! String?
        platform = dict["platform"] as! String?
        platformCount = dict["platformCount"] as! NSNumber?
        price = dict["price"] as! Int?
        shopCount = dict["shopCount"] as! Int?
        title = dict["title"] as! String?
        type = dict["type"] as! Int?
        viewSales = dict["viewSales"] as! Int?
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
