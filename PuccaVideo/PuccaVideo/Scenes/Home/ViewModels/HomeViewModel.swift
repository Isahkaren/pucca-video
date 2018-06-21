//
//  HomeViewModel.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift

class HomeViewModel {
    
    // MARK: - Properties
    
    private let bag = DisposeBag()
    
    private(set) var videosValues = Variable<[Item]>([Item]())
    private(set) var errorMessage = Variable<String?>(nil)
    private(set) var ytService: YouTubeServicesProtocol
    
    // MARK: - Lifecycle
    
    public init(ytService: YouTubeServicesProtocol = SearchServices()) {
        self.ytService = ytService
    }
    
    // MARK: - Network Requests
    
    func getVideos(by keyWord: String) {
        let response = ytService.getVideos(by: keyWord)
        
        response.subscribe(onNext: { [weak self] (response) in
            guard let `self` = self else { return }
            self.videosValues.value = (response?.items)!
        }, onError: { [weak self] error in
                guard let `self` = self else { return }
                self.errorMessage.value = (error as? NetworkError)?.message
        })
        .disposed(by: bag)
    }
    
    // MARK: - Helpers


}
