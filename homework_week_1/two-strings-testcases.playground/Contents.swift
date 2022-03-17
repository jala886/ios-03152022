import Foundation

func twoStringsTest(_ raw:String)->[String]{
    let ar = raw.filter{$0 != " "}.split(separator: "\n")
    //ar.dropFirst()
    var res=[Bool]()
    for position in stride(from: 1, to: ar.count, by: 2){
        //print(ar[position])
        res.append(ar[position].map{x in
            ar[position+1].contains(x)
        }.reduce(false,{$0 || $1}))
    }
    return res.map{$0 ? "YES" : "NO"}
}
print(twoStringsTest("""
                       2
                       hello
                       world
                       hi
                       world
"""))
print(twoStringsTest("""
                       4
                       wouldyoulikefries
                       abcabcabcabcabcabc
                       hackerrankcommunity
                       cdecdecdecde
                       jackandjill
                       wentupthehill
                       writetoyourparents
                       fghmqzldbc

"""))
print(twoStringsTest("""
                        2
                        aardvark
                        apple
                        beetroot
                        sandals
"""))



