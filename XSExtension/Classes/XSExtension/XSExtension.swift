//
//  XSExtension.swift
//  XSExtension
//
//  Created by huangxuesong on 2018/3/29.
//  Copyright © 2018年 hxs. All rights reserved.
//

import UIKit

// MARK: - Foundation Extension

extension Date {
    
    /// 自定义日期
    ///
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    /// - Returns: 日期
    public init(year: Int, month: Int, day: Int = 1) {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        self.init(timeInterval: 0, since: Calendar(identifier: .gregorian).date(from: components)!)
    }
    
    /// 农历
    public var lunar: [String: String] {
        
        let cal = Calendar(identifier: .chinese)
        let year = cal.component(.year, from: self)
        let month = cal.component(.month, from: self)
        let day = cal.component(.day, from: self)
        
        //  准备数据源
        let Zodiacs = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
        let HeavenlyStems = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
        let EarthlyBranches = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
        let Months = ["正月", "二月", "三月", "四月", "五月", "六月",
                      "七月", "八月", "九月", "十月", "冬月", "腊月"]
        let Days = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
                    "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
                    "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
        
        //  天干
        let heavenlyStemIndex = (year - 1) % HeavenlyStems.count
        let heavenlyStem = HeavenlyStems[heavenlyStemIndex]
        
        //  地支
        let earthlyBrancheIndex = (year - 1) % EarthlyBranches.count
        let earthlyBranche = EarthlyBranches[earthlyBrancheIndex]
        let yearString = "\(heavenlyStem)\(earthlyBranche)"
        
        //  生肖
        let zodiacIndex = (year - 1) % Zodiacs.count
        let zodiac = Zodiacs[zodiacIndex]
        
        //  月
        let monthIndex = (month - 1) % Months.count
        let monthString = Months[monthIndex]
        
        //  日
        let dayIndex = (day - 1) % Days.count
        let dayString = Days[dayIndex]
        
        return ["year": yearString,
                "zodiac": zodiac,
                "month": monthString,
                "day": dayString]
    }
    
    /// 前一个月
    public var previousMonth: Date {
        var dateComponents = DateComponents()
        dateComponents.month = -1
        return Calendar(identifier: .gregorian).date(byAdding: dateComponents, to: self)!
    }
    
    /// 下个月
    public var nextMonth: Date {
        var dateComponents = DateComponents()
        dateComponents.month = 1
        return Calendar(identifier: .gregorian).date(byAdding: dateComponents, to: self)!
    }
    
    /// 本月第一天
    public var firstDayOfMonth: Date {
        let count = Calendar(identifier: .gregorian).component(.day, from: self)
        var dateComponents = DateComponents()
        dateComponents.day = -count + 1
        return Calendar(identifier: .gregorian).date(byAdding: dateComponents, to: self)!
    }
    
    /// 总天数
    public var totaldaysInMonth: Int {
        return Calendar(identifier: .gregorian).range(of: .day, in: .month, for: self)!.count
    }
    
    /// 总周数
    public var totalWeeksInMonth: Int {
        return Calendar(identifier: .gregorian).range(of: .weekOfMonth, in: .month, for: self)!.count
    }
    
    /// 天
    public var day: Int {
        return Calendar(identifier: .gregorian).component(.day, from: self)
    }
    
    /// 月
    public var month: Int {
        return Calendar(identifier: .gregorian).component(.month, from: self)
    }
    
    /// 年
    public var year: Int {
        return Calendar(identifier: .gregorian).component(.year, from: self)
    }
}

extension String {
    
    /// 加密手机号
    public var encryptionPhone: String {
        
        assert(isPhoneNumber, "无效的手机号")
        
        let range = Range(NSRange(location: 3, length: 4), in: self)
        return replacingCharacters(in: range!, with: "****")
    }
    
    /// 金额格式化，千位符&保留2位小数
    public var amountFormatter: String {
        
        guard let num = Float(self) else { return "" }
        
        let fmt = NumberFormatter()
        fmt.positiveFormat = "#,##0.00" //  #表示预设值，当数字没有此位时则舍去不补位，0表示位数，当数字没有此位时会以0去补位
        return fmt.string(from: num as NSNumber) ?? ""
    }
    
