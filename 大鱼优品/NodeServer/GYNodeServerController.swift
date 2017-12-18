//
//  GYNodeServerController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/23.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYNodeServerController: GYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        requestNodeServerData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestNodeServerData() {
        
        GYNetworkTool.getRequest(urlString: "http:192.168.1.17:8080/home", params: [:], success: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
        
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
