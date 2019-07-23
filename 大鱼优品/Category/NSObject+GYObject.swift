
//
//  NSObject+GYObject.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import Foundation

extension NSObject {
    /*
     * @param str: 字符串
     * @param font: 字体大小
     * @param reduce: 最大宽度减少的大小
     */
    class func adaptiveSizeWithString(str:String,font:CGFloat,reduce:CGFloat)->(CGSize) {
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: font)]
        var rect = CGRect()
        rect = str.boundingRect(with: CGSize.init(width: kWidth-reduce, height: CGFloat(INT_MAX)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes , context: nil)
        return rect.size
    }
    
    
    
    class func shareMethods(content:String,imageUrl:String,shareUrl:String,title:String) {
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: content,
                                          images : UIImage(named: imageUrl),
                                          url : NSURL(string:shareUrl) as URL?,
                                          title : title,
                                          type : SSDKContentType.image)
        //2.进行分享
        ShareSDK.share(SSDKPlatformType.typeWechat, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
            switch state{
            case SSDKResponseState.success: print("分享成功")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("操作取消")
            default:
                break
            }
        }
    }
    
    
}


