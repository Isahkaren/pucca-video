//
//  HomeViewController.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let bag = DisposeBag()
    private var viewModel = HomeViewModel()
    private let homeCellIdentifier = "homeIdentifier"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getVideos(by: "cats")
        setupTableView()
        bind()
    }
    
    // MARK: - Bind
    
    private func setupTableView() {
        
        viewModel.videosValues
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: homeCellIdentifier, cellType: HomeTableViewCell.self)) { (row, element, cell) in
                cell.setup(value: element)
            }
            .disposed(by: bag)
    }
    
    private func bind() {
        viewModel.errorMessage
            .asDriver()
            .drive(errorLabel.rx.text)
            .disposed(by: bag)
        
        searchButton.rx.tap
            .throttle(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in self?.viewModel.getVideos(by: "ios") })
            .disposed(by: bag)
    }

}
