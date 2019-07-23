//
//  GYBindLoginView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/11.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol bindLoginSureButtonDelegate:NSObjectProtocol {
    func bindLoginSureButtonAction()
}
class GYBindLoginView: UIView,UITextFieldDelegate {
    
    var phoneTF:UITextField?
    var pwdTF:UITextField?
    var codeButton:UIButton?
    var sureButton:UIButton?
    var superVc:UIViewController?
    private var countdownTimer: Timer?
    
    var headerImgView:UIImageView?
    var nickNameL:UILabel?
    var bottomL:UILabel?
    
    var delegate : bindLoginSureButtonDelegate?
    
    convenience init(frame: CGRect,superController:UIViewController) {
        self.init(frame: frame)
        superController.view.addSubview(self)
        superVc = superController
        createSubviews()
    }
    private func createSubviews() {
        
        if headerImgView == nil {
            headerImgView = UIImageView()
            headerImgView?.contentMode = UIView.ContentMode.scaleToFill
            self.addSubview(headerImgView!)
        }
        if nickNameL == nil {
            nickNameL = UILabel()
            nickNameL?.textAlignment = NSTextAlignment.center
            nickNameL?.font = UIFont.systemFont(ofSize: 15)
            nickNameL?.textColor = UIColor.colorConversion(Color_Value: "#444444", alpha: 1)
            self.addSubview(nickNameL!)
        }
        if bottomL == nil {
            bottomL = UILabel()
            bottomL?.textAlignment = NSTextAlignment.center
            bottomL?.font = UIFont.systemFont(ofSize: 15)
            bottomL?.textColor = UIColor.colorConversion(Color_Value: "#BC0000", alpha: 1)
            bottomL?.text = "请关联手机号，以保证订单收货及账号的管理"
            self.addSubview(bottomL!)
        }
        if phoneTF == nil {
            phoneTF = UITextField.init()
            phoneTF?.placeholder = "请输入手机号"
            phoneTF?.font = UIFont.systemFont(ofSize: 14)
            phoneTF?.clearButtonMode = UITextField.ViewMode.whileEditing
            phoneTF?.keyboardType = UIKeyboardType.numberPad
            phoneTF?.delegate = self
            phoneTF?.addTarget(self, action: #selector(textFieldExchange), for: UIControl.Event.editingChanged)
            self.addSubview(phoneTF!)
        }
        if pwdTF == nil {
            pwdTF = UITextField.init()
            pwdTF?.placeholder = "请输入验证码"
            pwdTF?.font = UIFont.systemFont(ofSize: 14)
            pwdTF?.keyboardType = UIKeyboardType.numberPad
            pwdTF?.delegate = self
            pwdTF?.addTarget(self, action: #selector(textFieldExchange), for: UIControl.Event.editingChanged)
            self.addSubview(pwdTF!)
        }
        if (codeButton == nil) {
            codeButton = UIButton.init(type: UIButton.ButtonType.custom)
            codeButton?.setTitle("获取验证码", for: UIControl.State.normal)
            codeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            codeButton?.setTitleColor(UIColor.black, for: UIControl.State.normal)
            codeButton?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
            codeButton?.tag = 100
            self.addSubview(codeButton!)
            codeButton?.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        }
        if (sureButton == nil) {
            sureButton = UIButton.init(type: UIButton.ButtonType.custom)
            sureButton?.setTitle("确定", for: UIControl.State.normal)
            sureButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            sureButton?.backgroundColor = UIColor.colorConversion(Color_Value: "#999999", alpha: 0.8)
            sureButton?.tag = 101
            sureButton?.layer.cornerRadius = 2
            self.addSubview(sureButton!)
            sureButton?.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        }
        autolayoutSubviews()
    }
    @objc private func buttonAction(sender:UIButton) {
        switch sender.tag {
        case 100:
            getCodeMethods()
            break
        case 101:
            sureButtonMethods()
            break
        default:
            break
        }
    }
    @objc private func textFieldExchange(textField:UITextField) { /// 监听输入框
        if textField == pwdTF {
            if (pwdTF?.text?.count)! >= 4 {
                sureButton?.backgroundColor = UIColor.RGBColor(r: 253, g: 99, b: 99, a: 1)
            }else{
                sureButton?.backgroundColor = UIColor.colorConversion(Color_Value: "#999999", alpha: 0.8)
            }
        }else if textField == phoneTF {
            if (phoneTF?.text?.count)! >= 11 {
                codeButton?.setTitleColor(UIColor.RGBColor(r: 253, g: 99, b: 99, a: 1), for: UIControl.State.normal)
            }else{
                codeButton?.setTitleColor(UIColor.black, for: UIControl.State.normal)
            }
        }
    }
    
    private func getCodeMethods() { /// 获取验证码
        print("获取验证码")
        guard NSObject.isPhoneNumber(phoneNumber: (phoneTF?.text)!) else {
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号")
            return
        }
        isCounting = true
        /// 获取验证码网络请求
        GYNetworkTool.getphoneCodeData(phone: (phoneTF?.text)!, completionHandler: { (response) in
            print("请求成功")
        }) { (error) in
            print("请求失败")
        }
        
    }
    @objc private func timerAction() {
        remainingSeconds -= 1
    }
    private var remainingSeconds: Int = 0 {
        willSet {
            codeButton?.setTitle("重新获取\(newValue)秒", for: .normal)
            if newValue <= 0 {
                codeButton?.setTitle("获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false { /// 添加倒计时
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                remainingSeconds = 60
                codeButton?.setTitleColor(UIColor.gray, for: .normal)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                codeButton?.setTitleColor(UIColor.black, for: .normal)
            }
            codeButton?.isEnabled = !newValue
        }
    }
    private func sureButtonMethods() {
        print("确定按钮")
        guard NSObject.isPhoneNumber(phoneNumber: (phoneTF?.text)!) else {
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号")
            return
        }
        guard (pwdTF?.text?.count)! >= 4 else {
            SVProgressHUD.showInfo(withStatus: "请输入正确的验证码")
            return
        }
//        GYNetworkTool.getloginData(phone: (phoneTF?.text)!, code: (pwdTF?.text)!, os: NSObject.getDevice(), completionHandler: { (response) in
//            print("success = \(response)")
//            let userAccount = GYUserModel(dict:response as! [String : AnyObject])
//            let path = SearchPathFordocumentDirectory() + Login_Cache
//            ///归档
//            NSKeyedArchiver.archiveRootObject(userAccount, toFile:path)
//            UIApplication.shared.keyWindow?.rootViewController = GYTabbarController()
//        }) { (error) in
//            print("request error = \(error)")
//        }
        if delegate != nil {
            delegate?.bindLoginSureButtonAction()
        }
    }
    
    private func autolayoutSubviews() {
        headerImgView?.snp.makeConstraints { (make) in
            make.top.equalTo(100*scaleH)
            make.left.equalTo(kWidth/2-30)
            make.width.height.equalTo(60)
        }
        nickNameL?.snp.makeConstraints { (make) in
            make.top.equalTo((headerImgView?.snp.bottom)!).offset(15)
            make.left.right.equalTo(0)
            make.height.equalTo(16)
        }
        phoneTF?.snp.makeConstraints({ (make) in
            make.top.equalTo((nickNameL?.snp.bottom)!).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        })
        pwdTF?.snp.makeConstraints({ (make) in
            make.top.equalTo((phoneTF?.snp.bottom)!).offset(0)
            make.left.equalTo(20)
            make.right.equalTo(-kWidth/3)
            make.height.equalTo(40)
        })
        let phoneLine = UIView.init(frame: CGRect.init(x: 0, y: 39, width: kWidth-40, height: 1))
        phoneLine.backgroundColor = UIColor.RGBColor(r: 243, g: 244, b: 245, a: 1)
        phoneTF?.addSubview(phoneLine)
        let pwdLine = UIView.init(frame: CGRect.init(x: 0, y: 39, width: kWidth-40, height: 1))
        pwdLine.backgroundColor = UIColor.RGBColor(r: 243, g: 244, b: 245, a: 1)
        pwdTF?.addSubview(pwdLine)
        codeButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((phoneTF?.snp.bottom)!).offset(0)
            make.right.equalTo(-20)
            make.width.equalTo(kWidth/3-20)
            make.height.equalTo(40)
        })
        sureButton?.snp.makeConstraints({ (make) in
            make.top.equalTo((codeButton?.snp.bottom)!).offset(50)
            make.left.equalTo(90*scaleW)
            make.right.equalTo(-90*scaleW)
            make.height.equalTo(40)
        })
        bottomL?.snp.makeConstraints { (make) in
            make.bottom.equalTo(-50)
            make.left.right.equalTo(0)
            make.height.equalTo(16)
        }
    }
    
}
