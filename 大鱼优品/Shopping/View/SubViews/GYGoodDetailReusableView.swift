//
//  GYGoodDetailReusableView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/4.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYGoodDetailReusableView: UIView {

    class func reusableView() -> GYGoodDetailReusableView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! GYGoodDetailReusableView
    }


}
