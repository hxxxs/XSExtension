//
//  XSStatusBarHUD.swift
//  Pods-XSExtension_Example
//
//  Created by hxs on 2018/4/20.
//

import UIKit

open class XSStatusBarHUD {
    
    /// 设置延迟时间
    open class func setDelayTimeInterval(interval: TimeInterval) {
        shared.delay = interval
    }
    
    /// 设置动画时间
    open class func setDurationTimeInterval(interval: TimeInterval) {
        shared.duration = interval
    }
    
    /// 展示成功状态
    open class func showSuccess(text: String = "成功") {
        let url = Bundle(for: self).url(forResource: "XSExtension", withExtension: "bundle")
        let resourceBundle = Bundle(url: url!)
        let image = UIImage(named: "success", in: resourceBundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        show(text: text, image: image)
    }
    
    /// 展示失败状态
    open class func showError(text: String = "失败") {
        let url = Bundle(for: self).url(forResource: "XSExtension", withExtension: "bundle")
        let resourceBundle = Bundle(url: url!)
        let image = UIImage(named: "error", in: resourceBundle, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        show(text: text, image: image)
    }
    
    /// 展示
    open class func show(text: String, image: UIImage? = nil, autoDismiss: Bool = true) {
        shared.show(text: text, image: image)
        if autoDismiss {
            dismiss(delay: shared.delay)
        }
    }
    
    /// 消失
    open class func dismiss(delay: TimeInterval = 0) {
        shared.dismiss(delay: delay)
    }

    //  MARK: -
    /// 单例
    private static let shared = XSStatusBarHUD()
    
    /// 展示窗口
    private var window: UIWindow?
    
    /// 最小消失延迟
    private var delay: TimeInterval = 1.5
    
    /// 动画时长
    private var duration: TimeInterval = 0.5
    
    private func show(text: String, image: UIImage? = nil) {
        if window != nil {
            return;
        }
        
        window = UIWindow(frame: CGRect(x: 0, y: -hStatusBar, width: wScreen, height: hStatusBar))
        window?.windowLevel = UIWindowLevelAlert
        window?.isHidden = false
        window?.backgroundColor = UIColor.black
        
        let button = UIButton(title: text, titleColor: UIColor.white, image: image)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        button.frame = window!.bounds
        window?.addSubview(button)
        
        if hStatusBar == 44 {
            window?.frame = CGRect(x: 0, y: -hStatusBar, width: wScreen, height: hStatusBar + 5)
            button.frame = CGRect(x: 0, y: hStatusBar - 15, width: window!.width, height: 20)
        }
        
        UIView.animate(withDuration: duration, animations: {
            self.window?.y = 0
        })
    }
    
    private func dismiss(delay: TimeInterval) {
        
        UIView.animate(withDuration: duration, delay: delay + duration, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            self.window?.y = -self.window!.height
        }) { (_) in
            self.window = nil
        }
    }

}
