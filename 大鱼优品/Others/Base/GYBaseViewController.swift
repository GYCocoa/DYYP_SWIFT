//
//  GYBaseViewController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/19.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.globalBackgroundColor()
        view.addSubview(reloadButton)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        } else {
            // Fallback on earlier versions
        }
        
        updateOrientation()
    }
    
    fileprivate func updateOrientation() {
//        var frame = self.view.frame
        if #available(iOS 11.0, *) {
//            frame.origin.x = self.view.safeAreaInsets.left
//            frame.size.width = self.view.frame.size.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right
//            frame.size.height = self.view.frame.size.height - self.view.safeAreaInsets.bottom
//            self.view.frame = frame
        } else {
            // Fallback on earlier versions
        }
    }
    
    lazy var reloadButton: UIButton = {
        var reloadButton = UIButton(type: UIButton.ButtonType.custom)
        reloadButton.frame = CGRect.init(x: kWidth/2-50*scaleW, y: kHeight/2-15, width: 100*scaleW, height: 30)
        reloadButton.setTitle("重试", for: UIControl.State.normal)
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        reloadButton.layer.cornerRadius = 15
        reloadButton.backgroundColor = UIColor.globalMainColor()
        reloadButton.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)
        reloadButton.addTarget(self, action: #selector(reloadButtonAction), for: UIControl.Event.touchUpInside)
        reloadButton.isHidden = true
        return reloadButton
    }()
    ///  给子类提供刷新方法
    @objc func reloadButtonAction(sender:UIButton) {}
}










