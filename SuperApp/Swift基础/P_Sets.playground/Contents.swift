//: Playground - noun: a place where people can play

import UIKit
/*
集合（Sets）
集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。
*/

var sets1 = Set<Character>()
sets1.insert("a")
sets1 = []
//sets1 = ["Rock", "Classical", "Hip hop"] //报错：因为前面已经声明了sets是字符类型的
var sets2: Set<String> = ["qwe","asd","zxc"]//应声明为String类型的集合，否则自检为数组,Set类型不能从数组字面量中被单独推断出来，因此Set类型必须显式声明
var sets3: Set = ["rty","dfg","vbn"]//Set类型不能从数组字面量中被单独推断出来，因此Set类型必须显式声明,但是可以不声明具体类型,具体类型可以自检
sets2.count
sets2.isEmpty

sets3.contains("dfg")//是否包含该值
//增删改查
sets3.insert("poi")//增
sets3.remove("dfg")//删除该值
//这是使用Set的下标，但因为Set是无序的，个人觉得下标基本没多大意义
let indx1 = sets3.index(after: sets3.startIndex)
let indx2 = sets3.index(of: "rty")
let indx3 = sets3.startIndex
let indx4 = sets3.endIndex
sets3//["poi", "vbn", "rty"]
sets3.remove(at: indx2!)
sets3//["poi", "vbn"]

//遍历
for item in sets3 {
    print(item)
}
for (i,item) in sets3.enumerated() {
    print("i => \(i)")
    print("item => \(item)")
}

//排序
for item in sets2.sorted() {
    print("\(item)")
}

//操作
/*
 使用intersect(_:)方法根据两个集合中都包含的值创建的一个新的集合。
 使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
 使用union(_:)方法根据两个集合的值创建一个新的集合。
 使用subtract(_:)方法根据不在该集合中的值创建一个新的集合。
 */
let sets10: Set = [1, 2, 4, 6, 8, 7]
let sets11: Set = [1, 3, 5, 7, 9]
let sets12: Set = [0, 2, 4, 6, 8]
let sets13: Set = [2, 3, 5, 7]
let sets14: Set = [1, 3, 5, 7, 9]
let sets15: Set = [1, 3, 5, 9]

sets11.intersection(sets10)// [7, 1]
sets11.symmetricDifference(sets12)//[8, 2, 4, 5, 7, 6, 3, 1, 0]
sets11.union(sets12) // [8, 2, 9, 4, 5, 7, 6, 3, 1, 0]
sets11.subtracting(sets13)// [9, 1]

/*
 使用“相等”运算符 ( == )来判断两个集合是否包含有相同的值；
 使用 isSubset(of:) 方法来确定一个集合的所有值是被某集合包含；
 使用 isSuperset(of:)方法来确定一个集合是否包含某个集合的所有值；
 使用 isStrictSubset(of:) 或者 isStrictSuperset(of:)方法来确定这个个集合是否为某一个集合的子集或者超集，但并不相等；
 使用 isDisjoint(with:)方法来判断两个集合是否拥有相同的值。
 */
sets11 == sets15 //false
sets11 == sets14 //true
sets14.isSubset(of: sets11)// true
sets11.isSubset(of: sets15)// false  15不包含11
sets15.isSubset(of: sets11)// true
sets15.isSuperset(of: sets11)// false
sets11.isSuperset(of: sets15)// true  11是15的超集
sets11.isSuperset(of: sets14)// true  11是14的超集
sets11.isStrictSubset(of: sets14)//false
sets11.isStrictSubset(of: sets15)//false
sets15.isStrictSubset(of: sets11)//true  15是11的子集
sets11.isStrictSuperset(of: sets14)//false  11是14的超集但是11和14相等
sets11.isStrictSuperset(of: sets15)//true 11是15的超集
sets15.isStrictSuperset(of: sets11)//false
sets11.isDisjoint(with: sets12)// true  11和12没有相同的值
sets11.isDisjoint(with: sets13)// false
sets11.isDisjoint(with: sets14)// false
sets11.isDisjoint(with: sets15)// false
sets15.isDisjoint(with: sets11)// false





