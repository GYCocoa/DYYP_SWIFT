//
//  GYCommunityTopicTableCell.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/24.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

fileprivate let GYCommunityTopicCollectionCellId = "GYCommunityTopicCollectionCellId"
class GYCommunityTopicTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        self.collectionView.reloadData()
    }
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 95), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize.init(width: 99, height: 62)
        layout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.white
        layout.sectionInset = UIEdgeInsets.init(top: 16, left: 12, bottom: 16, right: 12)
        collectionView.register(UINib.init(nibName: "GYCommunityTopicCollectionCell", bundle: nil), forCellWithReuseIdentifier: GYCommunityTopicCollectionCellId)
        self.contentView.addSubview(collectionView)
        
        return collectionView
    }()

//    lazy var dataArray: NSMutableArray = {
//        var dataArray = NSMutableArray()
//        return dataArray
//    }()
    
    var dataArray:NSMutableArray? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GYCommunityTopicTableCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GYCommunityTopicCollectionCellId, for: indexPath) as! GYCommunityTopicCollectionCell
        if ((self.dataArray?.count) != nil) {
            let model = self.dataArray![indexPath.row] as? GYCommunityModel
            cell.model = model
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
