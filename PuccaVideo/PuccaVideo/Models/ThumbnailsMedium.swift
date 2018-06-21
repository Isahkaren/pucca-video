//
//  ThumbnailsMedium.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

struct ThumbnailsMedium: Codable {
    let url: String
    private enum CodingKeys: String, CodingKey {
        case url
    }
    
    private let bag = DisposeBag()
    var image = BehaviorRelay<UIImage?>(value: nil)
    
    func loadImage(service: ImageDownloadServiceProtocol = ImageDownloadService()) {
        // if image is not nil, then it was downloaded
        guard image.value == nil else { return }
        
        let response = service.image(for: url)
        response.subscribe(onNext: { (img) in
                self.image.accept(img)
            }, onError: { _ in
                self.image.accept(UIImage(named: ""))
            })
            .disposed(by: bag)
    }
}

