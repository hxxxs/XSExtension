//
//  XSConfig.swift
//  XSExtension
//
//  Created by huangxuesong on 2018/4/3.
//  Copyright © 2018年 hxs. All rights reserved.
//

import UIKit

//  MARK: - 尺寸

/// 屏幕宽
public let wScreen = UIScreen.main.bounds.width
/// 屏幕高
public let hScreen = UIScreen.main.bounds.height
/// 状态栏高度
public let hStatusBar = UIApplication.shared.statusBarFrame.height

//  MARK: - 公共方法

/// 打印
public func XSLog<T>(_ items: T, fileName: String = #file, funcName: String = #function, lineNum: Int = #line) {
    debugPrint("------- begin print -------")
    debugPrint("FileName: \((fileName as NSString).lastPathComponent)")
    debugPrint("FuncName: \(funcName)")
    debugPrint("LineNum: \(lineNum)")
    debugPrint(items)
    debugPrint("------- end print -------")
}

/// 以 iPhone 6 的屏幕为基准计算水平方向值
public func XSScaleX(_ num: CGFloat) -> CGFloat {
    return (num) * wScreen / 375.0
}

/// 以 iPhone 6 的屏幕为基准计算垂直方向值
public func XSScaleY(_ num: CGFloat) -> CGFloat {
    return (num) * hScreen / 667.0
}

/// 角度转弧度
public func degreesToRadians(_ x : Float) -> Float {
    return (x * Float.pi / 180.0)
}

/// 弧度转角度
public func radiansToDegrees(_ x : Float) -> Float {
    return (x * 180.0 / Float.pi)
}

