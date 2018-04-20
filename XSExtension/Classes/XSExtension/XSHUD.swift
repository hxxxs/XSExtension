//
//  XSHUD.swift
//  XSGesture
//
//  Created by huangxuesong on 2018/4/4.
//  Copyright © 2018年 hxs. All rights reserved.
//

import UIKit

open class XSHUD {
    
    /// 消失
    open class func dismiss(delay: TimeInterval = 0) {
        shared.dismiss(delay: delay)
    }
    
    /// 展示成功状态
    open class func showSuccess(text: String = "成功") {
        let url = Bundle(for: self).url(forResource: "XSExtension", withExtension: "bundle")
        let resourceBundle = Bundle(url: url!)
        let image = UIImage(named: "success_hud", in: resourceBundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        show(text: text, image: image)
    }
    
    /// 展示失败状态
    open class func showError(text: String = "失败") {
        let url = Bundle(for: self).url(forResource: "XSExtension", withExtension: "bundle")
        let resourceBundle = Bundle(url: url!)
        let image = UIImage(named: "error_hud", in: resourceBundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        show(text: text, image: image)
    }
    
    
    ///  展示信息
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - image: 图片
    ///   - autoDismiss: 自动消失状态
    open class func show(text: String, image: UIImage? = nil, autoDismiss: Bool = true) {
        shared.show(text: text, image: image)
        if autoDismiss {
            dismiss(delay: shared.delay)
        }
    }
    
    /// 设置文字字体
    open class func setFont(font: UIFont) {
        shared.textLabel.font = font
    }
    
    /// 设置文字颜色
    open class func setTextColor(color: UIColor) {
        shared.textLabel.textColor = color
    }
    
    /// 设置延迟时间
    open class func setDelayTimeInterval(interval: TimeInterval) {
        shared.delay = interval
    }
    
    // MARK: -
    /// 单例
    private static let shared = XSHUD()
    
    /// 展示窗口
    private var window: UIWindow?
    
    /// 文本框
    private lazy var textLabel = UILabel(textColor: UIColor.white)
    
    /// 图标
    private lazy var iconView = UIImageView()
    
    /// 最小消失延迟
    private var delay: TimeInterval = 1.5
    
    /// 展示文本
    private func show(text: String, image: UIImage? = nil) {
        if window != nil {
            return;
        }
        
        window = UIWindow()
        window?.windowLevel = UIWindowLevelAlert
        window?.layer.cornerRadius = 6
        window?.layer.masksToBounds = true
        window?.isHidden = false
        window?.alpha = 0.7
        
        window?.addSubview(iconView)
        iconView.image = image
        iconView.sizeToFit()
        
        window?.addSubview(textLabel)
        textLabel.text = text
        textLabel.sizeToFit()
        
        let margin: CGFloat = 20
        var w = max(iconView.width, textLabel.width) + margin * 2
        let h = iconView.height + 10 + textLabel.height + margin * 2
        w = max(w, h)
        
        window!.size = CGSize(width: w, height: h)
        window!.center = CGPoint(x: wScreen / 2, y: hScreen / 2)
        
        if image != nil {
            iconView.centerX = window!.width / 2
            iconView.y = margin;
            
            textLabel.centerX = window!.width / 2
            textLabel.y = iconView.y + iconView.height + 10
        } else {
            textLabel.center = CGPoint(x: window!.width / 2, y: window!.height / 2)
        }
    }
    
    private func dismiss(delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.window = nil
        }
    }
}

