//
//  GYMineController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

class GYMineController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.globalBackgroundColor()

        judgmentIslogin()
    }
    
    private func judgmentIslogin() {
        let model:GYUserModel = GYUserModel.account()
        if model.autoToken == nil {
            let nav = GYNavigationController.init(rootViewController: GYLoginController())
            UIApplication.shared.keyWindow?.rootViewController = nav;
        }else{
            setupSubviews()
        }
    }
    private func setupSubviews() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "set"), style: UIBarButtonItem.Style.done, target: self, action: #selector(ItemAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "message"), style: UIBarButtonItem.Style.done, target: self, action: #selector(ItemAction))
        self.navigationItem.leftBarButtonItem?.tag = 100;
        self.navigationItem.rightBarButtonItem?.tag = 101;
        view.addSubview(tableView)
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestData()
        })
        self.tableView.mj_header.beginRefreshing()
    }
    @objc private func ItemAction(sender:UIBarButtonItem) {
        switch sender.tag {
        case 100:
            print("left")
            break
        case 101:
            print("right")
            self.navigationController?.pushViewController(GYSettingController(), animated: true)
            break
        default:
            break
        }
    }
    
    fileprivate func requestData() {
        GYNetworkTool.getMyselfData(completionHandler: { (response) in
            self.tableView.mj_header.endRefreshing()
            print(response)
            let data = response["data"] as? NSDictionary
            let follows = (data!["follows"])! as! NSNumber
            let keeps = (data!["keeps"])! as! NSNumber
            let fans = (data!["fans"])! as! NSNumber

            self.headerView.headerImage.sd_setImage(with: URL.init(string: (data!["icon"] as? String)!))
            self.headerView.nameL.text = data!["nickname"] as? String
            self.headerView.tieziBtn.setTitle(keeps.stringValue, for: UIControl.State.normal)
            self.headerView.followBtn.setTitle(follows.stringValue, for: UIControl.State.normal)
            self.headerView.fansBtn.setTitle(fans.stringValue, for: UIControl.State.normal)
            if let profile = data!["profile"] {
                self.headerView.profileL.text = profile as? String
            }else{
                self.headerView.profileL.text = "无简介"
            }
            
        }) { (error) in
            self.tableView.mj_header.endRefreshing()
            SVProgressHUD.showError(withStatus: error["stateMsg"] as? String)
            if error["state"] as? NSInteger  == 10 {
                GYUserModel.resetAccount()
                GYNetworkTool.longDistancelogin()
            }
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYMineCell.self), for: indexPath) as! GYMineCell
        let index = dataSources[indexPath.row] as! NSArray
        cell.iconNameL.text = index[0] as? String
        cell.iconContentL.text = index[1] as? String
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    fileprivate lazy var headerView: GYMineHeaderView = {
        var headerView = GYMineHeaderView.headerView()
        headerView.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: 300*scaleH)
        return headerView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.frame = CGRect.init(x: 0, y: kNavBarHeight, width: kWidth, height: kHeight-kNavBarHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = self.headerView
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: String(describing: GYMineCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYMineCell.self))
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
   fileprivate lazy var dataSources: NSMutableArray = {
        var dataSources = NSMutableArray()
        dataSources = [["我的优惠券","一张优惠券2天后失效"],["返利订单",""],["商品收藏",""],["关于我们",""],["推荐有礼","5元现金"],["我的钱包",""],["意见反馈",""],["收货地址",""]]
        return dataSources
    }()
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabbar = self.tabBarController as? GYTabbarController
        if viewController == tabbar?.selected_ViewController {
            print("我")
        }
        tabbar?.selected_ViewController = viewController
    }
    
}
