//
//  XSExtension.swift
//  XSExtension
//
//  Created by huangxuesong on 2018/3/29.
//  Copyright © 2018年 hxs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

//  准备数据源
fileprivate let Zodiacs = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
fileprivate let HeavenlyStems = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
fileprivate let EarthlyBranches = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]
fileprivate let Months = ["正月", "二月", "三月", "四月", "五月", "六月",
              "七月", "八月", "九月", "十月", "冬月", "腊月"]
fileprivate let Days = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
            "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]

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
        self.init(timeInterval: 0,
                  since: Calendar(identifier: .gregorian).date(from: components)!)
    }
    
    /// 农历
    public var lunar: [String: String] {
        let cal = Calendar(identifier: .chinese)
        let year = cal.component(.year, from: self)
        let month = cal.component(.month, from: self)
        let day = cal.component(.day, from: self)
  
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
        Calendar(identifier: .gregorian).range(of: .day, in: .month, for: self)!.count
    }
    
    /// 总周数
    public var totalWeeksInMonth: Int {
        Calendar(identifier: .gregorian).range(of: .weekOfMonth, in: .month, for: self)!.count
    }
    
    /// 天
    public var day: Int {
        Calendar(identifier: .gregorian).component(.day, from: self)
    }
    
    /// 月
    public var month: Int {
        Calendar(identifier: .gregorian).component(.month, from: self)
    }
    
    /// 年
    public var year: Int {
        Calendar(identifier: .gregorian).component(.year, from: self)
    }
}

extension String {
    
    /// 文字高度
    /// - Parameters:
    ///   - font: 字体大小
    ///   - width: 文字展示宽度
    ///   - lineSpace: 行间距
    /// - Returns: 高度
    public func stringHeight(form font: UIFont, width: CGFloat, lineSpace: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.paragraphStyle: paragraphStyle.copy()]
        
        let rect = (self as NSString).boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    /// 时间戳转字符串
    ///
    /// - Parameters:
    ///   - dateFormat: 时间格式
    ///   - timeInterval: 时间戳（单位s）
    public static func timestampConvertString(dateFormat: String = "yyyy-MM-dd HH:mm",
                                              timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return dateConvertString(dateFormat: dateFormat, date: date)
    }
    
    /// 日期转字符串
    ///
    /// - Parameters:
    ///   - dateFormat: 时间格式
    ///   - date: 日期
    public static func dateConvertString(dateFormat: String = "yyyy-MM-dd HH:mm",
                                         date: Date) -> String {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.dateFormat = dateFormat
        return fmt.string(from: date)
    }
    
    /// 加密手机号
    public var encryptionPhone: String {
        if !isPhoneNumber {
            debugPrint("无效的手机号")
            return self
        }
        
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
        NSTemporaryDirectory().appending(self)
    }
    
    /// 工商税号
    public var isTaxNo: Bool {
        vaildRegex("[0-9]\\d{13}([0-9]|X)$")
    }
    
    /// 邮编
    public var isPostalcode: Bool {
        vaildRegex("^[0-8]\\d{5}(?!\\d)$")
    }
    
    /// 地址
    public var isUrl: Bool {
        vaildRegex("^((http)|(https))+:[^\\s]+\\.[^\\s]*$")
    }
    
    /// 车牌
    public var isCarNo: Bool {
        vaildRegex("^[A-Za-z]{1}[A-Za-z_0-9]{5}$")
    }
    
    /// 邮箱
    public var isEmail: Bool {
        vaildRegex("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    /// 纯中文
    public var isChineseCharacters: Bool {
        vaildRegex("^[\\u4e00-\\u9fa5•]+$")
    }
    
    /// 身份证号
    public var isIdCardNumber: Bool {
        vaildRegex("^\\d{6}(18|19|20)?\\d{2}(0[1-9]|1[012])(0[1-9]|[12]\\d|3[01])\\d{3}(\\d|[xX])$")
    }
    
    /// 手机号
    public var isPhoneNumber: Bool {
        vaildRegex("^1(3|4|5|6|7|8|9)\\d{9}$")
    }
    
    /// 正则校验
    ///
    /// - Parameters:
    ///   - regex: 正则表达式
    /// - Returns: 校验结果
    public func vaildRegex(_ regex: String) -> Bool {
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
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: space)]
        )
        
        // 标题属性文本
        let titleAttr = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
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
    open var nameSpace: String {
        infoDictionary?["CFBundleExecutable"] as? String ?? ""
    }
    
    /// 当前版本
    open var currentVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

}

#endif
