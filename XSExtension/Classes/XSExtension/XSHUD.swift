//
//  XSHUD.swift
//  XSGesture
//
//  Created by huangxuesong on 2018/4/4.
//  Copyright © 2018年 hxs. All rights reserved.
//

import UIKit

open class XSHUD {
    
    private static let shared = XSHUD()
    
    /// 展示窗口
    private var window: UIWindow?
    
    /// 文本框
    private lazy var textLabel = UILabel(font: UIFont.systemFont(ofSize: 20), textColor: UIColor.white)
    
    /// 最小消失延迟
    private var dismissTimeInterval: TimeInterval = 1.5
    
    /// 展示文本
    private func show(text: String, delay: TimeInterval) {
        show(text: text)
        
        dismiss(delay: delay)
    }
    
    private func show(text: String) {
        if window != nil {
            return;
        }
        
        window = UIWindow()
        window?.windowLevel = UIWindowLevelAlert
        window?.layer.cornerRadius = 6
        window?.layer.masksToBounds = true
        window?.isHidden = false
        window?.addSubview(textLabel)
        window?.alpha = 0.7
        
        textLabel.text = text
        textLabel.sizeToFit()
        
        window!.size = CGSize(width: textLabel.width + 40, height: textLabel.height + 40)
        window!.center = CGPoint(x: wScreen / 2, y: hScreen / 2)
        textLabel.center = CGPoint(x: window!.width / 2, y: window!.height / 2)
    }
    
    private func dismiss(delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.window = nil
        }
    }
    
    // MARK: - 类方法
    
    /// 消失
    open class func dismiss() {
        self.shared.dismiss(delay: 0)
    }
    
    /// 展示文字
    open class func show(text: String) {
        self.shared.show(text: text, delay: self.shared.dismissTimeInterval)
    }
    
    /// 设置文字字体
    open class func setFont(font: UIFont) {
        self.shared.textLabel.font = font
    }
    
    /// 设置文字颜色
    open class func setTextColor(color: UIColor) {
        self.shared.textLabel.textColor = color
    }
    
    /// 设置最小消失延迟
    open class func setDismissTimeInterval(interval: TimeInterval) {
        self.shared.dismissTimeInterval = interval
    }
}

