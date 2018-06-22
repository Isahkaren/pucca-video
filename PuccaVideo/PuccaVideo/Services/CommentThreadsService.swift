//
//  CommentThreadsService.swift
//  PuccaVideo
//
//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift

protocol CommentThreadsServiceProtocol {
    func getComments(by videoID: String) -> Observable<(CommentsResponse?)>
}

class CommentThreadsService: CommentThreadsServiceProtocol {
    
    // MARK: - Properties
    public let kEndpoint = "commentThreads"
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
    
    func getComments(by videoID: String) -> Observable<(CommentsResponse?)> {
        let path = "?part=snippet&videoId=\(videoID)&key=\(apiKey)"
        return dispatcher.response(of: CommentsResponse.self, from: path, method: .get)
    }
}
