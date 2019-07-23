//
//  GYAnimationContoller.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/9.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit

class GYAnimationContoller: NSObject,UIViewControllerAnimatedTransitioning {
    
    var isTabbarExist:Bool?
//    var navigationController:UINavigationController?
    var navigationOperation:UINavigationController.Operation?
    /**
     导航栏Pop时删除了多少张截图（调用PopToViewController时，计算要删除的截图的数量）
     */
    var removeCount:NSInteger = 0
    
    func AnimationControllerWithOperation(operation:UINavigationController.Operation,navigationController:UINavigationController) ->Any {
        let ac = GYAnimationContoller()
        ac.navigationController = navigationController
        return ac
    }
    
    func AnimationControllerWithOperation(operation:UINavigationController.Operation) ->Any {
        let ac = GYAnimationContoller()
        ac.navigationOperation = operation
        return ac
    }
    
    var navigationController:UINavigationController? {
        didSet {
            let beyondVC = self.navigationController?.view.window?.rootViewController
            if self.navigationController?.tabBarController == beyondVC {
                isTabbarExist = true
            }else{
                isTabbarExist = false
            }
        }
    }
    
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let screentImgView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight))
        let screenImg = self.screenShot()
        screentImgView.image = screenImg
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        var fromViewEndFrame:CGRect = transitionContext.finalFrame(for: fromViewController!)
        fromViewEndFrame.origin.x = kWidth
        var fromViewStartFrame = fromViewEndFrame
        let toViewEndFrame = transitionContext.finalFrame(for: toViewController!)
        let toViewStartFrame = toViewEndFrame
        
        let containerView = transitionContext.containerView
        
        if self.navigationOperation == UINavigationController.Operation.push {
            self.screenShotArray.add(screenImg)
            //这句非常重要，没有这句，就无法正常Push和Pop出对应的界面
            containerView.addSubview(toView!)
            
            toView?.frame = toViewStartFrame
            
            let nextVC = UIView.init(frame: CGRect.init(x: kWidth, y: 0, width: kWidth, height: kHeight))
            
            //将截图添加到导航栏的View所属的window上
            self.navigationController?.view.window?.insertSubview(screentImgView, at: 0)
            
            nextVC.layer.shadowColor = UIColor.black.cgColor
            nextVC.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
            nextVC.layer.shadowOpacity = 0.6
            self.navigationController?.view.transform = CGAffineTransform.init(translationX: kWidth, y: 0)
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                self.navigationController?.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
                screentImgView.center = CGPoint.init(x: -kWidth/2, y: kHeight/2)
            }, completion: { (finished) in
                nextVC.removeFromSuperview()
                screentImgView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }
        
        if self.navigationOperation == UINavigationController.Operation.pop {
            fromViewStartFrame.origin.x = 0
            containerView.addSubview(toView!)
            
            let lastVcImgView = UIImageView.init(frame: CGRect.init(x: -kWidth, y: 0, width: kWidth, height: kHeight))
            //若removeCount大于0  则说明Pop了不止一个控制器
            if removeCount > 0 {
                for i in 0..<removeCount {
                    if i == removeCount - 1 {
                        //当删除到要跳转页面的截图时，不再删除，并将该截图作为ToVC的截图展示
                        lastVcImgView.image = self.screenShotArray.lastObject as? UIImage
                        removeCount = 0
                        break
                    }else{
                        self.screenShotArray.removeLastObject()
                    }
                }
            }else{
                lastVcImgView.image = self.screenShotArray.lastObject as? UIImage
                screentImgView.layer.shadowColor = UIColor.black.cgColor
                screentImgView.layer.shadowOffset = CGSize.init(width: -0.8, height: 0)
                screentImgView.layer.shadowOpacity = 0.6
                self.navigationController?.view.window?.addSubview(lastVcImgView)
                self.navigationController?.view.addSubview(screentImgView)
                
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                    screentImgView.center = CGPoint.init(x: kWidth*3/2, y: kHeight/2)
                    lastVcImgView.center = CGPoint.init(x: kWidth/2, y: kHeight/2)
                }, completion: { (finished) in
                    lastVcImgView.removeFromSuperview()
                    screentImgView.removeFromSuperview()
                    self.screenShotArray.removeLastObject()
                    transitionContext.completeTransition(true)
                })
            }
        }
    }
    
    func removeLastScreenShot() {
        self.screenShotArray.removeLastObject()
    }
    func removeAllScreenShot() {
        self.screenShotArray.removeAllObjects()
    }
    func removeLastScreenShotWithNumber(number:NSInteger) {
        for _ in 0..<number {
            self.screenShotArray.removeLastObject()
        }
    }
    
    func screenShot() -> UIImage {
        // 将要被截图的view,即窗口的根控制器的view(必须不含状态栏,默认ios7中控制器是包含了状态栏的)
        let beyondVC = self.navigationController?.view.window?.rootViewController
        let size = beyondVC?.view.frame.size
        // 开启上下文,使用参数之后,截出来的是原图（YES  0.0 质量高）
        UIGraphicsBeginImageContextWithOptions(size!, true, 0)
        // 要裁剪的矩形范围
        let rect = CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight)
        //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
        
        //判读是导航栏是否有上层的Tabbar  决定截图的对象
        if isTabbarExist! {
            beyondVC?.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }else{
            self.navigationController?.view.drawHierarchy(in: rect, afterScreenUpdates: false)
        }
        // 从上下文中,取出UIImage
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        // 千万记得,结束上下文(移除栈顶的基于当前位图的图形上下文)
        UIGraphicsEndImageContext()
        // 返回截取好的图片
        return snapshot!
    }

    lazy var screenShotArray: NSMutableArray = {
        var screenShotArray = NSMutableArray()
        return screenShotArray
    }()
}
