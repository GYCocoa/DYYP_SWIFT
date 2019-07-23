//
//  GYHomeSpecialCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYHomeSpecialCell: UITableViewCell {

    var imgView:UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if imgView == nil {
            imgView = UIImageView()
            imgView?.image = UIImage(named:"image_nodata")
            imgView?.clipsToBounds = true
            imgView?.contentMode = .scaleAspectFill
            self.addSubview(imgView!)
            imgView?.snp.makeConstraints({ (make) in
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.top.equalTo(5)
                make.bottom.equalTo(-5)
            })
        }
        
    }
    
    var special:GYHomeSpecial? {
        didSet {
            if ((special?.image) != nil) {
                imgView?.sd_setImage(with: URL(string:(special?.image)!), placeholderImage: UIImage(named:"image_noda"))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
