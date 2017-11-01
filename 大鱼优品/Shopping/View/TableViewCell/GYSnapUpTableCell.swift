//
//  GYSnapUpTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/28.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

let SnapCollectionCellId = "SnapCollectionCellId"
class GYSnapUpTableCell: UITableViewCell {

    var superController:UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib.init(nibName: "GYHomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: SnapCollectionCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        GYNetworkTool.getShoppingSnapupData(completionHandler: { (response) in
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
    
    @IBOutlet weak var leftTopTitle: UIButton!
    @IBOutlet weak var endL: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var hourL: UILabel!
    @IBOutlet weak var minuteL: UILabel!
    @IBOutlet weak var secondL: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rightBaseL: UILabel!
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
    }
    fileprivate lazy var dataArray: NSMutableArray = {
        var dataArray = NSMutableArray()
        return dataArray
    }()

}

extension GYSnapUpTableCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SnapCollectionCellId, for: indexPath) as! GYHomeCollectionCell
        if self.dataArray.count > 0 {
            let model = self.dataArray[indexPath.row] as? GYSnapupModel
            cell.snapup = model
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = GYShopingDetailController()
        let model = self.dataArray[indexPath.row] as? GYSnapupModel
        view.goodId = model?.productId
        superController?.navigationController?.pushViewController(view, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (kWidth-40)/3, height: self.collectionView.height)
    }
}
