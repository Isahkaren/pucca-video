//
//  VideoTableViewCell.swift
//  PuccaVideo
//
//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    // MARK: - Helpers
    
    public func setup(value: CommentsItem) {
      authorNameLabel.text = value.snippet.topLevelComment.snippet.authorDisplayName
      commentLabel.text = value.snippet.topLevelComment.snippet.textDisplay
    }

}
