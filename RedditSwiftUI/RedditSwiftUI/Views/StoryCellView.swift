//
//  StoryCellView.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import SwiftUI

struct StoryCellView: View {
    @EnvironmentObject var storyVM:StoryViewModel
    @State var downloadAmount = 0.0
    
    var body: some View {
        List{
            Text("Reddit News")
                .frame(maxWidth:.infinity, alignment:.center)
                .font(Font.title)
                //.background(Color.red)
            ForEach(storyVM.story){ story in
                HStack{
//                    if let url = story.thumbnail, url.contains("https"){
//                        AsyncImage(url:URL(string: story.thumbnail!)){ phase in
//                            if let image = phase.image{
//                                image.resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width:100)
//                            }else if phase.error != nil{
//                                Color.white
//                                //Text("\(phase.error?.localizedDescription)")
//                            }else{
//                                ProgressView()
//                            }
//                            //                placeholder: {
//                            //                        ProgressView()
//                            //                    }//.border(.foreground, width: 200)
//                        }
//                    }
//                    //Spacer()
                    if let data = self.storyVM.images[story.id!]{
                        Image(uiImage: UIImage(data: data)!)
                            .resizable()
                            .aspectRatio(contentMode:ContentMode.fit)
                            .frame(width: 200, height: 200)
                    }
                    
                    Spacer().frame(width: 10)
                    Text(story.title ?? "Empty")
                        //.frame(width:200)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    Spacer()
                    
                }//.frame(height:200)
                    .onAppear{
                        if story.id == storyVM.story.last?.id{
                            
                            //startTimer()
                            Task{
                                do{
                                    try await storyVM.loadMoreStory()
                                }catch(let e){
                                    print(e.localizedDescription)
                                }
                            }
                            print("loadMoreStory")
                            //stopTimer()
                        }
                        
                    }
                    //.background(Color.blue)
//                    .cornerRadius(10)
//                    .padding(.vertical,10)
                    
                
            }.environmentObject(storyVM)
                .background(Color.white)
                //.foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.vertical,10)
                .listRowSeparator(.hidden)
                .background(Color(UIColor.systemGray6))
                
            .listRowInsets(EdgeInsets())
            if storyVM.isLoading{
                //ProgressView("Downloading…", value: downloadAmount, total: 100)
                ProgressView().progressViewStyle(LinearProgressViewStyle())
            
                
            }
        }
        .background(Color.clear)
        //.task{
        .onAppear{
            Task{
                
                do{
                    try await storyVM.loadStory()
                    try await storyVM.loadImage()
                }catch(let e){
                    print(e.localizedDescription)
                }
                print("load story finished")
            }
            
            
            Task{
                for _ in 0...100{
                    //sleep(1)
                    self.downloadAmount += 40
                    if self.downloadAmount > 100{
                        break
                    }
                }
            }
            print("stuck in load story!")
        }
        .refreshable{
            print("refresh")
            storyVM.refresh()
        }
    }
}

struct StoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        StoryCellView().environmentObject(StoryViewModel(NetworkManager()))
    }
}
