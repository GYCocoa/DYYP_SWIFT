//
//  UIImage+GYImage.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/25.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation

extension UIImage {
    
    class func getImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}
