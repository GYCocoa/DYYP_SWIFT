//
//  GYSettingCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/25.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYSettingCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        if itemNameL == nil {
            itemNameL = UILabel()
            itemNameL?.font = UIFont.systemFont(ofSize: 12)
            contentView.addSubview(itemNameL!)
        }
        if itemContentL == nil {
            itemContentL = UILabel()
            itemContentL?.font = UIFont.boldSystemFont(ofSize: 14)
            itemContentL?.textAlignment = NSTextAlignment.right
            contentView.addSubview(itemContentL!)
        }
        if bottomLine == nil {
            bottomLine = UIView()
            bottomLine?.backgroundColor = UIColor.globalGrayColor()
            contentView.addSubview(bottomLine!)
        }
        
        setupAutolayout()
    }
    
    fileprivate func setupAutolayout() {
        itemNameL?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(15)
            make.width.equalTo(contentView.width/2)
        })
        itemContentL?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(-20)
            make.width.equalTo(contentView.width/2)
        })
        bottomLine?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5)
        })
        
    }
    
    var itemNameL:UILabel?
    var itemContentL:UILabel?
    var bottomLine:UIView?
}
