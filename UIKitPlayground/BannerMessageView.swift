//
//  BannerMessageView.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/10/07.
//

import UIKit

final class BannerMessageView: UIView {

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 48)
    }

    private func configureView() {
        layer.cornerRadius = 14
        layer.masksToBounds = true

        blurView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurView)

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let contentView = blurView.contentView
        contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.15)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.text = "新しいプレイリストが利用できます。"

        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .secondaryLabel
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.accessibilityLabel = NSLocalizedString("閉じる", comment: "")

        let stack = UIStackView(arrangedSubviews: [titleLabel, closeButton])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 28),
            closeButton.heightAnchor.constraint(equalToConstant: 28),

            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    @objc private func closeTapped() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: 0, y: 10)
        }, completion: { _ in
            self.isHidden = true
        })
    }
}
