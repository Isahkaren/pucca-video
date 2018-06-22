//
//  VideoViewModel.swift
//  PuccaVideo
//
//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift
import RxCocoa

class VideoViewModel: NSObject {

    // MARK: - Properties
    
    private let bag = DisposeBag()
    
    private(set) var errorMessage = BehaviorRelay<String?>(value: nil)
    private(set) var commentsValues = BehaviorRelay<[CommentsItem]>(value: [CommentsItem]())
    private(set) var commentThreadsService: CommentThreadsServiceProtocol
    
    // MARK: - Lifecycle
    
    public init(commentThreadsService: CommentThreadsServiceProtocol = CommentThreadsService()) {
        self.commentThreadsService = commentThreadsService
    }
    
    // MARK: - Network Requests
    
    func getComments(by videoID: String) {
        let response = commentThreadsService.getComments(by: videoID)
        
        response.subscribe(onNext: { [weak self] (response) in
            guard let `self` = self,
                let response = response
            else { return }
            self.commentsValues.accept(response.items)
        }, onError: { [weak self] error in
            guard let `self` = self,
                  let message = (error as? NetworkError)?.message
                  else { return }
            
            self.errorMessage.accept(message)
        })
        .disposed(by: bag)
    }
    
}
