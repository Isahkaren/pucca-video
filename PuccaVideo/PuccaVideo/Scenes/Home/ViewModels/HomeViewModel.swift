//
//  HomeViewModel.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewModel {
    
    // MARK: - Properties
    
    private let bag = DisposeBag()
    
    private(set) var videosValues = BehaviorRelay<[Item]>(value: [Item]())
    private(set) var errorMessage = BehaviorRelay<String?>(value: nil)
    private(set) var searchService: SearchServiceProtocol
    
    // MARK: - Lifecycle
    
    public init(searchService: SearchServiceProtocol = SearchService()) {
        self.searchService = searchService
    }
    
    // MARK: - Network Requests
    
    func searchVideos(by keyWord: String) {
        let response = searchService.getVideos(by: keyWord)
        
        response.subscribe(onNext: { [weak self] (response) in
            guard let `self` = self,
                let response = response
            else { return }
            self.videosValues.accept(response.items)
        }, onError: { [weak self] error in
            guard let `self` = self,
                  let message = (error as? NetworkError)?.message
                  else { return }
            
            self.errorMessage.accept(message)
        })
        .disposed(by: bag)
    }
    
    // MARK: - Helpers
    
    func item(at index: Int) -> Item {
        return videosValues.value[index]
    }
    
    func loadImage(at index: Int) {
        videosValues.value[index].snippet.thumbnails.medium.loadImage()
    }
    
    /**
     word random to start the application with videos on home
     */
    func randomWordGenerate() -> String {
        let words = ["cats", "ios", "marvel", "heroes", "brazil", "game","pucca"]
        let randomIndex = Int(arc4random_uniform(UInt32(words.count)))
        return words[randomIndex]
    }
}
