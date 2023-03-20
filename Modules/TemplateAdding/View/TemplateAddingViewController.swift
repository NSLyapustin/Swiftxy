//
//  TemplateAddingViewController.swift
//  Swiftxy
//
//  Created by n.lyapustin on 27.02.2023.
//

import UIKit

final class TemplateAddingViewController: UIViewController {

    // MARK: Private properties

    private let output: TemplateAddingViewOutput

    private let nameTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Name"
        return textField
    }()

    private let templateTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.contentVerticalAlignment = .top
        textField.placeholder = "Template"
        return textField
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let addLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Add template"
        return label
    }()

    // MARK: Lifecycle

    init(output: TemplateAddingViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: Private methods

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16),
        ])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        addLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: addLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: addLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: addLabel, attribute: .centerY, relatedBy: .equal, toItem: closeButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])

        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: saveButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: saveButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16),
        ])
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameTextField, attribute: .top, relatedBy: .equal, toItem: addLabel, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: nameTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: nameTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -16)
        ])

        view.addSubview(templateTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: templateTextField, attribute: .leading, relatedBy: .equal, toItem: nameTextField, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: templateTextField, attribute: .trailing, relatedBy: .equal, toItem: nameTextField, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: templateTextField, attribute: .top, relatedBy: .equal, toItem: nameTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: templateTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
        ])
    }

    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text,
              let template = templateTextField.text,
              !name.isEmpty, !template.isEmpty
        else {
            return
        }
        output.saveBreakpoint(name: name, template: template)
    }
    @objc private func closeButtonTapped() { output.viewWantsToDismiss() }
}

// MARK: TemplateAddingViewInput

extension TemplateAddingViewController: TemplateAddingViewInput {
    func dismiss() {
        self.dismiss(animated: true)
    }
}
