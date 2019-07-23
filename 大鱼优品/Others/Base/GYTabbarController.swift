//
//  GYTabbarController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SVProgressHUD

class GYTabbarController: UITabBarController {
    
    var selected_ViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tabBar = UITabBar.appearance()
        
        tabBar.backgroundColor = UIColor.white
        
        tabBar.tintColor = UIColor(red: 245 / 255, green: 90 / 255, blue: 93 / 255, alpha: 1/0)
        self.tabBar.frame = CGRect.init(x: 0, y: kHeight-kTabBarHeight, width: kWidth, height: kTabBarHeight)
        let bar = GYTabbar.init(frame: self.tabBar.bounds)
        
        self.setValue(bar, forKey: "tabBar")
        
        addChildViewControllers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addChildViewControllers() {
        addChildViewControllers(childController: GYHomeController(), title: "全网", imageNamed: "tabbar_home_icon", selectImageNamed: "tabbar_home_click_icon")
        addChildViewControllers(childController: GYShoppingController(), title: "商城", imageNamed: "tabbar_autotrophy_icon", selectImageNamed: "tabbar_autotrophy_ click_icon")
        addChildViewControllers(childController: GYCommunityController(), title: "社区", imageNamed: "tabbar_community_icon", selectImageNamed: "tabbar_community_icon_click")
        addChildViewControllers(childController: GYMineController(), title: "我", imageNamed: "tabbar_mine_icon", selectImageNamed: "tabbar_mine_icon_click")
    }
    
    private func addChildViewControllers(childController:UIViewController,title:String,imageNamed:String,selectImageNamed:String) {
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named:imageNamed)
        childController.tabBarItem.selectedImage = UIImage(named:selectImageNamed)
        let nav = GYNavigationController.init(rootViewController: childController)
        addChild(nav)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        SVProgressHUD.dismiss()
    }
    
}
