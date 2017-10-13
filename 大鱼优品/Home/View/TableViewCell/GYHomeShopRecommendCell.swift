//
//  GYHomeShopRecommendCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYHomeShopRecommendCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        scaleL.layer.borderColor = UIColor.colorConversion(Color_Value: "fd6363", alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var shop : GYShopModel? {
        didSet {
            if shop?.picUrl != nil {
                let image = IMAGEURL + (shop?.picUrl)!
                imgView.sd_setImage(with: URL(string:image), placeholderImage: UIImage(named:"image_noda"))
            }
            if shop?.title != nil {
                nameL.text = shop?.title
            }
            if shop?.price != nil {
                let price:Int = (shop?.price)!
                priceL.text = "￥\(String(price))"
            }
            if shop?.platform != nil  {
                scaleL.setTitle(shop?.platform, for: UIControlState.normal)
            }
            if shop?.fromat != nil {
                scaleL.isHidden = false
                scaleL.setTitle(shop?.fromat, for: UIControlState.normal)
            }else{
                scaleL.isHidden = true
            }
            if shop?.viewSales != nil {
                let sale:Int = (shop?.viewSales)!
                saleCountL.text = "全网销量\(String(sale))"
            }
            if shop?.shopCount != nil {
                let compareCount:Int = (shop?.viewSales)!
                compareL.text = "\(String(compareCount))商家比价"
            }
        }
    }
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var tagL: UILabel!
    @IBOutlet weak var scaleL: UIButton!
    @IBOutlet weak var saleCountL: UILabel!
    @IBOutlet weak var compareL: UILabel!
    
    
    
}
