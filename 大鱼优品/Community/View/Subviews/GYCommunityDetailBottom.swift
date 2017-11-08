//
//  GYCommunityDetailBottom.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/8.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityDetailBottom: UIView {


    class func detailBottom() -> GYCommunityDetailBottom {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! GYCommunityDetailBottom
    }
    
    
    

}
