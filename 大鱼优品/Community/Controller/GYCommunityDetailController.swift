//
//  GYCommunityDetailController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/8.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SnapKit

class GYCommunityDetailController: GYBaseViewController {

    var weiboId:NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "详情"
        
        setupButtonItems()
        
        print("weiboId = \(weiboId)")
    }

    fileprivate func setupButtonItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "cycle_point"), style: UIBarButtonItemStyle.done, target: self, action: #selector(rightAction))
        self.detailBottom.backgroundColor = UIColor.white
    }
    @objc fileprivate func rightAction() {
    }
    
    fileprivate lazy var detailBottom: GYCommunityDetailBottom = {
        var detailBottom = GYCommunityDetailBottom.detailBottom()
        self.view.addSubview(detailBottom)
        detailBottom.frame = CGRect.init(x: 0, y: kHeight-40, width: kWidth, height: 40)
        return detailBottom
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var frame = self.detailBottom.frame
        if #available(iOS 11.0, *) {
            frame.origin.y = self.view.bounds.size.height - frame.size.height - JF_BOTTOM_SPACE
        } else {
            // Fallback on earlier versions
        }
        self.detailBottom.frame = frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
