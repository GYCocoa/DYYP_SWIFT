//
//  GYShopDetailNavigation.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/1.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SnapKit

class GYShopDetailNavigation: UIView {

    var backItem:UIButton?
    var shareItem:UIButton?
    var itemName:UILabel?
    var superController:UIViewController?
    
    convenience init(frame: CGRect, superController: UIViewController) {
        self.init(frame: frame)
        superController.view.addSubview(self)
        self.superController = superController
        
        setupSubviews()
    }
    
    @objc fileprivate func buttonAction(sender:UIButton) {
        if 100 == sender.tag {
            self.superController?.navigationController?.popViewController(animated: true)
        }else{
            print("分享")
        }
    }
    
    func scrollContentOffSet(offSet:CGFloat) {
        if offSet <= 90 {
            UIApplication.shared.statusBarStyle = .default
            backItem?.setImage(UIImage.init(named: "au_fanhui"), for: UIControl.State.normal)
            shareItem?.setImage(UIImage.init(named: "au_fenxiang"), for: UIControl.State.normal)
            backgroundColor = UIColor.colorConversion(Color_Value: "#ffffff", alpha: offSet/90)
            itemName?.isHidden = true
        }else{
            UIApplication.shared.statusBarStyle = .lightContent
            backItem?.setImage(UIImage.init(named: "au_bigback"), for: UIControl.State.normal)
            shareItem?.setImage(UIImage.init(named: "au_bigshare"), for: UIControl.State.normal)
            backgroundColor = UIColor.colorConversion(Color_Value: "#ffffff", alpha: 1)
            itemName?.isHidden = false
        }
    }
    
    fileprivate func setupSubviews() {
        if backItem == nil {
            backItem = UIButton(type: UIButton.ButtonType.custom)
            backItem?.setImage(UIImage(named: "au_fanhui"), for: UIControl.State.normal)
            self.addSubview(backItem!)
            backItem?.tag = 100
            backItem?.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        }
        if shareItem == nil {
            shareItem = UIButton(type: UIButton.ButtonType.custom)
            shareItem?.setImage(UIImage(named: "au_fenxiang"), for: UIControl.State.normal)
            self.addSubview(shareItem!)
            shareItem?.tag = 101
            shareItem?.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        }
        if itemName == nil {
            itemName = UILabel()
            itemName?.text = "商品详情"
            itemName?.isHidden = true
            itemName?.font = UIFont.systemFont(ofSize: 14)
            itemName?.textAlignment = NSTextAlignment.center
            self.addSubview(itemName!)
        }
        
        backItem?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(kNavStatusHeight)
            make.width.height.equalTo(44)
        })
        shareItem?.snp.makeConstraints({ (make) in
            make.right.equalTo(0)
            make.top.equalTo(kNavStatusHeight)
            make.width.height.equalTo(44)
        })
        itemName?.snp.makeConstraints({ (make) in
            make.top.equalTo(kNavStatusHeight)
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.bottom.equalTo(0)
        })
        
        
    }
    
    
    

}
