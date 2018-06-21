//
//  SearchServices.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift

protocol SearchServiceProtocol {
    func getVideos(by keyWord: String) -> Observable<(SearchResponse?)>
}

class SearchService: SearchServiceProtocol {
    
    // MARK: - Properties
    public let kEndpoint = "search"
    private let apiKey = Environment.shared.apiKey
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
        let path = "?part=snippet&maxResults=20&q=\(keyWord)&type=video&key=\(apiKey)"
        return dispatcher.response(of: SearchResponse.self, from: path, method: .get)
    }
}
