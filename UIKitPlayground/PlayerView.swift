//
//  PlayerView.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/09/27.
//

import UIKit


@available(iOS 26.0, *)
final class PlayerView: UIViewController {
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 300),
            label.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    // iOS 18 以降の推奨：ここで traitCollection を使う
    override func updateProperties() {
        super.updateProperties()

        // traitCollection の userInterfaceStyle を参照すると、
        // 自動でダーク/ライトモードを監視してくれる
        if traitCollection.userInterfaceStyle == .dark {
            label.textColor = .white
        } else {
            label.textColor = .black
        }
    }
}
