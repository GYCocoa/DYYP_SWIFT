//
//  GYCommunityHomeTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/13.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityHomeTableCell: UITableViewCell {
/// 132 + imageH
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var nickNameL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var contentL: UILabel!
    @IBOutlet weak var bodyImgView: UIImageView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var collectionBtn: UIButton!
    @IBOutlet weak var pariseBtn: UIButton!
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        
    }
    
    
    
    
}
