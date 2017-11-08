//
//  CommunityTitleView.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/29.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

protocol CommunityTitleViewDelegate: class {
    func communityTitleView(_ titleView: CommunityTitleView, targetIndex : Int)
}

class CommunityTitleView: UIView {
    
    weak var delegate: CommunityTitleViewDelegate?
    
    var titles: [TopicTitle]? {
        didSet {
            // 将titleLabel添加到UIScrollView中
            setupTitleLabels()
            // 设置titleLabel的frame
            setupTitleLabelsFrame()
        }
    }
    
    fileprivate lazy var currentIndex : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        theme_backgroundColor = "colors.cellBackgroundColor"
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 标题数组
    fileprivate lazy var titleLabels = [HomeTitleLabel]()
    /// 滚动视图
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 40))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    /// 底部滚动指示器
    fileprivate lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.colorConversion(Color_Value: "fd6363", alpha: 1.0)
        bottomLine.height = 2
        bottomLine.y = 37
        return bottomLine
    }()
    
    /// 底部分割线
    fileprivate lazy var bottomLineView: UIView = {
        let bottomLineView = UIView(frame: CGRect(x: 0, y: 39, width: kWidth, height: 1))
        bottomLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return bottomLineView
    }()
    
}

extension CommunityTitleView {
    func setupUI() {
        // 将UIScrollVIew添加到view中
        addSubview(scrollView)
        addSubview(bottomLineView)
        // 添加滚动条
        scrollView.addSubview(bottomLine)
    }
    
    /// 将titleLabel添加到UIScrollView中
    fileprivate func setupTitleLabels() {
        titleLabels.removeAll()
        for (index, topTitle) in titles!.enumerated() {
            let titleLabel = HomeTitleLabel()
            titleLabel.text = topTitle.cname
            titleLabel.font = UIFont.systemFont(ofSize: 13)
            titleLabel.tag = index
            titleLabel.textAlignment = .center
            titleLabel.textColor = index == 0 ? UIColor.colorConversion(Color_Value: "fd6363", alpha: 1) : UIColor.black
            titleLabel.currentScale = index == 0 ? 1.0 : 1.0
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    fileprivate func setupTitleLabelsFrame() {
        
        for (i, label) in titleLabels.enumerated() {
            var w : CGFloat = 0
            let h : CGFloat = 40
            var x : CGFloat = 0
            let y : CGFloat = 0
            
            let topTitle = titles![i]
            
            w = (topTitle.cname! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height:0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil).width
            if i == 0 {
                x = kMargin * 0.5
                bottomLine.x = x
                bottomLine.width = w
            } else {
                let preLabel = titleLabels[i - 1]
                x = preLabel.frame.maxX + kMargin
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + kMargin * 0.5, height: 0)
    }
    
}

// MARK:- 监听事件
extension CommunityTitleView {
    
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        // 取出用户点击的View
        let targetLabel = tapGes.view as! HomeTitleLabel
        
        // 调整title
        adjustTitleLabel(targetIndex: targetLabel.tag)
        
        // 调整bottomLine
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomLine.width = targetLabel.width
            self.bottomLine.centerX = targetLabel.centerX
        })
        
        // 通知代理
        delegate?.communityTitleView(self, targetIndex: currentIndex)
    }
    
    fileprivate func adjustTitleLabel(targetIndex : Int) {
        
        if targetIndex == currentIndex { return }
        
        // 1.取出Label
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        
        // 2.切换文字的颜色
        targetLabel.textColor = UIColor.colorConversion(Color_Value: "fd6363", alpha: 1)
        sourceLabel.textColor = UIColor.black
        sourceLabel.currentScale = 1.0
        targetLabel.currentScale = 1.1
        
        // 调整bottomLine
        UIView.animate(withDuration: 0.25, animations: {
            self.bottomLine.width = targetLabel.width
            self.bottomLine.centerX = targetLabel.centerX
        })
        
        // 3.记录下标值
        currentIndex = targetIndex
        
        // 4.调整位置
        // 当前偏移量
        var offsetX = targetLabel.centerX - scrollView.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        // 最大偏移量
        var maxOffsetX = scrollView.contentSize.width - scrollView.width
        
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

// MARK:- 遵守HYContentViewDelegate
extension CommunityTitleView : CommunityPageViewDelegate {
    
    func pageView(_ pageView: CommunityPageView, targetIndex: Int) {
        
        adjustTitleLabel(targetIndex: targetIndex)
        
    }
    
}

private class HomeTitleLabel: UILabel {
    /// 用来记录当前 label 的缩放比例
    var currentScale: CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}

