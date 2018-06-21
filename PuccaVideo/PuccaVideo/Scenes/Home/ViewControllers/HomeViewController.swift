//
//  HomeViewController.swift
//  PuccaVideo

//  Copyright © 2018 Isabela Karen Louli. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var keyWordText: UITextField!
    
    private var viewModel = HomeViewModel()
    private let bag = DisposeBag()
    private let homeCellIdentifier = "homeIdentifier"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        keyWordText.delegate = self
        viewModel.searchVideos(by: viewModel.randomWordGenerate())
        setupTableView()
        bind()
    }
    
    // MARK: - TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Bind
    
    private func setupTableView() {
        
        viewModel.videosValues
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: homeCellIdentifier, cellType: HomeTableViewCell.self)) { (row, element, cell) in
                cell.setup(value: element)
                self.viewModel.loadImage(at: row)
            }
            .disposed(by: bag)
        
        tableView.rx.prefetchRows
            .subscribe(onNext: { indexes in
                for index in indexes {
                    self.viewModel.loadImage(at: index.row)
                }
            })
            .disposed(by: bag)
    }
    
    private func bind() {
        viewModel.errorMessage
            .asDriver()
            .drive(errorLabel.rx.text)
            .disposed(by: bag)
        
        searchButton.rx.tap
            .throttle(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let `self` = self,
                      let text = self.keyWordText.text
                      else { return }
                self.viewModel.searchVideos(by: text)
            })
            .disposed(by: bag)
    }

}
