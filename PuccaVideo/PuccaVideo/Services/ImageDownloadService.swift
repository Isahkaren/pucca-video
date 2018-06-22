//
//  ImageDownloadService.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import RxSwift

protocol ImageDownloadServiceProtocol {
    func image(for urlString: String) -> Observable<UIImage?>
}

class ImageDownloadService: ImageDownloadServiceProtocol {

    func image(for urlString: String) -> Observable<UIImage?> {
        let url = URL(string: urlString)
        let request = URLRequest(url:url!)
        return URLSession.shared.rx
            .response(request: request)
            .map { UIImage(data: $1) }
    }
}



