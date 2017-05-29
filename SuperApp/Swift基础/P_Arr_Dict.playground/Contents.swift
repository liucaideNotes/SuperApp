//: Playground - noun: a place where people can play

import UIKit

//--- 集合 - 数组 -----------
var arr1 = [String]()
var arr2 = [Int]()
var arr3 = [AnyObject]()
var arr4 = ["1","2","3"]
arr1 = ["1","2","3"]
arr2 = [1,2,3]
arr3 = [1 as AnyObject,"2" as AnyObject,3 as AnyObject,4.4 as AnyObject]

arr1.first //第一个元素
arr1.last  //最后一个元素
arr1.contains("9")//是否存在该元素
arr2.contains(3)
arr1.count
let bool1 = arr1 == arr4 //两数组是否相等
//增删改查
arr1 += arr1
arr1.insert("9", at: 4)
arr1.append("10")
arr1.remove(at: 6)
arr1[0] = "123"
let bool2 = arr1 == arr4 //两数组是否相等

for item in arr1 {
    print(item)
}
for (i,item) in arr1.enumerated() {
    if item == "2" {
        print(item)
        break
    }
}

//--- 集合 - 字典 -----------
var dic1 = [String:Any]()
var dic2 = [Int:Int]()
let dic3 = [1:"4",2:"5",3:"6"]
let dic4 = ["2":"相同key值在合并的时候会替换","w":"5","e":dic3] as [String : Any]
dic1 = ["1":"qw","2":45,"3":UIView(),"4":dic3]
dic2 = [1:4,2:5,3:6]
print(dic1)
//遍历
for value in dic1.values {
    if let val = value as? UIView {
        val.frame = CGRect(x: 10, y: 150, width: 250, height: 250)
    }
}
print(dic1)
for key in dic1.keys {
    print(key)
}
for (key,value) in dic1 {
    print("key:\(key) -- value:\(value)")
}
//增删改查
dic1["增加"] = "增加的内容"
print(dic1)
dic1.removeValue(forKey: "4")
print(dic1)
dic1["2"] = 678
print(dic1)
(dic1["3"] as! UIView).frame = CGRect(x: 100, y: 100, width: 200, height: 200)
print(dic1)
dic1["2"] is String
let value = dic1["2"] as? String
if let value = dic1["2"] {
    print("value =>\(value)" )
}else{
    print("value => 没有" )
}
if let value = dic1["2"] as? String {
    print("value =>\(value)" )
}else{
    print("value => 没有" )
}
if let value = dic1["22"] {
    print("value =>\(value)" )
}else{
    print("value => 没有" )
}
if let value = dic1["22"] as? String {
    print("value =>\(value)" )
}else{
    print("value => 没有" )
}
//----重载运算符 实现两个字典合并为一个字典
func += <key, value> ( left: inout Dictionary<key, value>, right: Dictionary<key, value>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
dic1 += dic4
print(dic1)
dic1 = dic4
print(dic1)
dic1.isEmpty
dic1.removeAll()
dic1.isEmpty


let label = UILabel()
label.text = dic1["2"] as? String ?? ""

label.text

