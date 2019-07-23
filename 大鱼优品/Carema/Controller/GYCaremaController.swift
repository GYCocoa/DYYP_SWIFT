//
//  GYCaremaController.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/9/18.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

let caremaCollectionCellId = "caremaCollectionCellId"
let headerIdentifier = "headerIdentifier"

let WIDTH = UIScreen.main.bounds.width
let HEIGHT = UIScreen.main.bounds.height

class GYCaremaController: UIViewController {
    var caremaTop:GYCaremaTopView?
    // 音视频采集会话
    let captureSession = AVCaptureSession()
    // 后置摄像头
    var backFacingCamera: AVCaptureDevice?
    // 前置摄像头
    var frontFacingCamera: AVCaptureDevice?
    // 当前正在使用的设备
    var currentDevice: AVCaptureDevice?
    // 静止图像输出端
    var stillImageOutput: AVCaptureStillImageOutput?
    // 相机预览图层
    var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
    //切换手势
    var toggleCameraGestureRecognizer = UISwipeGestureRecognizer()
    //放大手势
    var zoomInGestureRecognizer = UISwipeGestureRecognizer()
    //缩小手势
    var zoomOutGestureRecognizer = UISwipeGestureRecognizer()
    //照片拍摄后预览视图
    var photoImageview:UIImageView!
    //照相按钮
    var photoBtn:UIButton!
    //取消按钮/重拍
    var cancel:UIButton!
    //保存按钮
    var save:UIButton!
    /// 获取闪光灯按钮
    var flashButtoon:UIButton?

    ///取得的资源结果，用了存放的PHAsset
    var assetsFetchResults:PHFetchResult<AnyObject>!
    ///缩略图大小
    var assetGridThumbnailSize:CGSize!
    /// 带缓存的图片管理对象
    var imageManager:PHCachingImageManager!
    
