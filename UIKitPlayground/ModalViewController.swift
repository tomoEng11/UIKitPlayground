//
//  ModalViewController.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/09/29.
//

import UIKit


class ModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        closeButton.center = view.center
        closeButton.frame = CGRect(x: 100, y: 200, width: 150, height: 50)
        view.addSubview(closeButton)
    }

    @objc private func closeModal() {
        dismiss(animated: true)
    }
}
