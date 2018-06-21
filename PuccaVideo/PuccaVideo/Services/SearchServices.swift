//
//  SearchServices.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift

protocol YouTubeServicesProtocol {
    func getVideos(by keyWord: String) -> Observable<(SearchResponse?)>
}

class SearchServices: YouTubeServicesProtocol {
    
    // MARK: - Properties
    public let kEndpoint = "search"
    public let kApiKey = "AIzaSyCwbGziupadfpxuaTv72BsKZxOAQQDDj9A"
    private(set) var dispatcher: NetworkDispatcherProtocol
    
    // MARK: - Lifecycle
    
    init() {
        let url = Environment.shared.baseUrl.appendingPathComponent(kEndpoint)
        dispatcher = NetworkDispatcher(url: url)
    }
    
    init(dispatcher: NetworkDispatcherProtocol) {
        self.dispatcher = dispatcher
    }
    
    // MARK: - Services

    func getVideos(by keyWord: String) -> Observable<(SearchResponse?)> {
        let path = "?part=snippet&maxResults=20&q=\(keyWord)&key=\(kApiKey)"
        return dispatcher.response(of: SearchResponse.self, from: path, method: .get)
    }
}
