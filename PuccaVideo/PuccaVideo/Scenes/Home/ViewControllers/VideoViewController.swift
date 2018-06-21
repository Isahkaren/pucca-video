//
//  VideoViewController.swift
//  PuccaVideo
//
//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
import RxSwift
import RxCocoa

class VideoViewController: UIViewController {
    
    
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var videoView: YouTubePlayerView!
    
    private var viewModel = VideoViewModel()
    private let bag = DisposeBag()
    private let videoCellIdentifier = "videoCellIdentifier"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        videoView.loadVideoID("aEzZLXBH3rU")
        viewModel.getComments(by: "m4Jtj2lCMAA")

    }
    
    // MARK: - Bind
    
    private func setupTableView() {
        
        viewModel.commentsValues
            .asDriver()
            .drive(commentsTableView.rx.items(cellIdentifier: videoCellIdentifier, cellType: VideoTableViewCell.self)) { (row, element, cell) in
                cell.setup(value: element)
            }
            .disposed(by: bag)
    }

}
