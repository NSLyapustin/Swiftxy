//
//  TemplateListTableViewCell.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.02.2023.
//

import UIKit

final class TemplateListTableViewCell: UITableViewCell {

    // MARK: Nested types

    struct DisplayData {
        let name: String
        let template: String
    }

    // MARK: Internal properties

    static let reuseIdentifier = "TemplateListTableViewCell"

    // MARK: Private properties

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private let templateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with displayData: DisplayData) {
        nameLabel.text = "name: \(displayData.name)"
        templateLabel.text = "template: \(displayData.template)"
    }

    // MARK: Private methods

    private func setupViews() {
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -8)
        ])

        self.addSubview(templateLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: templateLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: templateLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: templateLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: templateLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -8)
        ])
    }
}
