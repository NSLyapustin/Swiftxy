//
//  ResponseBreakpointViewController.swift
//  Swiftxy
//
//  Created by n.lyapustin on 02.04.2023.
//

import Foundation

final public class ResponseBreakpointViewController: UIViewController {

    // MARK: Nested types

    public struct DisplayData {

        public init() {}

    }

    // MARK: Private properties

    private let contentView = UIView()
    private let scrollView = UIScrollView()

    private let responseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Response"
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    private let urlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "URL"
        return label
    }()

    private let urlTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = false
        return textField
    }()

    private let statusCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Status Code"
        return label
    }()

    private let statusCodeTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let headersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Headers"
        return label
    }()

    private let headersTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Body"
        return label
    }()

    private let bodyTextField: UITextView = {
        let textField = TextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    // MARK: Lifecycle

    public init(displayData: DisplayData) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
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

        contentView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
        ])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        contentView.addSubview(urlLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlLabel, attribute: .top, relatedBy: .equal, toItem: closeButton, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: urlLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(urlTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: urlTextField, attribute: .leading, relatedBy: .equal, toItem: urlLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: urlTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: urlTextField, attribute: .top, relatedBy: .equal, toItem: urlLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: urlTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: urlTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 32)
        ])

        // Query parameters

        contentView.addSubview(statusCodeLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: statusCodeLabel, attribute: .top, relatedBy: .equal, toItem: urlTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: statusCodeLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(statusCodeTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: statusCodeTextField, attribute: .leading, relatedBy: .equal, toItem: statusCodeLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: statusCodeTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: statusCodeTextField, attribute: .top, relatedBy: .equal, toItem: statusCodeLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: statusCodeTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: statusCodeTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 96)
        ])

        // Headers

        contentView.addSubview(headersLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersLabel, attribute: .top, relatedBy: .equal, toItem: statusCodeTextField, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: headersLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16)
        ])

        contentView.addSubview(headersTextField)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headersTextField, attribute: .leading, relatedBy: .equal, toItem: headersLabel, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headersTextField, attribute: .trailing, relatedBy: .equal, toItem: urlLabel, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: headersTextField, attribute: .top, relatedBy: .equal, toItem: headersLabel, attribute: .bottom, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: headersTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: headersTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 96)
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
            NSLayoutConstraint(item: bodyTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: bodyTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 320),
            NSLayoutConstraint(item: bodyTextField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -16),
        ])

        contentView.addSubview(sendButton)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: sendButton, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: sendButton, attribute: .centerY, relatedBy: .equal, toItem: closeButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)

        // Title

        contentView.addSubview(responseLabel)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: responseLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: responseLabel, attribute: .centerY, relatedBy: .equal, toItem: closeButton, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }

    @objc private func closeButtonTapped() { self.dismiss(animated: true) }

    @objc private func sendButtonTapped() {

    }
}
