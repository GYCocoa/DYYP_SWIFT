//
//  GYShopingDetailController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYShopingDetailController: GYBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }

}
