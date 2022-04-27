//
//  StoryViewModel.swift
//  RedditSwiftUI
//
//  Created by jianli on 4/22/22.
//

import Foundation


class StoryViewModel:ObservableObject{
    @Published private(set) var story:[StoryModel] = [StoryModel]()
    @Published var isLoading = false
    @Published var images = [String:Data]()
    private var afterKey:String?
    
    private let networkManager:NetworkManager
    
    init(_ networkManager:NetworkManager){
        self.networkManager = networkManager
    }
    
    //@MainActor
    func loadStory()async throws{
        isLoading = true
        let data = try await networkManager.downloadStoryModel(RedditRespond.self, url: DownloadURLs.startUrl.string)
        await MainActor.run{
            self.story += data.data.children.map{$0.data}
        }
        //sleep(5)
        isLoading = false
    }
    
    @MainActor
    func loadMoreStory()async throws{
        isLoading = true
        let data = try await networkManager.downloadStoryModel(RedditRespond.self, url: DownloadURLs.nextURL(afterKey ?? "").string)
        self.story += data.data.children.map{$0.data}
        self.afterKey = data.data.after
        //sleep(9)
        isLoading = false
    }
    
    func loadImage() async throws{
        let idurls = self.story.filter{$0.thumbnail?.contains("https") ?? false}.compactMap{($0.id!,$0.thumbnail!)}
        for try await (id,data) in ImageSequence(idurls:idurls){
                images[id] = data
        }
    }
    
    func refresh(){
        self.story = []
        Task{
            try await loadStory()
        }
    }
}
