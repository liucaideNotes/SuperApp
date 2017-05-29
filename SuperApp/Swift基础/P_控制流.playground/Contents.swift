//: Playground - noun: a place where people can play

import UIKit
import Foundation

// --- for ----------
//区间
for item in 1...10 {
    print(item)//1,2,3,4,5,6,7,8,9,10
}
for item in 1..<10 {
    print(item)//1,2,3,4,5,6,7,8,9
}
//数组
var arr = [12,53,4643,45243,7567,34234,74576,2343,675473,423]
for item in arr {
    print(item)
}
for (i,item) in arr.enumerated() {
    print(i)
    print(item)
}
// --- while ----------
var i = 0
while arr[i] != 675473 {
    //先判断，满足条件执行
    print("arr[i] => \(arr[i])")
    i += 1
}
var j = 0
repeat {
    //先判断，满足条件执行
    print("arr[j] => \(arr[j])")
    j += 1
} while arr[j] != 675473

// --- if ----------
if arr[4] == 12 {
    
}else{
    
}
// --- gurad ----------
//guard arr[4] == 12 else{return}
//print(arr[4])

switch <#value#> {
case <#pattern#>:
    <#code#>
default:
    <#code#>
}



