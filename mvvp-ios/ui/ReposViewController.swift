//
//  ViewController.swift
//  mvvp-ios
//
//  Created by Quang Nguyen on 9/20/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ReposViewController: UIViewController {
  @IBOutlet weak var requestCountLabel: UILabel!
  @IBOutlet weak var refreshButton: UIBarButtonItem!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let viewModel = ReposViewModel()
  var repos: [Repo] = []
  var disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDataBinding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // Setups data binding
  private func setupDataBinding() {
    // Request count label
    viewModel.requestCount
      .asObservable()
      .map{"Data load time: \($0)"}
      .bind(to: requestCountLabel.rx.text)
      .addDisposableTo(disposeBag)
    
    // Handle refresh button's click
    refreshButton.rx.tap.asObservable()
      .subscribe(onNext: {
        // Clear data
        self.repos.removeAll()
        self.tableView.reloadData()
        
        // Load data from remote source
        self.viewModel.loadTrendingRepos(online: true)
      })
      .disposed(by: disposeBag)
    
    // Bind data to table view
    viewModel.repos.asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: "repoViewCell"))(setupCell)
      .addDisposableTo(disposeBag)
    
    // Handle search bar
    searchBar.rx.text.asObservable()
      .filter{$0 != nil}
      .subscribe(onNext: {
        text in
          self.viewModel.filter(text: text!)
      }).disposed(by: disposeBag)
  }
  
  func setupCell(row: Int, element: Repo, cell: UITableViewCell){
    cell.textLabel?.text = element.name
  }
}
