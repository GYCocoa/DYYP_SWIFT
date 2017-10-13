//
//  GYResultTipsCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYResultTipsCell: UICollectionViewCell {
    
    var tipLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        if tipLabel == nil {
            tipLabel = UILabel.init(frame: self.bounds)
            tipLabel?.font = UIFont.systemFont(ofSize: 11)
            tipLabel?.textColor = UIColor.white
            contentView.addSubview(tipLabel!)
            tipLabel?.backgroundColor = UIColor.globalMainColor()
            tipLabel?.clipsToBounds = true
            tipLabel?.layer.cornerRadius = 10
            tipLabel?.textAlignment = NSTextAlignment.center
        }
    
    }
    
    
    
}
