//
//  ContentView.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import SwiftUI

struct StoryListView: View {
    @StateObject private var storyVM:StoryViewModel = StoryViewModel(NetworkManager())
    var body: some View {
        VStack{
            
        List{
            Text("Reddit News")
                .frame(maxWidth:.infinity, alignment:.center)
                .font(Font.title)
                //.background(Color.red)
            ForEach(storyVM.story){ story in
                HStack{
                    if let url = story.thumbnail, url.contains("https"){
                        AsyncImage(url:URL(string: story.thumbnail!)){ phase in
                            if let image = phase.image{
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:100)
                            }else if phase.error != nil{
                                Color.white
                                //Text("\(phase.error?.localizedDescription)")
                            }else{
                                ProgressView()
                            }
                            //                placeholder: {
                            //                        ProgressView()
                            //                    }//.border(.foreground, width: 200)
                        }
                    }
                    //Spacer()
                    Text(story.title ?? "Empty")
                        //.frame(width:200)
                        .multilineTextAlignment(.leading)
                }.frame(height:100)
                    .onAppear{
                        if story.id == storyVM.story.last?.id{
                            print("loadMoreStory")
                            Task{
                                do{
                                    try await storyVM.loadMoreStory()
                                }catch(let e){
                                    print(e.localizedDescription)
                                }
                            }
                        }
                    }
                
            }
            if storyVM.isLoading == true{
                ProgressView().progressViewStyle(LinearProgressViewStyle())
            }
        }.task{
            do{
                try await storyVM.loadStory()
            }catch(let e){
                print(e.localizedDescription)
            }
        }.refreshable{
            print("refresh")
            storyVM.refresh()
        }
    }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
