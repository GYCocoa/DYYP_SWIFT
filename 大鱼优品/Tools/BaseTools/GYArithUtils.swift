//
//  GYArithUtils.swift
//  大鱼优品
//
//  Created by GY.Z on 2017/11/20.
//  Copyright © 2017年 GYZ. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += ( left: inout CGPoint, right: CGPoint) {
    left = left + right
}

func - (left: CGPoint, right:CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func /= (left:inout CGPoint, right: CGPoint) {
    left = left / right
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (point:inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}

let test1 = CGPoint(x: 100, y: 100)
let test2 = CGPoint(x: 50, y: 50)
let test5: CGFloat = 10.1
let test3 = test1 + test2
let test6 = test1 / test5

func addPlusMethod() {
    print("doubi \(test3) and \(test6)")
}
