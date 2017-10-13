//
//  TopicTitle.swift
//  SwiftNews
//
//  Created by GY.Z on 2017/9/12.
//  Copyright © 2017年 deepbaytech. All rights reserved.
//

import UIKit

class TopicTitle: NSObject {

    var categoryId: Int?
    var categoryName: String?
    
    var cid : Int?
    var cname : String?
    
    init(dict:[String:AnyObject]) {
        categoryId = dict["categoryId"] as? Int
        categoryName = dict["categoryName"] as? String
        
        cid = dict["cid"] as? Int
        cname = dict["cname"] as? String
    }
    
//    override var description: String {
//        return "categoryId = \(String(describing: categoryId)), categoryName = \(String(describing: categoryName))"
//    }
}

class CategoryModel: NSObject {
    
    var productId: Int?
    var productName: String?
    var productImage: String?
    var purchasedQuantity: String?
    var price: NSNumber?

    init(dict:[String:AnyObject]) {
        productId = dict["productId"] as? Int
        productName = dict["productName"] as? String
        productImage = dict["productImage"] as? String
        purchasedQuantity = dict["purchasedQuantity"] as? String
        price = dict["price"] as? NSNumber
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}




