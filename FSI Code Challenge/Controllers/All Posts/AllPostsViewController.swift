//
//  ViewController.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import NSObject_Rx

final class AllPostsViewController: UIViewController, Alertable {

    private let viewModel = AllPostsViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(PostTableViewCell.self)
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "All Posts"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.addSubview(refreshControl)
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<AllPostsSectionData>(configureCell: { _, tableView, indexPath, post -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostTableViewCell
            cell.configure(for: post)
            return cell
        })
        
        viewModel.allPosts
            .map { [AllPostsSectionData(items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(Post.self).subscribe(onNext: { [weak self] post in
            self?.navigationController?.pushViewController(PostDetailViewController(with: post), animated: true)
        }).disposed(by: rx.disposeBag)
        
        viewModel.isLoading
            .subscribeOn(MainScheduler.instance).subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.refreshControl.beginRefreshing()
                } else {
                    self?.refreshControl.endRefreshing()
                }
            }).disposed(by: rx.disposeBag)
        
        refreshControl.rx
            .controlEvent(.valueChanged).subscribe(onNext: { [weak self] _ in
                self?.viewModel.fetchAllPosts()
            }).disposed(by: rx.disposeBag)
        
        viewModel.error
            .subscribeOn(MainScheduler.instance).subscribe(onNext: { [weak self] error in
                self?.showAlert(for: error)
            }).disposed(by: rx.disposeBag)
        
        viewModel.fetchAllPosts()
    }
}
