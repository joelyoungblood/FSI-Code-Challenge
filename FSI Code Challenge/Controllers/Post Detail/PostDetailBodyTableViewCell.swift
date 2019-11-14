//
//  PostDetailBodyTableViewCell.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit

final class PostDetailBodyTableViewCell: UITableViewCell, ReusableView {
    
    private struct Constants {
        static let topOffset: CGFloat = 30
        static let leadingTrailingOffset: CGFloat = 15
    }
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        
        contentView.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.topOffset)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.leadingTrailingOffset)
            make.trailing.equalToSuperview().inset(Constants.leadingTrailingOffset)
        }
    }
    
    func configure(for post: Post) {
        bodyLabel.text = post.body
    }
}
