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
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private var viewModel = HomeViewModel()
    private let historyCellIdentifier = "homeIdentifier"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
