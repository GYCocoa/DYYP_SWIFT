//
//  GYTabbar.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYTabbar: UITabBar {
    
    var button:UIButton?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        button = UIButton()
        button?.setImage(UIImage.init(named: "tabbar_camera_icon_click"), for: UIControlState.normal)
        button?.setBackgroundImage(UIImage.init(named: "tabbar_camera_icon"), for: UIControlState.normal)
        button?.sizeToFit()
        button?.frame.size = (button?.currentBackgroundImage?.size)!
        self.addSubview(button!)
        button?.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        button?.adjustsImageWhenHighlighted = false
        
        self.backgroundImage = UIImage()
        self.shadowImage = self.creatImageWithColor(color: UIColor.colorConversion(Color_Value: "#E9E9E9", alpha: 1))
    }
    
    func creatImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect.init(x: 0.0, y: 0.0, width: self.frame.size.width, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.size.width
        let height:CGFloat = 49
//        let height = self.frame.size.height
        button?.frame.size.width = (button?.currentBackgroundImage?.size.width)!
        button?.frame.size.height = (button?.currentBackgroundImage?.size.height)!
        button?.center = CGPoint.init(x: width * 0.5, y: height * 0.3)
        let Y = 0
        let W = width/5
        let H = height
        var index:CGFloat = 0
        
        for control in self.subviews {
            if !control.isKind(of: UIControl.self) || control == button {
                continue
            }
            let X = W * ((index > 1) ? (index + 1) : index)
            control.frame = CGRect.init(x: X, y: CGFloat(Y), width: W, height: H)
            index += 1
        }
    }
    
    @objc private func buttonAction(sender:UIButton) {
        let vc = GYCaremaController()
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isHidden {
            if self .touchPointInsideCircle(center: (button?.center)!, radius: 30, point: point) {
                return button
            }else{
                return super.hitTest(point, with: event)
            }
        }
        return super.hitTest(point, with: event)
    }
    
    private func touchPointInsideCircle(center:CGPoint, radius:CGFloat, point:CGPoint) -> Bool {
        let dist = sqrt((point.x - center.x) * (point.x - center.x) + (point.y - center.y) * (point.y - center.y))
        return (dist <= radius)
    }
}
