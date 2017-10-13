//
//  UIColor+GYColor.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/19.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// 十六进制颜色
    class func colorConversion (Color_Value:NSString, alpha: CGFloat)->UIColor{
        var  Str :NSString = Color_Value.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if Color_Value.hasPrefix("#"){
            Str=(Color_Value as NSString).substring(from: 1) as NSString
        }
        let redStr = (Str as NSString ).substring(to: 2)
        let greenStr = ((Str as NSString).substring(from: 2) as NSString).substring(to: 2)
        let blueStr = ((Str as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string:redStr).scanHexInt32(&r)
        Scanner(string: greenStr).scanHexInt32(&g)
        Scanner(string: blueStr).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    // 便利初始化方法
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 背景灰色
    class func globalBackgroundColor() -> UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    class func globalGrayColor() -> UIColor {
        return UIColor(r: 234, g: 234, b: 234)
    }
    /// 背景蓝色
    class func globalBlueColor() -> UIColor {
        return UIColor(r: 76, g: 173, b: 253)
    }
    
    /// RGBA的颜色设置
    class func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    /// 红色
    class func globalRedColor() -> UIColor {
        return UIColor(r: 210, g: 63, b: 66)
    }
    /// 主颜色
    class func globalMainColor() -> UIColor {
        return UIColor.colorConversion(Color_Value: "fd6363", alpha: 1)
    }
    
    /// 随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    class func getRGBDelta(_ firstColor : UIColor, _ seccondColor : UIColor) -> (CGFloat, CGFloat,  CGFloat) {
        let firstRGB = firstColor.getRGB()
        let secondRGB = seccondColor.getRGB()
        
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("保证普通颜色是RGB方式传入")
        }
        return (cmps[0] * 255, cmps[1] * 255, cmps[2] * 255)
    }
    
}
