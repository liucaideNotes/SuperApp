//: Playground - noun: a place where people can play

import UIKit
//----------------- 字符串/字符 的定义 -----------------
//字符串变量
var str1 = "hello"
//字符串常量
let str2 = "swift3.0"
//声明为nil，
var str3:String?
//空字符串
let str4 = String()
//空字符串 提倡用这样的字面量声明,类型可不指定，swift自动识别
let str5 = ""
//字符
var char1:Character = "m"

//----------------- 字符串/字符 的拼接 -----------------
var p_str1 = str1+str2
p_str1 = String(format:"%@~%@",str1,str2)
p_str1 = String(format:"%@~%@-%d",str1,str2,456)
//这种拼接方式方便地组合多种类型
p_str1 = "\(str1)\(str2)\(456)"
p_str1 = "\(str1)\(str2)\(char1)"
//在后面添加
p_str1.append(char1)
p_str1 += str2
//与数组的组合
var strArray = ["hello", "swift", "3.0"]
p_str1 = strArray.joined(separator: "-")//数组通过指定字符拼接
strArray = p_str1.components(separatedBy: "-")//拆分为数组
//枚举字符
for ch in p_str1.characters{
    print(ch)
    switch ch {
    case "0":
        print("有")
    default:
        break
    }
}
//--- 获取字符串中指定索引处的字符 -----------
//字符串长度
p_str1.characters.count
//首字母
char1 = p_str1[p_str1.startIndex]
//末字母
char1 = p_str1[p_str1.index(before: p_str1.endIndex)]
//第二个字母
char1 = p_str1[p_str1.index(after: p_str1.startIndex)]
//索引4的字母
char1 = p_str1[p_str1.index(p_str1.startIndex, offsetBy: 4)]

//--- 获取字符串子串 -----------
let i = p_str1.index(p_str1.startIndex, offsetBy: 4)
let j = p_str1.index(p_str1.startIndex, offsetBy: 8)
var subStr = p_str1.substring(to: i)
subStr = p_str1.substring(from: i)
subStr = p_str1.substring(with: i..<j)
//通过扩展来简化一下
extension String {
    subscript (range: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return self[Range(startIndex..<endIndex)]
        }
        
        set {
            let startIndex = self.index(self.startIndex, offsetBy: range.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            let strRange = Range(startIndex..<endIndex)
            self.replaceSubrange(strRange, with: newValue)
        }
    }
}
subStr = p_str1[0..<14]
//通过指定字符串截取子串
let range1 = p_str1.range(of: "o-")
let range2 = p_str1.range(of: ".")
subStr = p_str1.substring(from: (range1?.upperBound)!)
subStr = p_str1.substring(with: (range1?.upperBound)!..<(range2?.lowerBound)!)
//插入、删除指定字符串
subStr.insert("!", at: subStr.startIndex)
subStr.insert("!", at: subStr.endIndex)
subStr.insert(contentsOf:"YY".characters, at: subStr.index(after: subStr.startIndex))
subStr.insert(contentsOf:"MM".characters, at: subStr.index(before: subStr.endIndex))
let x = p_str1.index(p_str1.startIndex, offsetBy: 4)
subStr.remove(at: x)
subStr
subStr.remove(at: subStr.startIndex)
subStr
subStr.remove(at: subStr.index(after: subStr.startIndex))
subStr
subStr.remove(at: subStr.index(before: subStr.endIndex))
subStr
let ran1 = subStr.index(subStr.endIndex, offsetBy: -3)..<subStr.endIndex
subStr.removeSubrange(ran1)
subStr
let ran2 = subStr.index(subStr.startIndex, offsetBy: 4)..<subStr.endIndex
subStr.removeSubrange(ran2)
subStr
subStr = "http://baidu.com"
let ran3 = subStr.range(of: ":")
let ran4 = subStr.range(of: ".")
subStr.removeSubrange((ran3?.upperBound)!..<(ran4?.lowerBound)!)
subStr
//替换
subStr.replaceSubrange(ran3!, with: "wert")
//是否有前、后缀
p_str1.hasPrefix("3.0")
p_str1.hasSuffix("3.0")
//是否为空
p_str1.isEmpty
str3?.isEmpty
str4.isEmpty
str5.isEmpty

//--- 大小写转换 -----------
subStr = "ashdfasdjf"
subStr.capitalized
subStr.uppercased()
subStr.lowercased()

//--- 字符串比较 -----------
subStr = "2.6.2"
p_str1 = "2.6.1"
str1 = "2.7"
str3 = "2.7.0"
subStr > p_str1
subStr > str1
str1 == str3
str1 > str3!
str1 < str3!
//--- 字符串转换 -----------
Int(str1)
Double(str1)
Double(str3!)
Bool(str1)
str1 = "true"
Bool(str1)