//
//  SettingsCell.swift
//  BallTest
//
//  Created by Developer on 9/2/19.
//  Copyright © 2019 AlexanderVetryakov. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

final class SettingsCell: UITableViewCell {

    private var titleLabel = UILabel()
    private var dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupControls()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        clear()
    }

    private func setupControls() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(dateLabel.snp.left).offset(-10)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left

        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.top.equalTo(20)
            make.bottom.equalTo(-2)
            make.width.equalTo(120)
        }
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .right
        dateLabel.textColor = Asset.Colors.grey.color
        dateLabel.font = UIFont(name: dateLabel.font.fontName, size: 12)
    }

    func configure(with answer: PresentableAnswer) {
        titleLabel.text = answer.text
        dateLabel.text = answer.dateRepresentation
    }

    private func clear() {
        titleLabel.text = nil
    }
}

extension SettingsCell: Reusable { }
