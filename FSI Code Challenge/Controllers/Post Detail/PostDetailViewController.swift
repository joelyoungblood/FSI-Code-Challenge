//
//  PostDetailViewController.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import SnapKit

final class PostDetailViewController: UIViewController {
    
    private enum PostDetailSections: Int, CaseIterable {
        case title
        case details
        case body
    }
    
    private let post: Post
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = false
        tableView.register(PostDetailTitleTableViewCell.self)
        tableView.register(PostDetailDetailTableViewCell.self)
        tableView.register(PostDetailBodyTableViewCell.self)
        return tableView
    }()
    
    init(with post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension PostDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostDetailSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = PostDetailSections(rawValue: indexPath.row)!
        switch section {
        case .title:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostDetailTitleTableViewCell
            cell.configure(with: post.title)
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostDetailDetailTableViewCell
            cell.configure(for: post)
            return cell
        case .body:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostDetailBodyTableViewCell
            cell.configure(for: post)
            return cell
        }
    }
}