    //  MARK: - 沙盒路径
    
    /// 给当前文件追加文档路径
    public var appendDocumentDir: String {
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        return dir!.appendingFormat("/%@", self)
    }
    
    /// 给当前文件追加缓存路径
    public var appendCacheDir:String {
        let dir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last
        return dir!.appendingFormat("/%@", self)
    }
    
    /// 给当前文件追加临时路径
    public var appendTempDir: String {
        return NSTemporaryDirectory().appending(self)
    }
    
    //  MARK: - 验证相关
    
    /// 工商税号
    public var isTaxNo: Bool {
        let regex = "[0-9]\\d{13}([0-9]|X)$"
        return vaildRegex(regex: regex)
    }
    
    /// 邮编
    public var isPostalcode: Bool {
        let regex = "^[0-8]\\d{5}(?!\\d)$"
        return vaildRegex(regex: regex)
    }
    
    /// 地址
    public var isUrl: Bool {
        let regex = "^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
        return vaildRegex(regex: regex)
    }
    
    /// 车牌
    public var isCarNo: Bool {
        let regex = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
        return vaildRegex(regex: regex)
    }
    
    /// 邮箱
    public var isEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        return vaildRegex(regex: regex)
    }
    
    /// 纯中文
    public var isChineseCharacters: Bool {
        let regex = "^[\\u4e00-\\u9fa5]+$";
        return vaildRegex(regex: regex)
    }
    
    /// 身份证号
    public var isIdCardNumber: Bool {
        let regex = "^\\d{6}(18|19|20)?\\d{2}(0[1-9]|1[012])(0[1-9]|[12]\\d|3[01])\\d{3}(\\d|[xX])$"
        return vaildRegex(regex: regex)
    }
    
    /// 手机号
    public var isPhoneNumber: Bool {
        let regex = "^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$"
        return vaildRegex(regex: regex)
    }
    
    /// 正则校验
    ///
    /// - Parameters:
    ///   - regex: 正则表达式
    /// - Returns: 校验结果
    private func vaildRegex(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}

extension NSAttributedString {
    
    /// 使用图像和文本生成上下排列的属性文本
    ///
    /// - Parameters:
    ///   - img: 顶部图片
    ///   - title: 标题
    ///   - wh: 图片宽高，默认30
    ///   - fontSize: 标题大小，默认16号字
    ///   - color: 标题颜色，默认darkText
    ///   - space: 分隔距离，默认8
    public convenience init(img: UIImage, title: String, wh: CGFloat = 30, fontSize: CGFloat = 16, color: UIColor = .darkText, space: CGFloat = 8) {
        
        // 图片属性文本
        let attachment = NSTextAttachment()
        attachment.image = img
        attachment.bounds = CGRect(x: 0, y: 0, width: wh, height: wh)
        let imgAttr = NSAttributedString(attachment: attachment)
        
        // 间距属性文本
        let spaceAttr = NSAttributedString(
            string: "\n\n",
            attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: space)]
        )
        
        // 标题属性文本
        let titleAttr = NSAttributedString(
            string: title,
            attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize),
                         .foregroundColor: color]
        )
        
        // 合并属性文本
        let attrM = NSMutableAttributedString(attributedString: imgAttr)
        attrM.append(spaceAttr)
        attrM.append(titleAttr)
        
        self.init(attributedString: attrM.copy() as! NSAttributedString)
    }
}

extension Bundle {
    
    /// 命名空间
    public var nameSpace: String {
        return infoDictionary?["CFBundleExecutable"] as? String ?? ""
    }
    
    /// 当前版本
    public var currentVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
}

// MARK: - UIKit Extension

private var KEYREDSHAPELAYER = "KEYREDSHAPELAYER"

extension UIView {
    
    private var redShapeLayer: CAShapeLayer? {
        set {
            objc_setAssociatedObject(self, &KEYREDSHAPELAYER, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &KEYREDSHAPELAYER) as? CAShapeLayer
        }
    }
    
    public var x : CGFloat {
        set {
            frame.origin.x = newValue
        }
        get {
            return frame.origin.x
        }
    }
    
    public var y : CGFloat {
        set {
            frame.origin.y = newValue
        }
        get {
            return frame.origin.y
        }
    }
    
