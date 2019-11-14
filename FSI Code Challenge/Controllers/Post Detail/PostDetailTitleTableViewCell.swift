//
//  PostDetailTitleTableViewCell.swift
//  FSI Code Challenge
//
//  Created by Joel Youngblood on 11/13/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit
import SnapKit

final class PostDetailTitleTableViewCell: UITableViewCell, ReusableView {
    
    private struct Constants {
        static let offset: CGFloat = 10
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .timesNewRoman(ofSize: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .fsiGrey
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
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.offset)
            make.bottom.equalToSuperview().offset(-Constants.offset)
            make.leading.equalToSuperview().offset(Constants.offset)
            make.trailing.equalToSuperview().inset(Constants.offset)
        }
    }
    
    func configure(with title: String) {
        titleLabel.text = title.capitalized
    }
}
