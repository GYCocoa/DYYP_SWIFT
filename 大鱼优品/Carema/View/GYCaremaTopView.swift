//
//  GYCaremaTopView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/30.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCaremaTopView: UIView {

    fileprivate var cancel:UIButton?
    fileprivate var flash:UIButton?
    fileprivate var cycle:UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        cancel = UIButton(type: UIButtonType.custom)
        cancel?.setImage(UIImage(named: "ic_sreach_09"), for: UIControlState.normal)
        cancel?.tag = 100
        self.addSubview(cancel!)
        flash = UIButton(type: UIButtonType.custom)
        flash?.setImage(UIImage(named: "ic_sreach_03"), for: UIControlState.normal)
        flash?.tag = 101
        self.addSubview(flash!)
        cycle = UIButton(type: UIButtonType.custom)
        cycle?.setImage(UIImage(named: "ic_sreach_06"), for: UIControlState.normal)
        cycle?.tag = 102
        self.addSubview(cycle!)
        
        buttonArray.add(cancel!)
        buttonArray.add(flash!)
        buttonArray.add(cycle!)

        reloadLayoutSubViews()
    }
    fileprivate func reloadLayoutSubViews() {
        cancel?.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.left.equalTo(10)
            make.width.height.equalTo(44)
        })
        cycle?.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.right.equalTo(-10)
            make.width.height.equalTo(44)
        })
        flash?.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.right.equalTo((cycle?.snp.left)!).offset(-10)
            make.width.height.equalTo(44)
        })
    }
    
    lazy var buttonArray: NSMutableArray = {
        var buttonArray = NSMutableArray()
        return buttonArray
    }()
}
