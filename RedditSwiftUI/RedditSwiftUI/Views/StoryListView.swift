//
//  ContentView.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import Foundation
import SwiftUI

struct StoryListView: View {
    //@StateObject
    @State private var storyVM:StoryViewModel = StoryViewModel(NetworkManager())
    
    
    //var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            StoryCellView().environmentObject(storyVM)

        }
    }
//    private func startTimer(){
//        self.downloadAmount = 0.0
//        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//    }
//    private func stopTimer(){
//        self.timer.upstream.connect().cancel()
//    }
    
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
