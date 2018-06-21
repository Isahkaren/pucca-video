//
//  HomeTableViewCell.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import UIKit


class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helpers
    
    public func setup(value: Item) {
        videoTitleLabel.text = value.snippet.title

    }

}
