//
//  GYRecommendTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/28.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

let RecommendCollectionCellId = "RecommendCollectionCellId"
class GYRecommendTableCell: UITableViewCell {
    var superController:UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib.init(nibName: "GYHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: RecommendCollectionCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        GYNetworkTool.getShoppingHotData(completionHandler: { (response) in
//            print(response)
            self.dataArray.removeAllObjects()
            let data = response["data"] as? NSDictionary
            let products = data!["products"] as? NSArray
            for (_, item) in products!.enumerated() {
                //                print(index,item)
                let model = GYSnapupModel.init(dict: item as! [String : AnyObject])
                self.dataArray.add(model)
            }
            self.collectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var leftTopName: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func buttonAction(_ sender: UIButton) {
        
    }
    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()
}


extension GYRecommendTableCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionCellId, for: indexPath) as! GYHomeCollectionCell
        
        if self.dataArray.count > 0 {
            cell.hotModel = self.dataArray[indexPath.row] as? GYSnapupModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = GYShopingDetailController()
        let hotModel = self.dataArray[indexPath.row] as? GYSnapupModel
        view.goodId = hotModel?.productId
        superController?.navigationController?.pushViewController(view, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (kWidth-40)/3, height: self.collectionView.height)
    }
}
