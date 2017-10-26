//
//  GYShopDetailBottomView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYShopDetailBottomView: UIView {


    
    
    
    
    class func bottomView() -> GYShopDetailBottomView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! GYShopDetailBottomView
    }

}
