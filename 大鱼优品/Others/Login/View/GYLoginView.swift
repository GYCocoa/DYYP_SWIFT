//
//  GYLoginView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/19.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SnapKit

class GYLoginView: UIView {

    var chooseLabel:UILabel?
    var weChatButton:UIButton?
    var otherLabel:UILabel?
    var phoneButton:UIButton?
    var qqButton:UIButton?
    var sinaButton:UIButton?
    
    convenience init(frame: CGRect, superView: UIView) {
        self.init(frame: frame)
        superView.addSubview(self)
        
        initSubviews()
    }
    
    private func initSubviews() {
        buttonSources.removeAllObjects()
        
        if (chooseLabel == nil) {
            chooseLabel = UILabel.init()
            chooseLabel?.text = "请选择登录方式"
            chooseLabel?.textAlignment = NSTextAlignment.center
            chooseLabel?.textColor = UIColor.gray
            chooseLabel?.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(chooseLabel!)
        }
        if (weChatButton == nil) {
            weChatButton = UIButton.init(type: UIButton.ButtonType.custom)
            weChatButton?.setBackgroundImage(UIImage(named:"au_weixin"), for: UIControl.State.normal)
            weChatButton?.tag = 100
            self.addSubview(weChatButton!)
        }
        buttonSources.add(weChatButton!)
        if (otherLabel == nil) {
            otherLabel = UILabel.init()
            otherLabel?.text = "其他登录方式"
            otherLabel?.font = UIFont.systemFont(ofSize: 13)
            otherLabel?.textColor = UIColor.gray
            otherLabel?.textAlignment = NSTextAlignment.center
            self.addSubview(otherLabel!)
        }
        if (phoneButton == nil) {
            phoneButton = UIButton.init(type: UIButton.ButtonType.custom)
            phoneButton?.setImage(UIImage(named:"au_phone"), for: UIControl.State.normal)
            phoneButton?.setTitle("手机号登录", for: UIControl.State.normal)
            phoneButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            phoneButton?.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            phoneButton?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            phoneButton?.tag = 101
            self.addSubview(phoneButton!)
        }
        buttonSources.add(phoneButton!)
        if (qqButton == nil) {
            qqButton = UIButton.init(type: UIButton.ButtonType.custom)
            qqButton?.setImage(UIImage(named:"au_qq"), for: UIControl.State.normal)
            qqButton?.setTitle("QQ登录", for: UIControl.State.normal)
            qqButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            qqButton?.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            qqButton?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            qqButton?.tag = 102
            self.addSubview(qqButton!)
        }
        buttonSources.add(qqButton!)
        if (sinaButton == nil) {
            sinaButton = UIButton.init(type: UIButton.ButtonType.custom)
            sinaButton?.setImage(UIImage(named:"au_weibo"), for: UIControl.State.normal)
            sinaButton?.setTitle("微博登录", for: UIControl.State.normal)
            sinaButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            sinaButton?.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            sinaButton?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            sinaButton?.tag = 103
            self.addSubview(sinaButton!)
        }
        buttonSources.add(sinaButton!)
        self.autolayoutSubviews()
    }
    
    private func autolayoutSubviews() {
        chooseLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(100*scaleH)
            make.left.right.equalTo(0)
        })
        weChatButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((chooseLabel?.snp.bottom)!).offset(30)
            make.left.equalTo(60*scaleW)
            make.right.equalTo(-60*scaleW)
            make.height.equalTo(40*scaleH)
        })
        phoneButton?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-50*scaleH)
            make.left.equalTo(0)
            make.width.height.equalTo(kWidth/3)
        })
        qqButton?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-50*scaleH)
            make.left.equalTo(kWidth/3)
            make.width.height.equalTo(kWidth/3)
        })
        sinaButton?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-50*scaleH)
            make.left.equalTo(kWidth/3*2)
            make.width.height.equalTo(kWidth/3)
        })
        otherLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo((qqButton?.snp.top)!).offset(20)
            make.left.right.equalTo(0)
        })
        
        phoneButton?.titleEdgeInsets = UIEdgeInsets(top: (phoneButton?.imageView?.frame.size.height)!+50 ,left: -(phoneButton?.imageView?.frame.size.width)!, bottom: 0.0,right: 0.0)
        phoneButton?.imageEdgeInsets = UIEdgeInsets(top: 0 ,left: 12, bottom: 0.0,right: -(phoneButton?.imageView?.frame.size.width)!)
        qqButton?.titleEdgeInsets = UIEdgeInsets(top: (qqButton?.imageView?.frame.size.height)!+50 ,left: -(qqButton?.imageView?.frame.size.width)!+5, bottom: 0.0,right: 0.0)
        qqButton?.imageEdgeInsets = UIEdgeInsets(top: 0 ,left: 0, bottom: 0.0,right: -(qqButton?.imageView?.frame.size.width)!)
        sinaButton?.titleEdgeInsets = UIEdgeInsets(top: (sinaButton?.imageView?.frame.size.height)!+50 ,left: -(sinaButton?.imageView?.frame.size.width)!, bottom: 0.0,right: 0.0)
        sinaButton?.imageEdgeInsets = UIEdgeInsets(top: 0 ,left: 0, bottom: 0.0,right: -(sinaButton?.imageView?.frame.size.width)!)
        
    }
    
    lazy var buttonSources: NSMutableArray = {
        var buttonSources = NSMutableArray()
        return buttonSources
    }()

}
