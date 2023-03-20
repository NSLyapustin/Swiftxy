//
//  RequestBreakpointViewController.swift
//  Swiftxy
//
//  Created by n.lyapustin on 18.03.2023.
//

import Foundation

final class RequestBreakpointViewController: UIViewController {

    // MARK: Nested Types

    struct DisplayData {
        let url: String?
        let queryParameters: [String: String]?
        let headers: [String: String]?
        let body: String?
    }

    // MARK: Private properties

    private let output: RequestBreakpointViewOutput

    private let contentView = UIView()
    private let scrollView = UIScrollView()

    private let urlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "URL"
        return label
    }()

    private let urlTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "URL"
        return textField
    }()

    private let queryParametersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Query parameters"
        return label
    }()

    private let queryParametersTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Query parameters"
        return textField
    }()

    private let headersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Headers"
        return label
    }()

    private let headersTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Headers"
        return textField
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Body"
        return label
    }()

    private let bodyTextField: UITextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Body"
        return textField
    }()

    // MARK: Lifecycle

    init(output: RequestBreakpointViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }

    // MARK: Private methods

    private func setupViews() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])


        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)
        ])

        // URL

        contentView.addSubview(urlLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(urlTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlTextField, attribute: .leading, relatedBy: .equal, toItem: urlLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: urlTextField, attribute: .top, relatedBy: .equal, toItem: urlLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: urlTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 56)
        ])

        // Query parameters

        contentView.addSubview(queryParametersLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: queryParametersLabel, attribute: .top, relatedBy: .equal, toItem: urlTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: queryParametersLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: queryParametersLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(queryParametersTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: queryParametersTextField, attribute: .leading, relatedBy: .equal, toItem: queryParametersLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .top, relatedBy: .equal, toItem: queryParametersLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 42)
        ])

        // Headers

        contentView.addSubview(headersLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersLabel, attribute: .top, relatedBy: .equal, toItem: queryParametersTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: headersLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: headersLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(headersTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersTextField, attribute: .leading, relatedBy: .equal, toItem: headersLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headersTextField, attribute: .top, relatedBy: .equal, toItem: headersLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: headersTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: headersTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 42)
        ])

        // Body

        contentView.addSubview(bodyLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: bodyLabel, attribute: .top, relatedBy: .equal, toItem: headersTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: bodyLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: bodyLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(bodyTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: bodyTextField, attribute: .leading, relatedBy: .equal, toItem: bodyLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bodyTextField, attribute: .top, relatedBy: .equal, toItem: bodyLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: bodyTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: bodyTextField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: bodyTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 42)
        ])
    }

    func setupScrollView(){
        view.backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        // URL

        contentView.addSubview(urlLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(urlTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlTextField, attribute: .leading, relatedBy: .equal, toItem: urlLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: urlTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: urlTextField, attribute: .top, relatedBy: .equal, toItem: urlLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: urlTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16)
        ])

        // Query parameters

        contentView.addSubview(queryParametersLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: queryParametersLabel, attribute: .top, relatedBy: .equal, toItem: urlTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: queryParametersLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(queryParametersTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: queryParametersTextField, attribute: .leading, relatedBy: .equal, toItem: queryParametersLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .top, relatedBy: .equal, toItem: queryParametersLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: queryParametersTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16)
        ])

        // Headers

        contentView.addSubview(headersLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersLabel, attribute: .top, relatedBy: .equal, toItem: queryParametersTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: headersLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(headersTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersTextField, attribute: .leading, relatedBy: .equal, toItem: headersLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headersTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: headersTextField, attribute: .top, relatedBy: .equal, toItem: headersLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: headersTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16)
        ])

        // Body

        contentView.addSubview(bodyLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: bodyLabel, attribute: .top, relatedBy: .equal, toItem: headersTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: bodyLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(bodyTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: bodyTextField, attribute: .leading, relatedBy: .equal, toItem: bodyLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bodyTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: bodyTextField, attribute: .top, relatedBy: .equal, toItem: bodyLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: bodyTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: bodyTextField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -16)
        ])
    }
}

extension RequestBreakpointViewController: RequestBreakpointViewInput {}
