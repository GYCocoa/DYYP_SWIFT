//
//  GYGoodShopReusableView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/4.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYGoodShopReusableView: UIView {

    class func shopReusableView() -> GYGoodShopReusableView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! GYGoodShopReusableView
    }

}
