//
//  GYShopDetailFooterView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/27.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYShopDetailFooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataDic:NSDictionary? {
        didSet {
            layoutConstraints()
        }
    }
    
    fileprivate func layoutConstraints() {
        
    }

}
