//
//  GYShopingDetailController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SnapKit

class GYShopingDetailController: GYBaseViewController,ShopDetailHeaderUpdateHeightDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "商品详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "au_bigshare"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(shareAction))
        setupSubviews()
    }
    @objc fileprivate func shareAction() {
        print("分享")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupSubviews() {
        view.addSubview(tableView)
        self.setupHeaderView()
        headerView.backgroundColor = UIColor.white
        headerView.delegate = self
        tableView.tableHeaderView = headerView
        headerView.dataArray = []
    }
    func updateShopDetailHeaderHeight(height: CGFloat) {
        headerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: height)
    }
    
    fileprivate lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: kNavBarHeight, width: kWidth, height: kHeight - kNavBarHeight), style: UITableViewStyle.grouped)
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none; /// 去掉cell下划线
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 0)) /// 去掉cell多余的下划线
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 0)) /// 去掉cell多余的下划线
//        tableView.register(UINib(nibName: String(describing: GYHomeShopRecommendCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYHomeShopRecommendCell.self))
        
        return tableView
    }()

    fileprivate lazy var headerView: GYShopDetailHeaderView = {
        var headerView = GYShopDetailHeaderView()
        return headerView
    }()
}

extension GYShopingDetailController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "测试"
        
        return cell!
    }
    
}

extension GYShopingDetailController {
    
    fileprivate func setupHeaderView() {
        headerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight - 150)
    }
    
}
















