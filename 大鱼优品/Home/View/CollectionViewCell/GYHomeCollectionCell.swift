//
//  GYHomeCollectionCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SDWebImage
class GYHomeCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /// 全网首页
    var model : GYHomeModel? {
        didSet {
            if model?.image != nil {
                let image = model?.image
                imgView.sd_setImage(with: URL(string:image!), placeholderImage: UIImage(named:imageView_nodata))
            }
            if model?.Description != nil {
                contentL.text = model?.pname
            }
            if model?.price != nil {
                priceL.text = "￥" + (model?.price?.stringValue)!
            }
        }
    }
    /// 自营限时秒杀
    var snapup : GYSnapupModel? {
        didSet {
            if snapup?.productImage != nil {
                imgView.sd_setImage(with: URL(string:(snapup?.productImage)!), placeholderImage: UIImage(named:imageView_nodata))
            }
            if snapup?.productName != nil {
                contentL.text = snapup?.productName
            }
            if snapup?.price != nil {
                priceL.text = "￥" + (snapup?.price?.stringValue)!
            }
        }
    }
    
    /// 自营hot
    var hotModel : GYSnapupModel? {
        didSet {
            if hotModel?.productImage != nil {
                imgView.sd_setImage(with: URL(string:(hotModel?.productImage)!), placeholderImage: UIImage(named:imageView_nodata))
            }
            if hotModel?.productName != nil {
                contentL.text = hotModel?.productName
            }
            if hotModel?.price != nil {
                priceL.text = "￥" + (hotModel?.price?.stringValue)!
            }
        }
    }
    
    /// 商品详情页面  推荐店铺
    var detailModel : GYShopDetailModel? {
        didSet {
            if detailModel?.productImage != nil {
                imgView.sd_setImage(with: URL(string:(detailModel?.productImage)!), placeholderImage: UIImage(named:imageView_nodata))
            }
            if detailModel?.productName != nil {
                contentL.text = detailModel?.productName
            }
            if detailModel?.price != nil {
                priceL.text = "￥" + (detailModel?.price?.stringValue)!
            }
        }
    }
    
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    

}
