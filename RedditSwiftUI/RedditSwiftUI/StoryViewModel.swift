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
    private var afterKey:String?
    
    private let networkManager:NetworkManager
    
    init(_ networkManager:NetworkManager){
        self.networkManager = networkManager
    }
    
    @MainActor
    func loadStory()async throws{
        isLoading = true
        let data = try await networkManager.downloadStoryModel(RedditRespond.self, url: DownloadURLs.startUrl.string)
        self.story += data.data.children.map{$0.data}
        //sleep(3)
        isLoading = false
    }
    
    @MainActor
    func loadMoreStory()async throws{
        isLoading = true
        let data = try await networkManager.downloadStoryModel(RedditRespond.self, url: DownloadURLs.nextURL(afterKey ?? "").string)
        self.story += data.data.children.map{$0.data}
        self.afterKey = data.data.after
        //sleep(3)
        isLoading = false
    }
    
    func refresh(){
        self.story = []
        Task{
            try await loadStory()
        }
    }
}
