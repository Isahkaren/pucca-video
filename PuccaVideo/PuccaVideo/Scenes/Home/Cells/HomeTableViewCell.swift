//
//  HomeTableViewCell.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import UIKit
import RxSwift

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let bag = DisposeBag()
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helpers
    
    public func setup(value: Item) {
        videoTitleLabel.text = value.snippet.title
        
        value.snippet.thumbnails.medium.image
            .asDriver()
            .drive(thumbnailImage.rx.image)
            .disposed(by: bag)
    }
}
