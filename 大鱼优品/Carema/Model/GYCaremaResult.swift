//
//  GYCaremaResult.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCaremaResult: NSObject {
    
    var brandId: String?
    var categoryId: String?
    var Description: String?
    var detailAppUrl: String?
    var detailUrl: String?
    
    var familyId: String?
    var fromUrl: String?
    var goodCount: String?
    var id: String?
    var image: String?
    
    var pfrom: String?
    var pfromId: String?
    var pfromImage: String?
    var pname: String?
    var price: NSNumber?
    
    var remarkCount: String?
    var symbol: String?
    
    init(dict:[String:AnyObject]) {
        brandId = dict["brandId"] as? String
        categoryId = dict["categoryId"] as? String
        Description = dict["Description"] as? String
        detailAppUrl = dict["detailAppUrl"] as? String
        detailUrl = dict["detailUrl"] as? String

        familyId = dict["familyId"] as? String
        fromUrl = dict["fromUrl"] as? String
        goodCount = dict["goodCount"] as? String
        id = dict["id"] as? String
        image = dict["image"] as? String
        
        pfrom = dict["pfrom"] as? String
        pfromId = dict["pfromId"] as? String
        pfromImage = dict["pfromImage"] as? String
        pname = dict["pname"] as? String
        price = dict["price"] as? NSNumber
        
        remarkCount = dict["remarkCount"] as? String
        symbol = dict["symbol"] as? String
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            Description = value as? String
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
