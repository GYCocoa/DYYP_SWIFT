//
//  Bundle+GYString.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/10/30.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import Foundation


/*
 + (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value
 {
 static NSBundle *bundle = nil;
 if (bundle == nil) {
 // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
 NSString *language = [NSLocale preferredLanguages].firstObject;
 if ([language hasPrefix:@"en"]) {
 language = @"en";
 } else if ([language hasPrefix:@"zh"]) {
 if ([language rangeOfString:@"Hans"].location != NSNotFound) {
 language = @"zh-Hans"; // 简体中文
 } else { // zh-Hant\zh-HK\zh-TW
 language = @"zh-Hant"; // 繁體中文
 }
 } else {
 language = @"en";
 }
 
 // 从MJRefresh.bundle中查找资源
 bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
 }
 value = [bundle localizedStringForKey:key value:value table:nil];
 return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
 }
 */
extension Bundle {
    
    class func localizedStringForKey(key:String)->(String) {
        var language = NSString(string:NSLocale.preferredLanguages.first!)
        if (language.hasPrefix("en")) {
            language = "en"
        }else if (language.hasPrefix("zh")) {
            let range = language.range(of: "Hans" as String)
            if range.location != NSNotFound {
                language = "zh-Hans" // 简体中文
            }else{
                language = "zh-Hant" // 繁體中文
            }
        } else {
            language = "en";
        }        
        
        return Bundle.mj_localizedString(forKey: key)
    }
    
    
    
}
