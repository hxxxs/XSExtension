//
//  XSKit.swift
//  XSExtension
//
//  Created by LL on 2021/4/14.
//  UIKit 链式编程属性设置

#if os(iOS) || os(tvOS)

import UIKit

extension UILabel {
    
    /// 便利构造方法
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - textColor: 文字颜色
    ///   - textAlignment: 文字对齐方式
    ///   - numberOfLines: 行数
    public convenience init(text: String? = nil,
                            font: UIFont = .systemFont(ofSize: 16),
                            textColor: UIColor = .darkGray,
                            textAlignment: NSTextAlignment = .left,
                            numberOfLines: Int = 1) {
        self.init()
        
        configProperties(font: font,
                         textColor: textColor,
                         textAlignment: textAlignment,
                         numberOfLines: numberOfLines)
        
        self.text(text)
        sizeToFit()
    }
    
    /// 配置属性
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - textColor: 文字颜色
    ///   - textAlignment: 文字对齐方式
    ///   - numberOfLines: 行数
    public func configProperties(font: UIFont = .systemFont(ofSize: 16),
                                 textColor: UIColor = .darkGray,
                                 textAlignment: NSTextAlignment = .left,
                                 numberOfLines: Int = 1) {
        
        self.font(font)
            .textColor(textColor)
            .textAlignment(textAlignment)
            .numberOfLines(numberOfLines)
    }
    
    @discardableResult public func text(_ text: String?) -> UILabel {
        self.text = text
        return self
    }
    
    @discardableResult public func font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    @discardableResult public func textColor(_ textColor: UIColor) -> UILabel {
        self.textColor = textColor
        return self
    }
    
    @discardableResult public func shadowColor(_ shadowColor: UIColor) -> UILabel {
        self.shadowColor = shadowColor
        return self
    }
    
