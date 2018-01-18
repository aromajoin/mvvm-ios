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
  
  // Setups data binding
  private func setupDataBinding() {
    // Bind request count label
    bindCountLabel()
    
    // Handle refresh button's click
    bindRefreshButton()
    
    // Bind data to table view
    bindTableView()
    
    // Handle search bar
    bindSearchBar()
  }
  
  private func bindCountLabel() {
    viewModel.requestCount
      .asObservable()
      .map{"Data load time: \($0)"}
      .bind(to: requestCountLabel.rx.text)
      .addDisposableTo(disposeBag)
  }
  
  private func bindRefreshButton() {
    refreshButton.rx.tap.asObservable()
      .subscribe(onNext: {
        // Clear data
        self.repos.removeAll()
        self.tableView.reloadData()
        
        // Load data from remote source
        self.viewModel.loadTrendingRepos(online: true)
      })
      .disposed(by: disposeBag)
  }
  
  private func bindTableView() {
    viewModel.repos.asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: "repoViewCell"))(setupCell)
      .addDisposableTo(disposeBag)
  }
  
  private func bindSearchBar() {
    searchBar.rx.text.asObservable()
      .filter{$0 != nil}
      .subscribe(onNext: {
        text in
        self.viewModel.filter(text: text!)
      }).disposed(by: disposeBag)
  }
  
  private func setupCell(row: Int, element: Repo, cell: UITableViewCell){
    cell.textLabel?.text = element.name
  }
}