    var collectionViewLayout:StickyHeadersFlowLayout?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.cancelAction()
        //根据单元格的尺寸计算我们需要的缩略图大小
        let scale = UIScreen.main.scale
        let cellSize = (self.collectionViewLayout)?.itemSize
        assetGridThumbnailSize = CGSize.init(width: (cellSize?.width)!*scale, height: (cellSize?.height)!*scale)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        setupNavigationBar()
        //获取设备，创建UI
        self.CreateUI()
        //给当前view创建手势
        self.CreateGestureRecognizer()
        // 创建拍照按钮
        self.createPhotoBtn()
        /// 添加collectionView
        view.addSubview(collectionView)
        /// 获取所有图片
        self.getAllPhotos()
    }
    
    fileprivate func setupNavigationBar() {
        caremaTop = GYCaremaTopView(frame: CGRect(x: 0, y: 0, width: kWidth, height: 64))
        view.addSubview(caremaTop!)
        for (index,button) in (caremaTop?.buttonArray.enumerated())! {
            if index == 1 { /// 获取到闪光灯按钮
                self.flashButtoon = button as? UIButton
            }
            (button as AnyObject).addTarget(self, action: #selector(caremaButtonAction), for: UIControl.Event.touchUpInside)
        }
    }
    @objc fileprivate func caremaButtonAction(sender:UIButton) {
        switch sender.tag {
        case 100:
            print("关掉相机")
            self.dismiss(animated: true, completion: {
                self.turnOffFlash()
            })
            break
        case 101:
            print("开启闪光灯")
            self.turnOnFlash(sender: sender)
            break
        case 102:
            print("切换摄像头")
            self.toggleCamera()
            break
        default:
            break
        }
    }
    //MARK: -------------------------- 打开闪光灯 -------------------------
    fileprivate func turnOnFlash(sender:UIButton) {
        if currentDevice == nil {
            sender.isEnabled = false
            return
        }
        if currentDevice?.torchMode == AVCaptureDevice.TorchMode.off{
            do {
                try currentDevice?.lockForConfiguration()
            } catch {
                return
            }
            currentDevice?.torchMode = .on
            currentDevice?.unlockForConfiguration()
            sender.isSelected = true
            sender.setImage(UIImage(named: "ic_sreach_on_03"), for: UIControl.State.normal)
        }else {
            do {
                try currentDevice?.lockForConfiguration()
            } catch {
                return
            }
            currentDevice?.torchMode = .off
            currentDevice?.unlockForConfiguration()
            sender.isSelected = false
            sender.setImage(UIImage(named: "ic_sreach_03"), for: UIControl.State.normal)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - 获取设备,创建自定义视图
    func CreateUI(){
        // 将音视频采集会话的预设设置为高分辨率照片--选择照片分辨率
        self.captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
        // 获取设备
        let devices = AVCaptureDevice.devices(for: AVMediaType.video) 
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                self.backFacingCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                self.frontFacingCamera = device
            }
        }
        //设置当前设备为前置摄像头
        self.currentDevice = self.backFacingCamera
        do {
            // 当前设备输入端
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            self.stillImageOutput = AVCaptureStillImageOutput()
            // 输出图像格式设置
            self.stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            self.captureSession.addInput(captureDeviceInput)
            self.captureSession.addOutput(self.stillImageOutput!)
        }
        catch {
            print(error)
            return
        }
        // 创建预览图层
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(cameraPreviewLayer!)
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        self.cameraPreviewLayer?.frame = view.layer.frame
        self.cameraPreviewLayer?.frame = CGRect.init(x: 0, y: 64, width: kWidth, height: kHeight-200*scaleH)
        // 启动音视频采集的会话
        self.captureSession.startRunning()
    }
    //MARK: - 创建手势
    func CreateGestureRecognizer(){
        // 上滑手势控制前置和后置摄像头的转换
//        self.toggleCameraGestureRecognizer.direction = .up
//        self.toggleCameraGestureRecognizer.addTarget(self, action: #selector(self.toggleCamera))
//        self.view.addGestureRecognizer(toggleCameraGestureRecognizer)
        // 右滑放大
        self.zoomInGestureRecognizer.direction = .right
        self.zoomInGestureRecognizer.addTarget(self, action: #selector(self.zoomIn))
        self.view.addGestureRecognizer(zoomInGestureRecognizer)
        // 左滑缩小
        self.zoomOutGestureRecognizer.direction = .left
        self.zoomOutGestureRecognizer.addTarget(self, action: #selector(self.zoomOut))
        self.view.addGestureRecognizer(zoomOutGestureRecognizer)
    }
    func createPhotoBtn(){
        //创建照相按钮
        self.photoBtn = UIButton.init(frame: CGRect.init(x: WIDTH/2 - 30, y: HEIGHT - 250*scaleH, width: 60, height: 60))
        self.photoBtn.setImage(UIImage(named: "ic_sreach_15"), for: UIControl.State.normal)
        self.view.addSubview(self.photoBtn)
        self.view.bringSubviewToFront(self.photoBtn)
        // 创建预览照片视图
        self.photoImageview = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: kWidth, height: kHeight-200*scaleH))
        self.photoImageview.contentMode = UIView.ContentMode.scaleAspectFill
        self.photoImageview.clipsToBounds = true
        self.view.addSubview(self.photoImageview)
        self.photoImageview.isHidden = true
        self.cancel = UIButton.init(frame: CGRect.init(x: 50, y: HEIGHT - 280*scaleH, width: 100, height: 60))
        self.cancel.setTitle("重拍", for: .normal)
        self.cancel.isHidden = true
        self.cancel.setTitleColor(UIColor.globalMainColor(), for: .normal)
        self.photoImageview.addSubview(self.cancel)
        self.cancel.addTarget(self, action: #selector(self.cancelAction), for: .touchUpInside)
        self.save = UIButton.init(frame: CGRect.init(x:WIDTH - 150, y: HEIGHT - 280*scaleH, width: 100, height: 60))
        self.save.setTitle("搜索", for: .normal)
        self.save.isHidden = true
        self.save.setTitleColor(UIColor.globalMainColor(), for: .normal)
        self.photoImageview.addSubview(self.save)
        self.photoImageview.isUserInteractionEnabled = true
        self.save.addTarget(self, action: #selector(self.searchAction), for: .touchUpInside)
        self.photoBtn.addTarget(self, action: #selector(self.photoAction), for: .touchUpInside)
    }
    @objc fileprivate func searchAction() {
        print("图片搜索")
        let result = GYCaremaResultController()
        result.clickImage = self.photoImageview.image
        let nav = GYNavigationController.init(rootViewController: result)
        self.present(nav, animated: true) {
            self.turnOffFlash()
        }
    }
    fileprivate func turnOffFlash() {
        do {
            try self.currentDevice?.lockForConfiguration()
        } catch {
            return
        }
        self.currentDevice?.torchMode = .off
        self.currentDevice?.unlockForConfiguration()
        self.flashButtoon?.isSelected = false
        self.flashButtoon?.setImage(UIImage(named: "ic_sreach_03"), for: UIControl.State.normal)
    }
    //照相按钮
    @objc fileprivate func photoAction(){
        // 获得音视频采集设备的连接
        let videoConnection = stillImageOutput?.connection(with: AVMediaType.video)
        // 输出端以异步方式采集静态图像
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection!, completionHandler: { (imageDataSampleBuffer, error) -> Void in
            // 获得采样缓冲区中的数据
            let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!)
            // 将数据转换成UIImage
            if let stillImage = UIImage(data: imageData!) {
                //显示当前拍摄照片
                self.photoImageview.isHidden = false
                self.photoImageview.image = stillImage
                self.saveAction()
                self.searchAction()
            }
        })
    }
    //1. 先实现这个方法后得到返回的照片
    func scaleToSize(image:UIImage!,size:CGSize) -> UIImage{
        // 得到图片上下文，指定绘制范围
        UIGraphicsBeginImageContext(size);
        // 将图片按照指定大小绘制
        image.draw(in: CGRect(x:0,y:0,width:size.width,height:size.height))
        // 从当前图片上下文中导出图片
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // 当前图片上下文出栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return img
    }
    //2. 实现这个方法,,就拿到了截取后的照片.
    func imageFromImage(imageFromImage:UIImage!,inRext:CGRect) ->UIImage{
        //将UIImage转换成CGImageRef
        let sourceImageRef:CGImage = imageFromImage.cgImage!
        //按照给定的矩形区域进行剪裁
        let newImageRef:CGImage = sourceImageRef.cropping(to: inRext)!
        //将CGImageRef转换成UIImage
        let img:UIImage = UIImage.init(cgImage: newImageRef)
        //返回剪裁后的图片
        return img
    }
    //取消按钮／重拍
    @objc func cancelAction(){
        //隐藏Imageview
        self.photoImageview.isHidden = true
    }
    //保存按钮-保存到相册
    func saveAction(){
        //保存照片到相册
//        UIImageWriteToSavedPhotosAlbum(self.photoImageview.image!, nil, nil, nil)
        UIImageWriteToSavedPhotosAlbum(self.photoImageview.image!, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
          self.getAllPhotos()
        self.collectionView.reloadData()
    }
    //保存图片
    @objc func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject)
    {
        if didFinishSavingWithError != nil {
            print("保存失败")
            return
        }
        self.collectionView.reloadData()
    }
    
    //  MARK:- 获取全部图片
    private func getAllPhotos() {
        //则获取所有资源
        let allPhotosOptions = PHFetchOptions()
        //按照创建时间倒序排列
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                             ascending: false)]
        //只获取图片
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                 PHAssetMediaType.image.rawValue)
        assetsFetchResults = (PHAsset.fetchAssets(with: PHAssetMediaType.image,options: allPhotosOptions) as! PHFetchResult<AnyObject>)
        
        // 初始化和重置缓存
        self.imageManager = PHCachingImageManager()
        self.resetCachedAssets()
        let asset = self.assetsFetchResults[0] as! PHAsset
        assetGridThumbnailSize = CGSize.init(width: 100, height: 100)
        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: PHImageContentMode.aspectFill,options: nil) { (image, nfo) in
            print(image!)
        }
    }
    //重置缓存
    func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    //MARK: -------------------------- 懒加载集合视图 -------------------------
    fileprivate lazy var collectionView: UICollectionView = {
        self.collectionViewLayout = StickyHeadersFlowLayout()
        //初始化自定义的flow布局
//        let layout = StickyHeadersFlowLayout()
        //Collection View的位置尺寸
        let frame = CGRect(x: 0, y: 64, width: kWidth,height: 30)
        var collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: kHeight-175*scaleH, width: kWidth, height: 250*scaleH), collectionViewLayout: self.collectionViewLayout!)
        self.collectionViewLayout?.itemSize = CGSize.init(width: (kWidth-10)/5, height: (kWidth-10)/5)
        self.collectionViewLayout?.minimumLineSpacing = 2
        self.collectionViewLayout?.minimumInteritemSpacing = 2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = UIColor.black
        collectionView.isScrollEnabled = false
        collectionView.register(UINib.init(nibName: "GYCaremaCollectionCell", bundle: nil), forCellWithReuseIdentifier: caremaCollectionCellId)
        // 设定header的大小
        self.collectionViewLayout?.headerReferenceSize = CGSize(width: kWidth, height: 30)
        collectionView.register(GYCaremaCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        return collectionView
    }()
}

