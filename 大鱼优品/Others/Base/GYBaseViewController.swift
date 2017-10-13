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

    
    lazy var reloadButton: UIButton = {
        var reloadButton = UIButton(type: UIButtonType.custom)
        reloadButton.frame = CGRect.init(x: kWidth/2-50*scaleW, y: kHeight/2-15, width: 100*scaleW, height: 30)
        reloadButton.setTitle("重试", for: UIControlState.normal)
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        reloadButton.layer.cornerRadius = 15
        reloadButton.backgroundColor = UIColor.globalMainColor()
        reloadButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        reloadButton.addTarget(self, action: #selector(reloadButtonAction), for: UIControlEvents.touchUpInside)
        reloadButton.isHidden = true
        return reloadButton
    }()
    ///  给子类提供刷新方法
    func reloadButtonAction(sender:UIButton) {}
}