    @discardableResult public func shadowOffset(_ shadowOffset: CGSize) -> UILabel {
        self.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult public func textAlignment(_ textAlignment: NSTextAlignment) -> UILabel {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult public func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> UILabel {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    @discardableResult public func attributedText(_ attributedText: NSAttributedString) -> UILabel {
        self.attributedText = attributedText
        return self
    }
    
    @discardableResult public func highlightedTextColor(_ highlightedTextColor: UIColor) -> UILabel {
        self.highlightedTextColor = highlightedTextColor
        return self
    }
    
    @discardableResult public func isHighlighted(_ isHighlighted: Bool) -> UILabel {
        self.isHighlighted = isHighlighted
        return self
    }
    
    @discardableResult public func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> UILabel {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    @discardableResult public func isEnabled(_ isEnabled: Bool) -> UILabel {
        self.isEnabled = isEnabled
        return self
    }
    
    @discardableResult public func numberOfLines(_ numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult public func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> UILabel {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult public func baselineAdjustment(_ baselineAdjustment: UIBaselineAdjustment) -> UILabel {
        self.baselineAdjustment = baselineAdjustment
        return self
    }
    
    @discardableResult public func minimumScaleFactor(_ minimumScaleFactor: CGFloat) -> UILabel {
        self.minimumScaleFactor = minimumScaleFactor
        return self
    }
    
    @available(iOS 9.0, *)
    @discardableResult public func allowsDefaultTighteningForTruncation(_ allowsDefaultTighteningForTruncation: Bool) -> UILabel {
        self.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return self
    }
    
    @available(iOS 14.0, *)
    @discardableResult public func lineBreakStrategy(_ lineBreakStrategy: NSParagraphStyle.LineBreakStrategy) -> UILabel {
        self.lineBreakStrategy = lineBreakStrategy
        return self
    }
    
    @discardableResult public func preferredMaxLayoutWidth(_ preferredMaxLayoutWidth: CGFloat) -> UILabel {
        self.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        return self
    }
    
}

extension UIButton {
    
    /// 便利构造方法
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleColor: 标题颜色
    ///   - titleAttr: 标题属性文本
    ///   - image: 图片
    ///   - bgImage: 背景图片
    ///   - font: 字体
    ///   - textAlignment: 文字对齐方式
    ///   - numberOfLines: 行数
    ///   - target: 监听者对象
    ///   - action: 方法
    ///   - type: 按钮样式
    public convenience init(title: String? = nil,
                            titleColor: UIColor = .darkGray,
                            titleAttr: NSAttributedString? = nil,
                            image: UIImage? = nil,
                            bgImage: UIImage? = nil,
                            font: UIFont = .systemFont(ofSize: 16),
                            textAlignment: NSTextAlignment = .left,
                            numberOfLines: Int = 1,
                            target: Any? = nil,
                            action: Selector? = nil,
                            type: UIButton.ButtonType = .system) {
        
        self.init(type: type)
        
        titleLabel?.configProperties(font: font,
                                     textAlignment: textAlignment,
                                     numberOfLines: numberOfLines)
        
        setTitle(title)
            .setTitleColor(titleColor)
            .setBackgroundImage(bgImage)
            .setImage(image)
            .setAttributedTitle(titleAttr)
        
        sizeToFit()
        
        guard action != nil else {
            return
        }
        _ = addTarget(target, action!)
    }
    
    /// 创建顶部图片底部文字的按钮
    ///
    /// - Parameters:
    ///   - img: 图片
    ///   - title: 标题
    ///   - wh: 图片宽高，默认30
    ///   - fontSize: 标题文字大小，默认16
    ///   - color: 标题颜色，默认darkGray
    ///   - space: 图片和文字的间距大小，默认8
    ///   - type: 按钮样式，默认system
    public convenience init(img: UIImage,
                            title: String,
                            wh: CGFloat = 30,
                            fontSize: CGFloat = 16,
                            color: UIColor = .darkGray,
                            space: CGFloat = 8,
                            type: UIButton.ButtonType = .system) {
        
        self.init(type: type)
        
        titleLabel?.numberOfLines(0)
            .textAlignment(.center)
        
        setAttributedTitle(NSAttributedString(img: img,
                                              title: title,
                                              wh: wh,
                                              fontSize: fontSize,
                                              color: color, space: space))
        sizeToFit()
    }
    
    @discardableResult public func setTitle(_ title: String?, _ state: UIControl.State = .normal) -> UIButton {
        self.setTitle(title, for: state)
        return self
    }
    
    @discardableResult public func setTitleColor(_ color: UIColor?, _ state: UIControl.State = .normal) -> UIButton {
        self.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult public func setTitleShadowColor(_ color: UIColor?, _ state: UIControl.State = .normal) -> UIButton {
        self.setTitleShadowColor(color, for: state)
        return self
    }
    
    @discardableResult public func setAttributedTitle(_ title: NSAttributedString?, _ state: UIControl.State = .normal) -> UIButton {
        self.setAttributedTitle(title, for: state)
        return self
    }
    
    @discardableResult public func setImage(_ image: UIImage?, _ state: UIControl.State = .normal) -> UIButton {
        self.setImage(image, for: state)
        return self
    }
    
    @discardableResult public func setBackgroundImage(_ image: UIImage?, _ state: UIControl.State = .normal) -> UIButton {
        self.setBackgroundImage(image, for: state)
        return self
    }
    
    @available(iOS 13.0, *)
    @discardableResult public func setPreferredSymbolConfiguration(_ configuration: UIImage.SymbolConfiguration, _ state: UIControl.State = .normal) -> UIButton {
        self.setPreferredSymbolConfiguration(configuration, forImageIn: state)
        return self
    }
    
    @discardableResult public func addTarget(_ target: Any?, _ action: Selector, _ event: UIControl.Event = .touchUpInside) -> UIButton {
        self.addTarget(target, action: action, for: event)
        return self
    }
    
    @discardableResult public func contentEdgeInsets(_ inset: UIEdgeInsets) -> UIButton {
        self.contentEdgeInsets = inset
        return self
    }
    
    @discardableResult public func titleEdgeInsets(_ inset: UIEdgeInsets) -> UIButton {
        self.titleEdgeInsets = inset
        return self
    }
    
    @discardableResult public func imageEdgeInsets(_ inset: UIEdgeInsets) -> UIButton {
        self.imageEdgeInsets = inset
        return self
    }
    
    @discardableResult public func adjustsImageWhenHighlighted(_ isAdjusts: Bool) -> UIButton {
        self.adjustsImageWhenHighlighted = isAdjusts
        return self
    }
    
    @discardableResult public func adjustsImageWhenDisabled(_ isAdjusts: Bool) -> UIButton {
        self.adjustsImageWhenDisabled = isAdjusts
        return self
    }
    
    @discardableResult public func showsTouchWhenHighlighted(_ isShows: Bool) -> UIButton {
        self.showsTouchWhenHighlighted = isShows
        return self
    }
    
    @discardableResult public func tintColor(_ color: UIColor) -> UIButton {
        self.tintColor = color
        return self
    }
    
    @available(iOS 14.0, *)
    @discardableResult public func role(_ role: UIButton.Role) -> UIButton {
        self.role = role
        return self
    }
    
    @available(iOS 13.4, *)
    @discardableResult public func isPointerInteractionEnabled(_ isEnabled: Bool) -> UIButton {
        self.isPointerInteractionEnabled = isEnabled
        return self
    }
    
    @available(iOS 14.0, *)
    @discardableResult public func menu(_ menu: UIMenu) -> UIButton {
        self.menu = menu
        return self
    }
}

//  MARK: - QuartzCore

extension CALayer {
    @IBInspectable public var borderColorFromUIColor: UIColor {
        set {
            borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: borderColor!)
        }
    }
}

extension UIColor {
    
    /// 随机色
    open class var random: UIColor {
        
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    /// 使用 16 进制数字创建颜色
    ///
    /// - Parameter hex: 16 进制无符号32位整数
    public convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        
        let r = CGFloat((hex & 0xff0000) >> 16)
        let g = CGFloat((hex & 0x00ff00) >> 8)
        let b = CGFloat(hex & 0x0000ff)
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}

extension UIImage {
    
    public enum GradientType {
        case topToBottom
        case leftToRight
        case upleftToLowright
        case uprightToLowleft
    }
    
    /// 渐变色图片
    /// - Parameters:
    ///   - gradientColors: 渐变色数组
    ///   - type: 渐变方向枚举
    ///   - size: 图片尺寸
    public convenience init?(gradientColors:[UIColor],
                             type: GradientType = .topToBottom,
                             size: CGSize = CGSize(width: 30, height: 30)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colors = gradientColors.map {
            $0.cgColor
        } as CFArray
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil) else { return nil }
        
        let start: CGPoint
        let end: CGPoint
        switch type {
        case .topToBottom:
            start = CGPoint.zero
            end = CGPoint(x: 0, y: size.height)
        case .leftToRight:
            start = CGPoint.zero
            end = CGPoint(x: size.width, y: 0)
        case .upleftToLowright:
            start = CGPoint.zero
            end = CGPoint(x: size.width, y: size.height)
        case .uprightToLowleft:
            start = CGPoint(x: size.width, y: 0)
            end = CGPoint(x: 0, y: size.height)
        }
        
        context.drawLinearGradient(gradient, start: start, end: end, options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        self.init(cgImage: image.cgImage!)
        UIGraphicsEndImageContext()
    }
    
    /// 修正图片方向
    open var fixOrientation: UIImage {
        if imageOrientation == .up {
            return self
        }
        var transform = CGAffineTransform.identity
        switch imageOrientation {
        case .down,.downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -.pi / 2)
            
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
    
    /// 裁剪成带圆弧的图片
    ///
    /// - Parameters:
    ///   - cornerRadius: 圆弧半径
    ///   - imageSize: 图片大小，默认为当前图片大小
    ///   - lineWidth: 边框宽度，默认为0
    ///   - lineColor: 边框颜色，默认为白色
    ///   - backColor: 背景颜色，默认白色
    public func ovalImage(cornerRadius: CGFloat,
                          imageSize: CGSize? = nil,
                          lineWidth: CGFloat = 0,
                          lineColor: UIColor = .white,
                          backColor: UIColor = .white) -> UIImage {
        //  定义绘制空间
        let rect: CGRect
        if imageSize != nil {
            rect = CGRect(x: 0, y: 0, width: imageSize!.width, height: imageSize!.width)
        } else {
            rect = CGRect(x: 0, y: 0, width: size.width, height: size.width)
        }
        
        //  开启上下文绘制底层颜色
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        backColor.setFill()
        UIRectFill(rect)
        
        //  裁剪图片
        let patch = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        patch.addClip()
        draw(in: rect)
        
        //  边框
        let ovalPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        ovalPath.lineWidth = lineWidth
        lineColor.setStroke()
        ovalPath.stroke()
        
        //  获取结果关闭上下文
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
    
    /// 圆形裁剪
    public var circular: UIImage {
        
        //  获取最短边长
        let shotest = min(size.width, size.height)
        
        //  设置绘图区间
        let rect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        
        //  开启绘图上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        //  获取当前上下文
        let context = UIGraphicsGetCurrentContext()!
        
        //  设置裁剪区域
        context.addEllipse(in: rect)
        context.clip()
        
        //  绘制
        draw(in: rect)
        
        //  获取结果
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        //  关闭绘图上下文
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 创建图片
    ///
    /// - Parameter color: 颜色
    /// - Returns: 图片
    open class func create(color: UIColor,
                           size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        
        //  设置绘图区间
        let rect = CGRect(origin: .zero, size: size)
        //  开启绘图上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        //  设置填充颜色
        color.setFill()
        //  填充区域
        UIRectFill(rect)
        //  获取结果
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        //  关闭绘图上下文
        UIGraphicsEndImageContext()
        return image
    }
}

extension Int {
    /// 以 iPhone 6 的屏幕为基准计算水平方向值
    public var adaptWidth: CGFloat {
        return CGFloat(self).adaptWidth
    }
    
    /// 以 iPhone 6 的屏幕为基准计算垂直方向值
    public var adaptHeight: CGFloat {
        return CGFloat(self).adaptHeight
    }
}

extension Double {
    /// 以 iPhone 6 的屏幕为基准计算水平方向值
    public var adaptWidth: CGFloat {
        return CGFloat(self).adaptWidth
    }
    
    /// 以 iPhone 6 的屏幕为基准计算垂直方向值
    public var adaptHeight: CGFloat {
        return CGFloat(self).adaptHeight
    }
}

extension Float {
    /// 以 iPhone 6 的屏幕为基准计算水平方向值
    public var adaptWidth: CGFloat {
        return CGFloat(self).adaptWidth
    }
    
    /// 以 iPhone 6 的屏幕为基准计算垂直方向值
    public var adaptHeight: CGFloat {
        return CGFloat(self).adaptHeight
    }
}

extension CGFloat {
    
    /// 以 iPhone 6 的屏幕为基准计算水平方向值
    public var adaptWidth: CGFloat {
        let w = UIScreen.main.bounds.width
        return self * w / 375.0
    }
    
    /// 以 iPhone 6 的屏幕为基准计算垂直方向值
    public var adaptHeight: CGFloat {
        let h = UIScreen.main.bounds.height
        return self * h / 667.0
    }
}

extension UITableViewHeaderFooterView {
    open class var identifier: String {
        "\(classForCoder())"
    }
}

extension UITableViewCell {
    
    open class var identifier: String {
        "\(classForCoder())"
    }
    
    /// 注册并返回一个可重用单元格
    ///
    /// - Parameters:
    ///   - tableView: 注册单元格的tableview
    ///   - style: 单元格样式，默认样式default
    ///   - reuseIdentifier: 注册可重用单元格标识符
    open class func cell(with tableView: UITableView,
                         style: UITableViewCell.CellStyle = .default,
                         reuseIdentifier: String = identifier) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
        }
        return cell!
    }
}

extension UIViewController {
    
    /// alert
    /// - Parameters:
    ///   - message: 消息
    ///   - title: 标题
    ///   - cannelTitle: 取消按钮名称
    ///   - cannelHandler: 取消按钮回调
    ///   - confirmTitle: 确认按钮
    ///   - confirmHandler: 确认按钮回调
    ///   - completion: 完成回调
    public func showAlertVC(message: String?,
                            title: String?,
                            cannelTitle: String?,
                            cannelHandler: ((UIAlertAction) -> Void)?,
                            confirmTitle: String?,
                            confirmHandler: ((UIAlertAction) -> Void)?,
                            completion: (() -> Void)?) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cannelTitle != nil {
            vc.addAction(UIAlertAction(title: cannelTitle, style: .cancel, handler: cannelHandler))
        }
        if confirmTitle != nil {
            vc.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: confirmHandler))
        }
        present(vc, animated: true, completion: completion)
    }
    
    /// 通过storyboard初始化视图控制器
    open class func vcFrom(storyboard name: String? = nil,
                           identifier: String? = nil,
                           bundle: Bundle? = nil) -> Self {
        let sb = UIStoryboard(name: name ?? "\(classForCoder())", bundle: bundle)
        return sb.instantiateViewController(withIdentifier: identifier ?? "\(classForCoder())") as! Self
    }
}

extension UIView {
    
    /// 便利构造函数
    /// - Parameter bgColor: 背景色
    public convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    /// 通过xib初始化视图
    open class func view(from nibName: String? = nil,
                         bundle: Bundle? = nil) -> Self {
        let nib = UINib(nibName: nibName ?? "\(classForCoder())", bundle: bundle)
        return nib.instantiate(withOwner: nil, options: nil).last as! Self
    }
    
    // MARK: - Properties
    
    @IBInspectable public var masksToBounds: Bool {
        set {
            layer.masksToBounds = newValue
        }
        get {
            return layer.masksToBounds
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
    }
    
    public var x: CGFloat {
        set {
            frame.origin.x = newValue
        }
        get {
            return frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set {
            frame.origin.y = newValue
        }
        get {
            return frame.origin.y
        }
    }
    
    public var width: CGFloat {
        set {
            frame.size.width = newValue
        }
        get {
            return frame.width
        }
    }
    
    public var height: CGFloat {
        set {
            frame.size.height = newValue
        }
        get {
            return frame.height
        }
    }
    
    public var centerX: CGFloat {
        set {
            center.x = newValue
        }
        get {
            return center.x
        }
    }
    
    public var centerY: CGFloat {
        set {
            center.y = newValue
        }
        get {
            return center.y
        }
    }
    
    public var size: CGSize {
        set {
            frame.size = newValue
        }
        get {
            return frame.size
        }
    }
    
    public var origin: CGPoint {
        set {
            frame.origin = newValue
        }
        get {
            return frame.origin
        }
    }
    
    /// 视图快照
    public var snapshotImage: UIImage {
        //  开启绘图上下文
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)
        //  绘制
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        //  获取结果
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        //  关闭绘图上下文
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 隐藏红点
    public func hiddenRedDot() {
        for v in subviews {
            if v.tag == 20180619 {
                v.removeFromSuperview()
            }
        }
    }
    
    /// 展示红点
    public func showRedDot(wh: CGFloat = 8) {
        showRedDot(wh: wh, center: CGPoint(x: width, y: -wh / 2))
    }
    
    /// 展示红点
    public func showRedDot(wh: CGFloat = 8, center: CGPoint) {
        hiddenRedDot()
        let redView = UIView(frame: CGRect(x: center.x, y: center.y, width: wh, height: wh))
        redView.backgroundColor = UIColor.red
        redView.cornerRadius = wh / 2
        redView.tag = 20180619
        addSubview(redView)
    }
    
    /// 抖动动画
    public func animationShaker() {
        let kfanimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let cTx = transform.tx
        kfanimation.duration = 0.4
        kfanimation.values = [cTx, cTx+10, cTx-8, cTx+8, cTx-5, cTx+5, cTx]
        kfanimation.keyTimes = [(0), (0.225), (0.425), (0.525), (0.750), (0.875), (1)]
        kfanimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(kfanimation, forKey: "kShakerAnimationKey")
    }
    
    /// 弹跳动画
    public func animationBeat() {
        transform = CGAffineTransform()
        UIView.animateKeyframes(withDuration: 0.3,
                                delay: 0,
                                options: UIView.KeyframeAnimationOptions(rawValue: 0),
                                animations:
                                    {
                                        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3.0, animations: {
                                            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                                        })
                                        UIView.addKeyframe(withRelativeStartTime: 1 / 3.0,
                                                           relativeDuration: 1 / 3.0,
                                                           animations: {
                                                            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                                                           })
                                        UIView.addKeyframe(withRelativeStartTime: 2 / 3.0,
                                                           relativeDuration: 1 / 3.0,
                                                           animations: {
                                                            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                                           })
                                    }, completion: nil)
    }
}

fileprivate var KEYPlACEHOLDERLABEL = "KEYPlACEHOLDERLABEL"

extension UITextView {
    
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
    }
    
    /// 占位文本框
    open var placeholderLabel: UILabel? {
        set {
            objc_setAssociatedObject(self, &KEYPlACEHOLDERLABEL, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            NotificationCenter.default.addObserver(self, selector: #selector(updatePlaceholder), name: UITextView.textDidChangeNotification, object: self)
        }
        get {
            return objc_getAssociatedObject(self, &KEYPlACEHOLDERLABEL) as? UILabel
        }
    }
    
    open var placeholder: String {
        set {
            placeholderLabel = UILabel(text: newValue, font: self.font ?? UIFont.systemFont(ofSize: 15), textColor: UIColor.lightGray, textAlignment: self.textAlignment, numberOfLines: 0)
            insertSubview(placeholderLabel!, at: 0)
            
            let x = textContainerInset.left + textContainer.lineFragmentPadding + layer.borderWidth;
            let y = textContainerInset.top + layer.borderWidth
            let w = width - x - textContainerInset.right - 2 * layer.borderWidth
            let h = placeholderLabel!.sizeThatFits(CGSize(width: w, height: 0)).height
            placeholderLabel!.frame = CGRect(x: x, y: y, width: w, height: h)
            
            updatePlaceholder()
        }
        get {
            return placeholderLabel?.text ?? ""
        }
    }
    
    @objc open func updatePlaceholder() {
        placeholderLabel!.isHidden = text.count > 0
    }
}

#endif
