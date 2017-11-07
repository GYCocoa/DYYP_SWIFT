
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
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
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

class GYShopDetailComment: NSObject {
    
    var anonymity:Int?
    var appendComment:String?
    var appendCommentTime:String?
    var appendImgs:NSArray?
    
    var attitude:NSNumber?
    var content:String?
    var evaluateData:String?
    var imgs:NSArray?

    var logistics:NSNumber?
    var productId:Int?
    var score:NSNumber?
    var shopId:Int?
    var skuName:String?
    var userId:Int?
    var userIcon:String?
    var userName:String?
    
    init(dict:[String:AnyObject]) {
        anonymity = dict["anonymity"] as! Int?
        appendComment = dict["appendComment"] as! String?
        appendCommentTime = dict["appendCommentTime"] as! String?
        appendImgs = dict["appendImgs"] as! NSArray?
        
        attitude = dict["attitude"] as! NSNumber?
        content = dict["content"] as! String?
        evaluateData = dict["evaluateData"] as! String?
        imgs = dict["imgs"] as! NSArray?
        
        logistics = dict["logistics"] as! NSNumber?
        productId = dict["productId"] as! Int?
        score = dict["score"] as! NSNumber?
        shopId = dict["shopId"] as! Int?
        skuName = dict["skuName"] as! String?
        userId = dict["userId"] as! Int?
        userIcon = dict["userIcon"] as! String?
        userName = dict["userName"] as! String?
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class GYShopDetailHeader: NSObject {
    
    var comments:Int?
    var committed:NSArray?
    var Description:String?
    var groupNum:Int?
    var groupPrice:NSNumber?
    var isCollect:Int?
    var isSingle:Int?
    var originalPrice:NSNumber?
    var productImages:NSArray?
    var productName:String?
    var sales:Int?
    var score:NSNumber?
    var sepPrice:NSNumber?
    var shareUrl:String?
    var userId:String?
    var userName:String?
    
    init(dict:[String:AnyObject]) {
        comments = dict["comments"] as! Int?
        committed = dict["committed"] as! NSArray?
        Description = dict["description"] as! String?
        groupNum = dict["groupNum"] as! Int?
        groupPrice = dict["groupPrice"] as! NSNumber?
        isCollect = dict["isCollect"] as! Int?
        isSingle = dict["isSingle"] as! Int?
        originalPrice = dict["originalPrice"] as! NSNumber?
        productImages = dict["productImages"] as! NSArray?
        productName = dict["productName"] as! String?
        sales = dict["sales"] as! Int?
        score = dict["score"] as! NSNumber?
        sepPrice = dict["sepPrice"] as! NSNumber?
        shareUrl = dict["shareUrl"] as! String?
        userId = dict["userId"] as! String?
        userName = dict["userName"] as! String?
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            Description = value as? String
        }
    }
    
}

class GYShopDetailFooter: NSObject {
    
    var iconUrl:String?
    var recommend:NSArray?
    var price:String?
    var productId:String?
    var productImage:String?
    var productName:String?
    var sales:String?
    var shopId:String?
    var shopName:NSArray?
    
    init(dict:[String:AnyObject]) {
        iconUrl = dict["iconUrl"] as! String?
        recommend = dict["recommend"] as! NSArray?
        price = dict["price"] as! String?
        productId = dict["productId"] as! String?
        productImage = dict["productImage"] as! String?
        productName = dict["productName"] as! String?
        sales = dict["sales"] as! String?
        shopId = dict["shopId"] as! String?
        shopName = dict["shopName"] as! NSArray?
        productName = dict["productName"] as! String?
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}