extension GYCaremaController{
    //MARK: - 放大方法
    @objc func zoomIn() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor < 5.0 {
                let newZoomFactor = min(zoomFactor + 1.0, 5.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                    currentDevice?.unlockForConfiguration()
                }
                catch {
                    print(error)
                }
            }
        }
    }
    //MARK: - 缩小方法
    @objc func zoomOut() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor > 1.0 {
                let newZoomFactor = max(zoomFactor - 1.0, 1.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                    currentDevice?.unlockForConfiguration()
                }
                catch {
                    print(error)
                }
            }
        }
    }
    //MARK: - 切换摄像头
    func toggleCamera() {
        captureSession.beginConfiguration()
        // 在前置和后置之间切换摄像头
        let newDevice = (currentDevice?.position == AVCaptureDevice.Position.back) ? frontFacingCamera : backFacingCamera
        // 移除之前所有的输入会话
        for input in captureSession.inputs {
            captureSession.removeInput(input as! AVCaptureDeviceInput)
        }
        // 将输入端切换到新的采集设备
        let cameraInput: AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: newDevice!)
        }
        catch {
            print(error)
            return
        }
        // 添加输入端
        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }
        currentDevice = newDevice
        // 提交配置
        captureSession.commitConfiguration()
    }
}

extension GYCaremaController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsFetchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: caremaCollectionCellId, for: indexPath) as! GYCaremaCollectionCell
        if self.assetsFetchResults.count > 0 {
            let asset = self.assetsFetchResults[indexPath.row] as! PHAsset
            //获取缩略图
            self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { (image, nfo) in
                cell.caremaImage.image = image
            })
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myAsset = self.assetsFetchResults[indexPath.row] as! PHAsset
        let result = GYCaremaResultController()
        //获取原图
        PHImageManager.default().requestImage(for: myAsset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) { (image, obj) in
            result.clickImage = image
            let nav = GYNavigationController.init(rootViewController: result)
            self.present(nav, animated: true) {
                self.turnOffFlash()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        var reusableview:GYCaremaCollectionHeader!
        if kind == UICollectionView.elementKindSectionHeader{
            reusableview = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! GYCaremaCollectionHeader)
            reusableview.backgroundColor = UIColor.black
            reusableview.button.addTarget(self, action: #selector(headerButtonAction), for: UIControl.Event.touchUpInside)
            
        }else if kind == UICollectionView.elementKindSectionFooter {

        }
        
        return reusableview
    }
    
    @objc fileprivate func headerButtonAction(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if !sender.isSelected {
            sender.setImage(UIImage.init(named: "ic_sreach_up"), for: UIControl.State.normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.frame = CGRect.init(x: 0, y: kHeight-175*scaleH, width: kWidth, height: 250*scaleH)
                self.collectionView.isScrollEnabled = false
            })
        }else{
            sender.setImage(UIImage.init(named: "ic_sreach_down"), for: UIControl.State.normal)
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.frame = CGRect.init(x: 0, y: kHeight-250*scaleH, width: kWidth, height: 250*scaleH)
                self.collectionView.isScrollEnabled = true
            })
        }
    }
    
}

