//
//  TemplatesListViewController.swift
//  Swiftxy
//
//  Created by n.lyapustin on 26.02.2023.
//

import UIKit

class TemplatesListViewController: UIViewController {

    // MARK: Private properties

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let templatesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Templates"
        return label
    }()

    private var breakpoints: [TemplateListTableViewCell.DisplayData] = []

    // MARK: Internal properties

    private let output: TemplatesListViewOutput

    // MARK: Lifecycle

    init(output: TemplatesListViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        tableView.delegate = self
        tableView.dataSource = self
        output.viewDidLoad()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16),
        ])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        templatesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(templatesLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: templatesLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: templatesLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: templatesLabel, attribute: .centerY, relatedBy: .equal, toItem: closeButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])

        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: addButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: addButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16),
        ])
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: closeButton, attribute: .bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        tableView.register(TemplateListTableViewCell.self, forCellReuseIdentifier: TemplateListTableViewCell.reuseIdentifier)
    }

    @objc private func addButtonTapped() { output.addButtonTapped() }
    @objc private func closeButtonTapped() { output.closeButtonTapped() }
}

// MARK: TemplatesListViewInput

extension TemplatesListViewController: TemplatesListViewInput {
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }

    func set(breakpoints: [TemplateListTableViewCell.DisplayData]) {
        self.breakpoints = breakpoints
        tableView.reloadData()
    }

    func close() {
        dismiss(animated: true)
    }
}

// MARK: UITableViewDataSource

extension TemplatesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breakpoints.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TemplateListTableViewCell.reuseIdentifier) as? TemplateListTableViewCell else { return UITableViewCell() }
        cell.configure(with: breakpoints[indexPath.row])
        return cell
    }
}
