//
//  GYRuntimeModel.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/6.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYRuntimeModel: NSObject {

    // MARK:- 处理需要归档的字段
    func encode(with aCoder:NSCoder) {
        var count:UInt32 = 0
        let ivars = class_copyIvarList(GYRuntimeModel.self, &count)
        for i in 0..<count {
            let ivar = ivars![Int(i)]
            let key = String.init(utf8String: ivar_getName(ivar))
            aCoder.encode(self.value(forKey: key!), forKey: key!)
        }
    }
    
    
    // MARK:- 处理需要解档的字段
    required init(coder aDecoder:NSCoder) {
        super.init()
        var count:UInt32 = 0
        let ivars = class_copyIvarList(GYRuntimeModel.self, &count)
        for i in 0..<count {
            let ivar = ivars![Int(i)]
            let key = String.init(utf8String: ivar_getName(ivar))
            let value = aDecoder.decodeObject(forKey: key!)
            self.setValue(value, forKey: key!)
        }
    }
    
    
    
}