    public var width : CGFloat {
        set {
            frame.size.width = newValue
        }
        get {
            return frame.width
        }
    }
    
    public var height : CGFloat {
        set {
            frame.size.height = newValue
        }
        get {
            return frame.height
        }
    }
    
    public var centerX : CGFloat {
        set {
            center.x = newValue
        }
        get {
            return center.x
        }
    }
    
    public var centerY : CGFloat {
        set {
            center.y = newValue
        }
        get {
            return center.y
        }
    }
    
    public var size : CGSize {
        set {
            frame.size = newValue
        }
        get {
            return frame.size
        }
    }
    
    public var origin : CGPoint {
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
        
        if redShapeLayer == layer.sublayers?.last {
            redShapeLayer!.removeFromSuperlayer()
        }
    }
    
    /// 展示红点
    public func showRedDot() {
        
        if redShapeLayer == layer.sublayers?.last {
            return
        }
        
        redShapeLayer = CAShapeLayer()
        redShapeLayer!.fillColor = UIColor.red.cgColor
        layer.addSublayer(redShapeLayer!)
        
        let wh = min(min(width, height) / 2, 10)
        let x = width - wh / 2
        let y = -wh / 2
        let path = UIBezierPath(ovalIn: CGRect(x: x, y: y, width: wh, height: wh))
        redShapeLayer!.path = path.cgPath
    }
    
    /// 抖动动画
    public func animationShaker() {
        let kfanimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let cTx = transform.tx
        kfanimation.duration = 0.4
        kfanimation.values = [cTx, cTx+10, cTx-8, cTx+8, cTx-5, cTx+5, cTx]
        kfanimation.keyTimes = [(0), (0.225), (0.425), (0.525), (0.750), (0.875), (1)]
        kfanimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(kfanimation, forKey: "kShakerAnimationKey")
    }
    
    /// 弹跳动画
    public func animationBeat() {
        transform = CGAffineTransform()
        UIView.animateKeyframes(withDuration: 0.3,
                                delay: 0,
                                options: UIViewKeyframeAnimationOptions(rawValue: 0),
                                animations: {
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
        },
                                completion: nil)
    }
    
}

extension UILabel {
    
    /// 便利构造方法
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - textColor: 文字颜色
    ///   - textAlignment: 文字对齐方式
    ///   - numberOfLines: 行数
    public convenience init(text: String? = nil, font: UIFont = .systemFont(ofSize: 16),
                            textColor: UIColor = .darkGray,
                            textAlignment: NSTextAlignment = .left,
                            numberOfLines: Int = 1) {
        self.init()
        
        configPropertys(font: font,
                        textColor: textColor,
                        textAlignment: textAlignment,
                        numberOfLines: numberOfLines)
        
        self.text = text
        sizeToFit()
    }
    
    /// 配置属性
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - textColor: 文字颜色
    ///   - textAlignment: 文字对齐方式
    ///   - numberOfLines: 行数
    public func configPropertys(font: UIFont = .systemFont(ofSize: 16),
                                textColor: UIColor = .darkGray,
                                textAlignment: NSTextAlignment = .left,
                                numberOfLines: Int = 1) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}

extension UIImage {
    
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
                            type: UIButtonType = .system) {
        
        self.init(type: type)
        
        titleLabel?.configPropertys(font: font,
                                    textAlignment: textAlignment,
                                    numberOfLines: numberOfLines)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setImage(image, for: .normal)
        setBackgroundImage(bgImage, for: .normal)
        setAttributedTitle(titleAttr, for: .normal)
        sizeToFit()
        
        guard action != nil else {
            return
        }
        addTarget(target, action: action!, for: .touchUpInside)
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
                            type: UIButtonType = .system) {
        
        self.init(type: type)
        
        let attr = NSAttributedString(img: img,
                                      title: title,
                                      wh: wh,
                                      fontSize: fontSize,
                                      color: color, space: space)
        
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
        
        setAttributedTitle(attr, for: .normal)
        sizeToFit()
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
    public convenience init(hex: UInt32) {
        
        let r = CGFloat((hex & 0xff0000) >> 16)
        let g = CGFloat((hex & 0x00ff00) >> 8)
        let b = CGFloat(hex & 0x0000ff)
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
}
