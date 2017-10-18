//
//  GYCommunityController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYCommunityController: GYBaseViewController,UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        requestTitleData()
    }
    fileprivate func setupNavigationBar() {
        self.titleView.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: 30)
        self.navigationItem.titleView = self.titleView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "white")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.done, target: self, action: #selector(categoryPostAction))
        self.titleView.addTarget(self, action: #selector(categorySearchAction), for: UIControlEvents.touchUpInside)
    }
    @objc fileprivate func categorySearchAction() {
        print("category search")
    }
    @objc fileprivate func categoryPostAction() {
        print("category post")
    }
    fileprivate func requestTitleData() {
        /// 获取标题数据
        GYCommunityView.getCommunityTitlesData(fromViewController: String(describing:GYCommunityController.self), completionHandler: { (topicTitles, topicVCs) in
            self.reloadButton.isHidden = true
            for child in self.childViewControllers {
                child.removeFromParentViewController()
            }
            // 将所有子控制器添加到父控制器中
            for childVc in topicVCs {
                self.addChildViewController(childVc)
            }
            self.setupUI()
            self.pageView.titles = topicTitles
            self.pageView.childVcs = self.childViewControllers as? [GYCommunityOtherController]
        }) { (error) in
            print("error = \(error)")
            self.reloadButton.isHidden = false
        }
    }
    fileprivate func setupUI() {
        pageView.removeFromSuperview()
        view.addSubview(pageView)
        pageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(view).offset(kNavBarHeight)
            make.bottom.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate lazy var pageView: CommunityPageView = {
        let pageView = CommunityPageView()
        return pageView
    }()

    fileprivate lazy var titleView: UIButton = {
        var titleView = UIButton()
        titleView.setBackgroundImage(UIImage.init(named: "first"), for: UIControlState.normal)
        titleView.adjustsImageWhenHighlighted = false
        return titleView
    }()
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabbar = self.tabBarController as? GYTabbarController
        if viewController == tabbar?.selected_ViewController {
            print("社区")
        }
        tabbar?.selected_ViewController = viewController
    }
    
    override func reloadButtonAction(sender: UIButton) {
        requestTitleData()
    }

}

