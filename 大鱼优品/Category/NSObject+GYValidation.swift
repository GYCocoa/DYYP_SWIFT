//
//  NSObject+GYValidation.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/20.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    /// 手机号验证
    class func isPhoneNumber(phoneNumber:String) -> Bool {
        if phoneNumber.characters.count == 0 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true {
            return true
        }else
        {
            return false
        }
    }
    /// 邮箱号码验证
    class func isZipCodeNumber(zipCodeNumber:String) -> Bool {
        if zipCodeNumber.characters.count == 0 {
            return false
        }
        let zipCodeNumber = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexCodeNumber = NSPredicate(format: "SELF MATCHES %@",zipCodeNumber)
        if regexCodeNumber.evaluate(with: zipCodeNumber) == true {
            return true
        }else
        {
            return false
        }
    }
    
    
}
