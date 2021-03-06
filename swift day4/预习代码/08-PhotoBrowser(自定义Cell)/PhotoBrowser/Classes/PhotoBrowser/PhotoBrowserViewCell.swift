//
//  PhotoBrowserViewCell.swift
//  PhotoBrowser
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserViewCell: UICollectionViewCell {
    // MARK:- 定义属性
    var shop : Shop? {
        didSet {
            // 1.取出URLString
            guard let urlString = shop?.q_pic_url else {
                return
            }
            
            // 2.取出对应的图片
            var smallImage = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(urlString)
            if smallImage == nil {
                smallImage = UIImage(named: "empty_picture")
            }
            
            // 3.根据图片计算imageView的frame
            calculateImageViewFrame(smallImage)
            
            // 4.获取大图的URL
            let bigURL = getBigURL(urlString)
            
            // 5.设置大图
            imageView.sd_setImageWithURL(bigURL, placeholderImage: smallImage, options: [.RetryFailed, .LowPriority], progress: { (current, total) -> Void in
                
                }) { (image, _, _, _) -> Void in
                    self.calculateImageViewFrame(image)
            }
        }
    }
    
    // MARK:- 懒加载属性
    private lazy var scrollView : UIScrollView = UIScrollView()
    private lazy var imageView : UIImageView = UIImageView()
    
    // MARK:- 重写构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面
extension PhotoBrowserViewCell {
    private func setupUI() {
        // 1.添加子控件
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        // 2.设置子控件的frame
        scrollView.frame = contentView.bounds
    }
}



// MARK:- 自定义方法
extension PhotoBrowserViewCell {
    /// 计算imageView的frame
    private func calculateImageViewFrame(image : UIImage) {
        // 1.计算imageView的frame
        let imageViewW = UIScreen.mainScreen().bounds.width
        let imageViewH = imageViewW / image.size.width * image.size.height
        let x : CGFloat = 0
        var y : CGFloat = 0
        
        // 2.判断是长图还是短图
        if imageViewH <= UIScreen.mainScreen().bounds.height {
            y = (UIScreen.mainScreen().bounds.height - imageViewH) * 0.5
        } else {
            y = 0
        }
        
        // 3.设置frame
        imageView.frame = CGRect(x: x, y: y, width: imageViewW, height: imageViewH)
        
        // 4.设置scrollview的内容尺寸
        scrollView.contentSize = CGSize(width: 0, height: imageViewH)
    }
    
    /// 计算大图的NSURL
    private func getBigURL(smallURLString : String) -> NSURL {
        let bigURLString = smallURLString.stringByReplacingOccurrencesOfString("/q/", withString: "/z/")
        
        return NSURL(string: bigURLString)!
    }
}