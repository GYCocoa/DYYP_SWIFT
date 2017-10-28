//
//  GYLoginController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/19.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON


class GYLoginController: UIViewController {

    var loginView:GYLoginView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelAction))
        createSubviews()
    }
    
    @objc private func cancelAction() {
        let tabbar = GYTabbarController()
        UIApplication.shared.keyWindow?.rootViewController = tabbar
    }
    
    private func createSubviews() {
        loginView = GYLoginView(frame: view.frame, superView: view)
        for button in (loginView?.buttonSources)! {
            (button as AnyObject).addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        }
    }
    
    @objc private func buttonAction(sender:UIButton) {
        switch sender.tag {
        case 100:
            wechatMethods()
            break
        case 101:
            phoneMethods()
            break
        case 102:
            qqMethods()
            break
        case 103:
            sinaMethods()
            break
        default:
            break
        }
    }
    private func phoneMethods() {
        self.navigationController?.pushViewController(GYPhoneLoginController(), animated: true)
    }
    private func wechatMethods() {
        thirdloginMethods(platformType: SSDKPlatformType.typeWechat, type: 3)
    }
    private func qqMethods() {
        thirdloginMethods(platformType: SSDKPlatformType.typeQQ, type: 1)
    }
    private func sinaMethods() {
        thirdloginMethods(platformType: SSDKPlatformType.typeSinaWeibo, type: 2)
    }
    
    fileprivate func thirdloginMethods(platformType:SSDKPlatformType,type:NSInteger) {
        SVProgressHUD.show(withStatus: "请稍后...")
        ShareSDK.cancelAuthorize(platformType)
        ShareSDK.getUserInfo(platformType) { (responseState, user, error) in
            SVProgressHUD.dismiss()
            if responseState == SSDKResponseState.success {
                /**
                 * @param loginToken: 加密token
                 * @param name: 用户名
                 * @param icon: 用户头像
                 * @param gender: 用户性别
                 * @param os: 设备号
                 * 第三方 type 1：qq ; 2：微博 ；3：微信
                 */
                let openId:String = (user?.uid)!
                let token:String = (user?.credential.token)!
                let name = user?.nickname
                let icon = user?.icon
                let gender = user?.gender
                let os = NSObject.getDevice()
                /// RSA 加密
                let crsa = CRSA()
                crsa.writePuk(withKey: PubKey)
                let loginToken:String = crsa.encryptByRsa(with: "\(type)##\(openId)##\(token)", keyType: KeyTypePublic)
                /// 登录参数
                let params = ["loginToken":loginToken,
                              "name":name!,
                             "icon":icon!,
                             "gender":gender!,
                             "os":os,] as [String:AnyObject]
                var loginType = ""
                if type == 1 {
                    loginType = "QQ"
                }else if type == 2 {
                    loginType = "新浪"
                }else if type == 3 {
                    loginType = "微信"
                }
                self.requestThirdsMethods(params: params as NSDictionary, loginType: loginType)
            }
        }
    }
    
    fileprivate func requestThirdsMethods(params:NSDictionary,loginType:String) {
        SVProgressHUD.show(withStatus: "请稍后...")
        GYNetworkTool.postRequest(urlString: LOGIN_THIRDPARTY, params: params as! [String : Any], success: { (response) in
            SVProgressHUD.dismiss()
            print(response)
            let json = JSON(response)
            if json["state"].intValue == 0 {
                let userAccount = GYUserModel(dict:response as! [String : AnyObject])
                let path = SearchPathFordocumentDirectory() + Login_Cache
                ///归档
                NSKeyedArchiver.archiveRootObject(userAccount, toFile:path)
                UIApplication.shared.keyWindow?.rootViewController = GYTabbarController()
            }else if json["state"].intValue == 6 {
                print("未绑定手机号")
                let bind = GYBindPhoneController()
                bind.icon = params.value(forKey: "icon") as? String
                bind.nickName = params.value(forKey: "name") as? String
                bind.openId = json["userId"].stringValue
                bind.loginType = loginType
                self.navigationController?.pushViewController(bind, animated: true)
            }else{
                SVProgressHUD.showInfo(withStatus: json["stateMsg"].stringValue)
            }

        }) { (error) in
            SVProgressHUD.dismiss()
            print(error)
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
