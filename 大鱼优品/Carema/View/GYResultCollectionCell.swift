//
//  GYResultCollectionCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYResultCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model:GYCaremaResult? {
        
        didSet {
            if model?.pfromImage != nil {
                imgView.sd_setImage(with: URL(string:(model?.pfromImage)!), placeholderImage: UIImage(named:imageView_nodata))
            }
            if model?.pname != nil {
                contentL.text = model?.pname
            }
            if model?.price != nil {
                priceL.text = "￥" + (model?.price?.stringValue)!
            }
            if model?.remarkCount != nil {
                let str = model?.remarkCount
                commentCount.text = "\(str!)人评论"
            }
        }
        
    }
    
    

}
