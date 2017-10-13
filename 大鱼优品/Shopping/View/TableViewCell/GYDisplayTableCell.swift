//
//  GYDisplayTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/28.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYDisplayTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var countL: UILabel!
    
    
    var homeModel:CategoryModel? {
        didSet {
            if homeModel?.productImage != nil {
                bgImageView?.sd_setImage(with: URL(string:(homeModel?.productImage)!), placeholderImage: UIImage(named:"image_noda"))
            }
            if homeModel?.productName != nil {
                titleL.text = homeModel?.productName
            }
            if homeModel?.price != nil {
                priceL.text = "￥" + (homeModel?.price?.stringValue)!
            }
            if homeModel?.purchasedQuantity != nil {
                countL.text = "已团\(String(describing: homeModel?.purchasedQuantity))件"
            }
        }
    }
    
    var categoryModel:CategoryModel? {
        didSet {
            if categoryModel?.productImage != nil {
                bgImageView?.sd_setImage(with: URL(string:(categoryModel?.productImage)!), placeholderImage: UIImage(named:"image_noda"))
            }
            if categoryModel?.productName != nil {
                titleL.text = categoryModel?.productName
            }
            if categoryModel?.price != nil {
                priceL.text = "￥" + (categoryModel?.price?.stringValue)!
            }
            if categoryModel?.purchasedQuantity != nil {
                countL.text = "已团\(String(describing: categoryModel?.purchasedQuantity))件"
            }
        }
    }
    
    
    
}
