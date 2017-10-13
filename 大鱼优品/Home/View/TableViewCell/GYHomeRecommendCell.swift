//
//  GYHomeRecommendCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/26.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

let HomeCollectionCellId = "HomeCollectionCellId"
class GYHomeRecommendCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    fileprivate var homeLayout :UICollectionViewFlowLayout?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.homeCollectionView.backgroundColor = UIColor.white
        
        //MARK: -------------------------- 获取推荐数据 -------------------------
        GYNetworkTool.getHomeRecommendData(completionHandler: { (response) in
//            print(response)
            self.dataArray.removeAllObjects()
            if response["items"] != nil {
                let data:NSArray = response["items"] as! NSArray
                for index in 0..<data.count{
                    let model = GYHomeModel.init(dict: data[index] as! [String : AnyObject])
                    self.dataArray.add(model)
                }
            }
            self.homeCollectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCellId, for: indexPath) as! GYHomeCollectionCell
        if self.dataArray.count > 0 {
            let homeModel = self.dataArray[indexPath.row] as? GYHomeModel
            cell.model = homeModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    lazy var homeCollectionView:UICollectionView = {
        self.homeLayout = UICollectionViewFlowLayout()
        var homeCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: (kWidth-40) / 3 + 50), collectionViewLayout: self.homeLayout!)
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.showsHorizontalScrollIndicator = false
        self.homeLayout?.itemSize = CGSize.init(width: (kWidth-40)/3, height: (kWidth-40) / 3 + 50)
        self.homeLayout?.scrollDirection = .horizontal
        homeCollectionView.isScrollEnabled = true
        self.homeLayout?.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        homeCollectionView.register(UINib.init(nibName: "GYHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: HomeCollectionCellId)
        self.contentView.addSubview(homeCollectionView)
        
        return homeCollectionView
    }()

    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()
    
}
