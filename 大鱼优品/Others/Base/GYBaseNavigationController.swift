//
//  GYBaseNavigationController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYBaseNavigationController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    var panGestureRec:UIScreenEdgePanGestureRecognizer? = nil
    var screenshotImgView:UIImageView?
    var coverView:UIView?
    var screenshotImgs:NSMutableArray?
    var nextVCScreenShotImg:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.delegate = self
        
        self.navigationBar.tintColor = UIColor.init(hexString: "0x6F7179")
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
        self.view.layer.shadowOpacity = 0.6
        
        // 1,创建Pan手势识别器,并绑定监听方法
        panGestureRec = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(panGestureRecAction))
        panGestureRec?.edges = UIRectEdge.left
        // 为导航控制器的view添加Pan手势识别器
        self.view.addGestureRecognizer(panGestureRec!)
        // 2.创建截图的ImageView
        screenshotImgView = UIImageView()
        // app的frame是包括了状态栏高度的frame
        screenshotImgView?.frame = CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight)
        // 3.创建截图上面的黑色半透明遮罩
        coverView = UIView()
        // 遮罩的frame就是截图的frame
        coverView?.frame = (screenshotImgView?.frame)!
        // 遮罩为黑色
        coverView?.backgroundColor = UIColor.black
        // 4.存放所有的截图数组初始化
        screenshotImgs = NSMutableArray()
        
        
    }
    
    // 监听手势的方法,只要是有手势就会执行
    @objc func panGestureRecAction(panGestureRec:UIScreenEdgePanGestureRecognizer){
        // 如果当前显示的控制器已经是根控制器了，不需要做任何切换动画,直接返回
        if self.visibleViewController == self.viewControllers[0] {
            return
        }
        // 判断pan手势的各个阶段
        switch panGestureRec.state {
        case UIGestureRecognizerState.began:
            // 开始拖拽阶段
            self.dragBegin()
            break
        case UIGestureRecognizerState.cancelled:
            self.dragEnd()
            break
        case UIGestureRecognizerState.failed:
            self.dragEnd()
            break
        case UIGestureRecognizerState.ended:
            // 结束拖拽阶段
            self.dragEnd()
            break
        default:
            // 正在拖拽阶段
            self.dragging(pan: panGestureRec)
            break
        }
        
    }
    
    //MARK: -------------------------- 开始拖动,添加图片和遮罩 -------------------------
    // TODO: 333
    func dragBegin() {
        // 重点,每次开始Pan手势时,都要添加截图imageview 和 遮盖cover到window中
        self.view.window?.insertSubview(screenshotImgView!, at: 0)
        self.view.window?.insertSubview(coverView!, aboveSubview: screenshotImgView!)
        // 并且,让imgView显示截图数组中的最后(最新)一张截图
        screenshotImgView?.image = screenshotImgs?.lastObject as? UIImage
    }
    // 默认的将要变透明的遮罩的初始透明度(全黑)
    let kDefaultAlpha = 0.6
    // 当拖动的距离,占了屏幕的总宽高的3/4时, 就让imageview完全显示，遮盖完全消失
    let kTargetTranslateScale = 0.75
    
    //pragma MARK: 正在拖动,动画效果的精髓,进行位移和透明度变化
    func dragging(pan:UIPanGestureRecognizer) {
        // 得到手指拖动的位移
        let offsetX = pan.translation(in: self.view).x
        // 让整个view都平移     // 挪动整个导航view
        if offsetX > 0 {
            self.view.transform = CGAffineTransform.init(translationX: offsetX, y: 0)
        }
        
        // 计算目前手指拖动位移占屏幕总的宽高的比例,当这个比例达到3/4时, 就让imageview完全显示，遮盖完全消失
        let currentTranslateScaleX:Double = Double(offsetX/self.view.frame.size.width)
        if offsetX < kWidth {
            screenshotImgView?.transform = CGAffineTransform.init(translationX: (offsetX - kWidth) * 0.6, y: 0)
        }
        // 让遮盖透明度改变,直到减为0,让遮罩完全透明,默认的比例-(当前平衡比例/目标平衡比例)*默认的比例
        let alpha = kDefaultAlpha - (currentTranslateScaleX / kTargetTranslateScale) * kDefaultAlpha
        coverView?.alpha = CGFloat(alpha)
    }
    
    //MARK: -------------------------- 结束拖动,判断结束时拖动的距离作相应的处理,并将图片和遮罩从父控件上移除 -------------------------
    func dragEnd() {
        // 取出挪动的距离
        let translateX:CGFloat = self.view.transform.tx
        // 取出宽度
        let width:CGFloat = self.view.frame.size.width
        
        if translateX <= 40 {
            // 如果手指移动的距离还不到屏幕的一半,往左边挪 (弹回)
            UIView.animate(withDuration: 0, animations: {
                // 重要~~让被右移的view弹回归位,只要清空transform即可办到
                self.view.transform = CGAffineTransform.identity
                // 让imageView大小恢复默认的translation
                self.screenshotImgView!.transform = CGAffineTransform.init(translationX: -kWidth, y: 0)
                // 让遮盖的透明度恢复默认的alpha 1.0
                self.coverView?.alpha = CGFloat(self.kDefaultAlpha)
            }, completion: { (finished) in
                // 重要,动画完成之后,每次都要记得 移除两个view,下次开始拖动时,再添加进来
                self.screenshotImgView?.removeFromSuperview()
                self.coverView?.removeFromSuperview()
            })
        }else{
            // 如果手指移动的距离还超过了屏幕的一半,往右边挪
            UIView.animate(withDuration: 0, animations: {
                // 让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform
                self.view.transform = CGAffineTransform.init(translationX: width, y: 0)
                // 让imageView位移还原
                self.screenshotImgView?.transform = CGAffineTransform.init(translationX: width, y: 0)
                // 让遮盖alpha变为0,变得完全透明
                self.coverView?.alpha = 0
            }, completion: { (finished) in
                // 重要~~让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform,不然下次再次开始drag时会出问题,因为view的transform没有归零
                self.view.transform = CGAffineTransform.identity
                // 移除两个view,下次开始拖动时,再加回来
                self.screenshotImgView?.removeFromSuperview()
                self.coverView?.removeFromSuperview()
                // 执行正常的Pop操作:移除栈顶控制器,让真正的前一个控制器成为导航控制器的栈顶控制器
                self.popViewController(animated: false)
                // 重要~记得这时候,可以移除截图数组里面最后一张没用的截图了
                self.animationController.removeLastScreenShot()
            })
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animationController.navigationOperation = operation
        self.animationController.navigationController = self
        return self.animationController
    }
    
    lazy var animationController: GYAnimationContoller = {
        var animationController = GYAnimationContoller()
        return animationController
    }()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 只有在导航控制器里面有子控制器的时候才需要截图
        if self.viewControllers.count >= 1 {
            // 调用自定义方法，使用上下文截图
            self.screenSHot()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let index = self.viewControllers.count
//        var className:String? = nil
//        if index >= 2 {
//            let controller = self.viewControllers[index - 2]
//            className = NSStringFromClass(controller)
//        }
        if (screenshotImgs?.count)! >= index - 1 {
            screenshotImgs?.removeLastObject()
        }
        return super.popViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        var removeCount = 0
        
        for i in stride(from: self.viewControllers.count, to: 0, by: -1) {
            if viewController == self.viewControllers[i] {
                break
            }
            screenshotImgs?.removeLastObject()
            removeCount += 1
        }
        animationController.removeCount = removeCount
        return super.popToViewController(viewController, animated: true)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        screenshotImgs?.removeAllObjects()
        animationController.removeAllScreenShot()
        return super.popToRootViewController(animated: animated)
    }
    
    func screenSHot() {
        // 将要被截图的view,即窗口的根控制器的view(必须不含状态栏,默认ios7中控制器是包含了状态栏的)
        let beyondVC = self.view.window?.rootViewController
        let size = beyondVC?.view.frame.size
        // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
        UIGraphicsBeginImageContextWithOptions(size!, true, 0)
        // 要裁剪的矩形范围
        let rect = CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight)
        //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
        
        if self.tabBarController == beyondVC {
            beyondVC?.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }else{
            self.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }
        
        // 从上下文中,取出UIImage
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        // 添加截取好的图片到图片数组
        if (snapshot != nil) {
            screenshotImgs?.add(snapshot!)
        }
        // 千万记得,结束上下文(移除栈顶的基于当前位图的图形上下文)
        UIGraphicsEndImageContext()
    }
    
    
    
    

}
