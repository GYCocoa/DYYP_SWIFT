//
//  GYShopingDetailController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

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
        self.setupFooterView()
        tableView.tableFooterView = footerView
        footerView.backgroundColor = UIColor.orange
        self.view.addSubview(bottomView)
        
        let fresh = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headerAction))
        self.tableView.mj_header = fresh
    }
    @objc fileprivate func headerAction() {
        
        self.tableView.mj_header.endRefreshing()
    }
    func updateShopDetailHeaderHeight(height: CGFloat) {
        headerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: height)
    }
    
    fileprivate lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame: CGRect.init(x: 0, y: kNavBarHeight, width: kWidth, height: kHeight - kNavBarHeight - kShopBottomHeight), style: UITableViewStyle.grouped)
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
        tableView.register(UINib(nibName: String(describing: GYShopDetailTableCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GYShopDetailTableCell.self))
        
        return tableView
    }()
    fileprivate lazy var headerView: GYShopDetailHeaderView = {
        var headerView = GYShopDetailHeaderView()
        return headerView
    }()
    fileprivate lazy var footerView: GYShopDetailFooterView = {
        var footerView = GYShopDetailFooterView()
        return footerView
    }()
    fileprivate lazy var bottomView: GYShopDetailBottomView = {
        var bottomView = GYShopDetailBottomView.bottomView()
        bottomView.frame = CGRect.init(x: 0, y: kHeight - kShopBottomHeight, width: kWidth, height: 50)
        return bottomView
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GYShopDetailTableCell.self), for: indexPath) as! GYShopDetailTableCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.indexPathRow = indexPath.row
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            /// 原内容固定高度 + 自适应
            return  65 + 10
        }
        /// 原内容固定高度 + 自适应 + 追评固定高度 + 自适应
        return 65 + 10 + 45 + 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 40))
        view.backgroundColor = UIColor.white
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("评价晒单(20)", for: UIControlState.normal)
        button.setTitleColor(UIColor.colorConversion(Color_Value: "#444444", alpha: 1), for: UIControlState.normal)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.frame = CGRect(x: 10, y: 0, width: kWidth - 20, height: 40)
        view .addSubview(button)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 40))
        view.backgroundColor = UIColor.white
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("全部评论", for: UIControlState.normal)
        button.setTitleColor(UIColor.colorConversion(Color_Value: "#444444", alpha: 1), for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.frame = CGRect(x: 10, y: 0, width: kWidth - 20, height: 40)
        button.setImage(UIImage.init(named: "au_smoregree"), for: UIControlState.normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, -45)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20)
        view .addSubview(button)
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
}

extension GYShopingDetailController {
    
    fileprivate func setupHeaderView() {
        headerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight - 150)
    }
    fileprivate func setupFooterView() {
        footerView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kHeight)
    }
    
}


