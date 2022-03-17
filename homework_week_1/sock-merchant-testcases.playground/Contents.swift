import Foundation

func sockMerchantTest(_ raw:String)->Int{
    let ar = raw.split(separator: " ")
    let dt = Dictionary(grouping: ar, by:{$0})
    //print(dt)
    var count = 0
    for (_,v) in dt{
        count += v.count/2
    }
    return  count
}
print(sockMerchantTest("10 20 20 10 10 30 50 10 20"))
print(sockMerchantTest("1 1 3 1 2 1 3 3 3 3 "))
