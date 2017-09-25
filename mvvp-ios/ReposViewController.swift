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
  
  let viewModel = ReposViewModel()
  var repos: [Repo] = []
  var disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    
    setupDataBinding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // Setup data binding
  private func setupDataBinding() {
    viewModel.requestCount
      .asObservable()
      .map{"Data load time: \($0)"}
      .bind(to: requestCountLabel.rx.text)
      .addDisposableTo(disposeBag)
    
    refreshButton.rx.tap.asObservable()
      .subscribe(onNext: {
        // Clear data
        self.repos.removeAll()
        self.tableView.reloadData()

        // Load data from remote source
        self.viewModel.loadTrendingRepos(online: true)
      })
      .disposed(by: disposeBag)
    
    viewModel.repos
      .asObservable()
      .subscribe(onNext: {
        self.repos = $0
        self.tableView.reloadData()
      })
      .disposed(by: disposeBag)
  }
}


extension ReposViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "repoViewCell")
    
    cell.textLabel?.text = repos[indexPath.row].name
    return cell
  }
}
