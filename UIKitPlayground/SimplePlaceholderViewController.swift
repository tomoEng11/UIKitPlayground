//
//  SimplePlaceholderViewController.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/09/29.
//

import UIKit

// シンプルなプレースホルダー画面（必要に応じてあなたの画面に置き換えてください）
final class SimplePlaceholderViewController: UIViewController {
    private let titleText: String
    private let bgColor: UIColor

    init(titleText: String, backgroundColor: UIColor) {
        self.titleText = titleText
        self.bgColor = backgroundColor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor

        // Scrollable container
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .automatic

        // Content stack inside the scroll view
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.spacing = 16
        contentStack.isLayoutMarginsRelativeArrangement = true
        contentStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            // Scroll view pinned to safe area
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // Content stack pinned to contentLayoutGuide
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            // Match content width to the scroll view's width for vertical scrolling
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        // Title label as sample content
        let titleLabel = UILabel()
        titleLabel.text = titleText
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0

        contentStack.addArrangedSubview(titleLabel)

        // Subtitle label
        let subtitleLabel = UILabel()
        subtitleLabel.text = "サンプルセクション"
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 1
        contentStack.addArrangedSubview(subtitleLabel)

        // Body text
        let bodyLabel = UILabel()
        bodyLabel.text = "これはスクロールを確認するためのダミーテキストです。" + String(repeating: "ダミーコンテンツ。", count: 12)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bodyLabel.textColor = .label
        bodyLabel.numberOfLines = 0
        contentStack.addArrangedSubview(bodyLabel)

        // Horizontal button row
        let buttonRow = UIStackView()
        buttonRow.axis = .horizontal
        buttonRow.alignment = .fill
        buttonRow.distribution = .fillEqually
        buttonRow.spacing = 12

        let primaryButton = UIButton(type: .system)
        primaryButton.setTitle("アクション1", for: .normal)
        let secondaryButton = UIButton(type: .system)
        secondaryButton.setTitle("アクション2", for: .normal)

        buttonRow.addArrangedSubview(primaryButton)
        buttonRow.addArrangedSubview(secondaryButton)
        contentStack.addArrangedSubview(buttonRow)

        // Simple card-like placeholder views to extend content height
        for i in 1...20 {
            let card = UIView()
            card.backgroundColor = .random
            card.layer.cornerRadius = 12
            card.translatesAutoresizingMaskIntoConstraints = false
            

            // Give the card a fixed height so it contributes to scrollable content
            let heightConstraint = card.heightAnchor.constraint(equalToConstant: 120)
            heightConstraint.isActive = true

            // Optional title inside each card
            let cardTitle = UILabel()
            cardTitle.text = "カード \(i)"
            cardTitle.font = UIFont.preferredFont(forTextStyle: .headline)
            cardTitle.textColor = .label
            cardTitle.translatesAutoresizingMaskIntoConstraints = false

            card.addSubview(cardTitle)
            NSLayoutConstraint.activate([
                cardTitle.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
                cardTitle.topAnchor.constraint(equalTo: card.topAnchor, constant: 16)
            ])

            contentStack.addArrangedSubview(card)
        }
    }
}
