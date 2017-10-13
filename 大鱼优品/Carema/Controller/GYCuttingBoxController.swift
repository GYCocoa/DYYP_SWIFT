//
//  GYCuttingBoxController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/10.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCuttingBoxController: GYBaseViewController {
    
    var cuttingImg:UIImage?
    var range:NSDictionary?
    fileprivate var bgImageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.black
        setupFunction()
        
    }
    
    fileprivate func setupFunction() {
        
        self.bgImageView = UIImageView.init(frame: self.view.bounds)
        self.bgImageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.bgImageView?.image = cuttingImg
        self.view.addSubview(self.bgImageView!)
        
        let cancel = UIButton(type: UIButtonType.custom)
        cancel.setImage(UIImage(named: "ic_sreach_09"), for: UIControlState.normal)
        self.view.addSubview(cancel)
        
        cancel.snp.makeConstraints({ (make) in
            make.top.equalTo(20)
            make.left.equalTo(10)
            make.width.height.equalTo(44)
        })
        cancel.addTarget(self, action: #selector(cancelAction), for: UIControlEvents.touchUpInside)

    }
    
    @objc fileprivate func cancelAction(sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
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
