//
//  GYShopDetailTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYShopDetailTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var commentTimeL: UILabel!
    @IBOutlet weak var replyContentL: UILabel!
    
    @IBOutlet weak var styleL: UILabel!
    
    var indexPathRow:NSInteger? {
        didSet {
            if indexPathRow == 0 {
                self.replyView.isHidden = true
            }else{
                self.replyView.isHidden = false
            }
        }
    }
    
    
}
