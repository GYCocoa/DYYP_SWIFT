//
//  GYAlertView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/25.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYAlertView: NSObject {

    class func alertOriginalViewWithTitle(title: String,cancel:String,sure:String,cancelClick:@escaping()->(),sureClick:@escaping()->())->UIAlertController {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction.init(title: cancel, style: UIAlertActionStyle.cancel) { (action) in
            cancelClick()
        }
        let sureAction = UIAlertAction.init(title: sure, style: UIAlertActionStyle.destructive) { (action) in
            sureClick()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(sureAction)
        return alertController
    }
    
    class func alertDoubleViewWithTitle(title: String,cancel:String,sure:String,cancelClick:@escaping()->(),sureClick:@escaping()->())->UIAlertController {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction.init(title: cancel, style: UIAlertActionStyle.cancel) { (action) in
            cancelClick()
        }
        let sureAction = UIAlertAction.init(title: sure, style: UIAlertActionStyle.destructive) { (action) in
            sureClick()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(sureAction)
        return alertController
    }
    
    class func alertSingleViewWithTitle(title: String,sure:String,sureClick:@escaping()->())->UIAlertController {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let sureAction = UIAlertAction.init(title: sure, style: UIAlertActionStyle.default) { (action) in
            sureClick()
        }
        alertController.addAction(sureAction)
        return alertController
    }
    
}
