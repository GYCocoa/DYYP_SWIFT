//
//  GYNavigationController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYNavigationController: GYBaseNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.white
        navBar.tintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7);
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        navBar.setBackgroundImage(UIImage(named: kNavBar_Bg_Image), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
         
        let navItem = UIBarButtonItem.appearance()
        let itemDict = NSMutableDictionary.init()
        itemDict[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 13)
        itemDict[NSAttributedString.Key.foregroundColor] = UIColor.black
        navItem.setTitleTextAttributes(itemDict as? [NSAttributedString.Key : Any], for: UIControl.State.normal)

        UIApplication.shared.statusBarStyle = .lightContent

        
        // 创建全局手势
//        initGlobalPan()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "au_bigback")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.done, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func navigationBack() {
        popViewController(animated: true)
    }
    
    fileprivate func initGlobalPan(){
        // 1.创建Pan手势
        let target = interactivePopGestureRecognizer?.delegate
        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        globalPan.delegate = self
        self.view.addGestureRecognizer(globalPan)
        // 2.禁止系统的手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    /// 什么时候支持全屏手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //        return false
        return self.children.count != 1
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
}

//// 全局手势返回
//extension GYNavigationController:UIGestureRecognizerDelegate {
//    /// 全局拖拽手势
//    fileprivate func initGlobalPan(){
//        // 1.创建Pan手势
//        let target = interactivePopGestureRecognizer?.delegate
//        let globalPan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
//        globalPan.delegate = self
//        self.view.addGestureRecognizer(globalPan)
//        // 2.禁止系统的手势
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//
//    }
//    /// 什么时候支持全屏手势
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
////        return false
//        return self.childViewControllers.count != 1
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return UIStatusBarStyle.lightContent
//    }
//
//}

