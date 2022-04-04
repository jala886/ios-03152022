//
//  ContentView.swift
//  test1
//
//  Created by jianli on 3/30/22.
//

import SwiftUI

struct ContentView: View {
    @State var inText:String = ""
    let ltStr = ["hello", "world","heap","help"]
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
        
        List{
            TextField("input", text: $inText)
            ForEach(ltStr.filter{$0.starts(with:inText.lowercased())},id:\.self){ name in
                Text(name)
            }
        }
        Text("Hello, world!")
            .padding()
        }.padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
