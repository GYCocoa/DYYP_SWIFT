//
//  GYCaremaCollectionHeader.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCaremaCollectionHeader: UICollectionReusableView {

    var button:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.button = UIButton.init(frame: self.bounds)
        self.button.setImage(UIImage.init(named: "ic_sreach_up"), for: UIControlState.normal)
        self.addSubview(self.button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
