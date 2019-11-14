//
//  PostDetailDetailTableViewCell.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit

final class PostDetailDetailTableViewCell: UITableViewCell, ReusableView {
    
    private struct Constants {
        static let topOffset: CGFloat = 25
        static let intraItemOffset: CGFloat = 5
        static let trailingBottomOffset: CGFloat = 15
    }
    
    private let userIdHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "User ID"
        label.textColor = .fsiGrey
        label.font = .timesNewRoman(ofSize: 20)
        return label
    }()
    
    private let postIdHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Post ID"
        label.textColor = .fsiGrey
        label.font = .timesNewRoman(ofSize: 20)
        return label
    }()
    
    private let userIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fsiGrey
        label.font = .timesNewRoman(ofSize: 16)
        return label
    }()
    
    private let postIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .fsiGrey
        label.font = .timesNewRoman(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        contentView.addSubview(postIdHeaderLabel)
        postIdHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.topOffset)
            make.leading.equalToSuperview().offset(Constants.trailingBottomOffset)
        }
        
        contentView.addSubview(postIdLabel)
        postIdLabel.snp.makeConstraints { make in
            make.top.equalTo(postIdHeaderLabel.snp.bottom).offset(Constants.intraItemOffset)
            make.bottom.equalToSuperview().offset(-Constants.trailingBottomOffset)
            make.centerX.equalTo(postIdHeaderLabel.snp.centerX)
        }
        
        contentView.addSubview(userIdHeaderLabel)
        userIdHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.topOffset)
            make.trailing.equalToSuperview().inset(Constants.trailingBottomOffset)
        }
        
        contentView.addSubview(userIdLabel)
        userIdLabel.snp.makeConstraints { make in
            make.top.equalTo(userIdHeaderLabel.snp.bottom).offset(Constants.intraItemOffset)
            make.bottom.equalToSuperview().offset(-Constants.trailingBottomOffset)
            make.centerX.equalTo(userIdHeaderLabel.snp.centerX)
        }
    }
    
    func configure(for post: Post) {
        postIdLabel.text = "\(post.id)"
        userIdLabel.text = "\(post.userId)"
    }
}
