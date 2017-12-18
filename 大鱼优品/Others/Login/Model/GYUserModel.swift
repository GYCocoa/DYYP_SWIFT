//
//  GYUserModel.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/20.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

private let path = SearchPathFordocumentDirectory() + Login_Cache

class GYUserModel: NSObject,NSCoding {

    var autoToken:String?
    var chatPassWord:String?
    var chatUserName:String?
    var requestToken:String?
    var userId:Int?
    var state:Int?
    var stateMsg:String?
    
    //MARK:-自定义构造函数
    init(dict:[String:AnyObject])
    {
        super.init()
        autoToken = dict["autoToken"] as! String?
        chatPassWord = dict["chatPassWord"] as! String?
        chatUserName = dict["chatUserName"] as! String?
        requestToken = dict["requestToken"] as! String?
        userId = dict["userId"] as! Int?
        state = dict["state"] as! Int?
        stateMsg = dict["stateMsg"] as! String?
    }
    
    // MARK:- 处理需要归档的字段
    func encode(with aCoder:NSCoder) {
        aCoder.encode(autoToken, forKey:"autoToken")
        aCoder.encode(chatPassWord, forKey:"chatPassWord")
        aCoder.encode(chatUserName, forKey:"chatUserName")
        aCoder.encode(requestToken, forKey:"requestToken")
        aCoder.encode(userId, forKey:"userId")
        aCoder.encode(state, forKey:"state")
        aCoder.encode(stateMsg, forKey:"stateMsg")
    }
    
    
    // MARK:- 处理需要解档的字段
    required init(coder aDecoder:NSCoder) {
    super.init()
    autoToken = aDecoder.decodeObject(forKey:"autoToken")as?String
    chatPassWord = aDecoder.decodeObject(forKey:"chatPassWord")as?String
    chatUserName = aDecoder.decodeObject(forKey:"chatUserName")as?String
    requestToken = aDecoder.decodeObject(forKey:"requestToken")as?String
    userId = aDecoder.decodeObject(forKey:"userId")as?Int
    state = aDecoder.decodeObject(forKey:"state")as?Int
    stateMsg = aDecoder.decodeObject(forKey:"stateMsg")as?String
    }
    override init() {
    super.init()
    }
    
    override var description: String{
        return "autoToken = \(String(describing: autoToken))"
    }
    /// 获取缓存文件
 class func account()-> GYUserModel{
        /// 解档
        if NSKeyedUnarchiver.unarchiveObject(withFile: path) != nil {
            var models = GYUserModel()
            models = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! GYUserModel
            return models
        }else{
            return GYUserModel()
        }
    }
    /// 移除文件
    class func resetAccount() {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path) {
            try! fileManager.removeItem(atPath: path)
        }
    }
    
}

