//
//  GYCommunityReUsersCVCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/23.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityReUsersCVCell: UICollectionViewCell {

    
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var focusBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        headerImgView.layer.cornerRadius = ((kWidth-40)/3 - 30) / 2
        
    }
    
    var model:GYCommunityModel? {
        didSet {
            if model?.icon != nil {
                headerImgView.sd_setImage(with: NSURL(string: (model?.icon)!) as URL?, placeholderImage: UIImage.init(named: imageView_nodata))
            }
            nickNameL.text = model?.nickName
        }
    }
    
    @IBAction func focusAction(_ sender: UIButton) {
    }
    
    
    
    
}
