
//
//  Data+time.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/7.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation

extension NSData {
    
    /*
     获取当前时间
     */
    class func getCurrentTime()->String {
        //获取当前时间
        let now = Date()
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print("当前日期时间：\(dformatter.string(from: now))")
        return dformatter.string(from: now)
    }
    
    /*
     获取当前时间的时间戳
     */
    class func getCurrentTimeStamp()->String {
        //获取当前时间
        let now = Date()
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return String(timeStamp)
    }
    
    /*
     :param: stringTime 时间为stirng
     :returns: 返回时间戳为stirng
     */
    class func stringToTimeStamp(stringTime:String,second:Bool)->String {
        let dfmatter = DateFormatter()
        if second {
            dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            dfmatter.dateFormat = "yyyy-MM-dd"
        }
        let date = dfmatter.date(from: stringTime)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
    }
    
    /**
     时间戳转时间
     :param: timeStamp
     :returns: return time
     */
    class func timeStampToString(timeStamp:String,second:Bool)->String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        if second {
            dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            dfmatter.dateFormat = "yyyy-MM-dd"
        }
        let date = NSDate(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date as Date)
    }
    
   /*
     获取年月日
     */
    
    class func getTimes() -> [Int] {
        
        var timers: [Int] = [] //  返回的数组
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        
        timers.append(comps.year!)  // 年
        timers.append(comps.month!)            // 月
        timers.append(comps.day!)                // 日
        timers.append(comps.hour!)               // 小时
        timers.append(comps.minute!)            // 分钟
        timers.append(comps.second!)            // 秒
        timers.append(comps.weekday! - 1)      //星期
        
        return timers
    }
    
    
    
}
