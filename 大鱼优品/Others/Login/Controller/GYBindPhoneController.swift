//
//  GYBindPhoneController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/11.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD

class GYBindPhoneController: UIViewController,bindLoginSureButtonDelegate {

    var icon:String?
    var nickName:String?
    var loginType:String? /// 绑定账号的名称  微信 等
    var openId:String?
    fileprivate var bindType:NSInteger = 1 /// 1 初次绑定  2 替换绑定
    
    fileprivate var bindView:GYBindLoginView?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "联合登录"
        
        self.view.backgroundColor = UIColor.white
        
        bindView = GYBindLoginView.init(frame: view.frame, superController: self)
        bindView?.headerImgView?.sd_setImage(with: URL(string: icon!), placeholderImage: UIImage.init(named: imageView_nodata))
        bindView?.nickNameL?.text = nickName
        bindView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func bindLoginSureButtonAction() {
        /// RSA 加密
        let crsa = CRSA()
        crsa.writePuk(withKey: PubKey)
        let phone:String = (bindView?.phoneTF?.text)!
        let code:String = (bindView?.pwdTF?.text)!
        let id = openId
        let bindToken:String = crsa.encryptByRsa(with: "\(phone)##\(code)##\(id!)##\(NSObject.getDevice())", keyType: KeyTypePublic)
        /// 登录参数
        let params = ["bindToken":bindToken,
                      "type":bindType,
                      ] as [String:AnyObject]
        print(params)
        SVProgressHUD.show(withStatus: "绑定中...")
        GYNetworkTool.postRequest(urlString: LOGIN_THIRDPARTY_BINDPHONE, params: params, success: { (response) in
            SVProgressHUD.dismiss()
            print(JSON(response))
            let json = JSON(response)
            if json["state"].intValue == 0 {
                let userAccount = GYUserModel(dict:response as! [String : AnyObject])
                let path = SearchPathFordocumentDirectory() + Login_Cache
                NSKeyedArchiver.archiveRootObject(userAccount, toFile:path)
                let alert = GYAlertView.alertSingleViewWithTitle(title: "关联成功", sure: "确定", sureClick: {
                    UIApplication.shared.keyWindow?.rootViewController = GYTabbarController()
                })
                self.present(alert, animated: true, completion: nil)
            }else if json["state"].intValue == 6 {
                print("替换绑定")
                let alert = GYAlertView.alertDoubleViewWithTitle(title: "该手机号已经被关联到\(self.loginType!)账号：\(self.nickName!)，是否替换此关联", cancel: "取消", sure: "替换关联", cancelClick: {
                }, sureClick: {
                    self.bindType = 2   /// 替换关联的标志
                    self.bindLoginSureButtonAction()
                })
                self.present(alert, animated: true, completion: nil)
            }else{
                SVProgressHUD.show(withStatus: json["stateMsg"].stringValue)
            }
        }) { (error) in
            SVProgressHUD.dismiss()
            print(error)
        }
    }
    
    

}
