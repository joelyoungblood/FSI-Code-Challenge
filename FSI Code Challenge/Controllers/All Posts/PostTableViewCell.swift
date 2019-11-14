//
//  PostTableViewCell.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import SnapKit

final class PostTableViewCell: UITableViewCell, ReusableView {
    
    private struct Constants {
        static let verticalOffset: CGFloat = 10
        static let trailingOffset: CGFloat = 35
        static let leadingOffset: CGFloat = 20
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .timesNewRoman(ofSize: 17)
        label.textColor = .fsiGrey
        label.numberOfLines = 0
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
        accessoryType = .disclosureIndicator
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalOffset)
            make.leading.equalToSuperview().offset(Constants.leadingOffset)
            make.bottom.equalToSuperview().offset(-Constants.verticalOffset)
            make.trailing.lessThanOrEqualToSuperview().inset(Constants.trailingOffset)
        }
    }
    
    func configure(for post: Post) {
        titleLabel.text = post.title.capitalized
    }
}
