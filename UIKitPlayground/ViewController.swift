//
//  ViewController.swift
//  UIKitPlayground
//
//  Created by 井本　智博 on 2025/08/16.
//

import UIKit

class ViewController: UIViewController {

    private let textView: PlaceholderTextView = PlaceholderTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpUI() {
        view.backgroundColor = .cyan
        textView.delegate = self
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .orange
        textView.textColor = .white
        textView.isScrollEnabled = true
        textView.text = "Following on from our last post, and on the other side of US politics, Democrats in Congress say they're ready to act if Trump and Putin's meeting tomorrow yields no progress in ending the war in Ukraine.Jeanne Shaheen, the top Democrat on the Senate Foreign Relations Committee, tells CNN that Trump's handling of Russia has been an  and that Putin has been  since he took office.President Trump has set one red line after another and Vladimir Putin has continued to cross them, she says.Shaheen continues, saying Zelensky should be at the table for discussions about the war and that the US should be providing more support and weapons to Ukraine.If significant steps aren't taken in Alaska tomorrow, Congress will submit a Russia sanctions bill, she tells the broadcaster: If the president can't get any progress, we intend to act."

        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: 100),
            textView.widthAnchor.constraint(equalToConstant: 300),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}

extension ViewController:  UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
}


@IBDesignable
final class PlaceholderTextView: UITextView {

    // MARK: - Public

    /// プレースホルダー文字列
    @IBInspectable var placeholder: String = "" {
        didSet { placeholderLabel.text = placeholder }
    }

    /// プレースホルダー色
    @IBInspectable var placeholderColor: UIColor = .placeholderText {
        didSet { placeholderLabel.textColor = placeholderColor }
    }

    /// プレースホルダーの左右マージン（本文のlineFragmentPaddingとずれないように）
    @IBInspectable var placeholderHorizontalInset: CGFloat = 0 {
        didSet { updatePlaceholderConstraints() }
    }

    // MARK: - Private

    private let placeholderLabel = UILabel()
    private var placeholderTopConstraint: NSLayoutConstraint?
    private var placeholderLeadingConstraint: NSLayoutConstraint?
    private var placeholderTrailingConstraint: NSLayoutConstraint?

    // MARK: - Init

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        // 基本設定
        isScrollEnabled = true

        // Placeholder label
        placeholderLabel.numberOfLines = 0
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.backgroundColor = .clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.isAccessibilityElement = false
        placeholderLabel.isUserInteractionEnabled = false
        addSubview(placeholderLabel)

        // 初期フォント/整列はTextViewに追従
        placeholderLabel.font = self.font ?? UIFont.preferredFont(forTextStyle: .body)
        placeholderLabel.textAlignment = self.textAlignment

        // 制約
        updatePlaceholderConstraints()

        // 変更監視
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChangeNotification),
            name: UITextView.textDidChangeNotification,
            object: self
        )
        // Dynamic Type対応
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentSizeCategoryDidChange),
            name: UIContentSizeCategory.didChangeNotification,
            object: nil
        )

        updatePlaceholderVisibility()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Layout

    override var text: String! {
        didSet { updatePlaceholderVisibility() }
    }

    override var attributedText: NSAttributedString! {
        didSet {
            // フォント/整列が変わる可能性がある
            placeholderLabel.font = self.font ?? placeholderLabel.font
            placeholderLabel.textAlignment = self.textAlignment
            updatePlaceholderVisibility()
        }
    }

    override var font: UIFont? {
        didSet { placeholderLabel.font = font }
    }

    override var textAlignment: NSTextAlignment {
        didSet { placeholderLabel.textAlignment = textAlignment }
    }

    override var textContainerInset: UIEdgeInsets {
        didSet { updatePlaceholderConstraints() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // サイズ変化で折り返し再計算
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2
    }

    // MARK: - Actions

    @objc private func textDidChangeNotification() {
        updatePlaceholderVisibility()
    }

    @objc private func contentSizeCategoryDidChange() {
        if let font = self.font {
            placeholderLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        }
    }

    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !text.isEmpty
        // VoiceOver: 文字が空ならplaceholderをヒントとして読ませる
        accessibilityHint = text.isEmpty ? placeholder : nil
    }

    private func updatePlaceholderConstraints() {
        // 既存制約を外す
        NSLayoutConstraint.deactivate([
            placeholderTopConstraint,
            placeholderLeadingConstraint,
            placeholderTrailingConstraint
        ].compactMap { $0 })

        let clg = self.contentLayoutGuide    // スクロール可能領域
        let flg = self.frameLayoutGuide      // 表示フレーム

        // UITextView 内側余白
        let top    = textContainerInset.top
        let left   = textContainerInset.left + textContainer.lineFragmentPadding + placeholderHorizontalInset
        let right  = -(textContainerInset.right + textContainer.lineFragmentPadding + placeholderHorizontalInset)
        let bottom = -(textContainerInset.bottom)

        // 四辺を contentLayoutGuide に“等号”で揃える（高さを確定させる）
        let topEQ     = placeholderLabel.topAnchor.constraint(equalTo: clg.topAnchor, constant: top)
        let leadEQ    = placeholderLabel.leadingAnchor.constraint(equalTo: clg.leadingAnchor, constant: left)
        let trailEQ   = placeholderLabel.trailingAnchor.constraint(equalTo: clg.trailingAnchor, constant: right)
        let bottomEQ  = placeholderLabel.bottomAnchor.constraint(equalTo: clg.bottomAnchor, constant: bottom)

        // 横スクロールを防ぐ：プレースホルダーの幅＝見えてる幅
        let widthEQ   = placeholderLabel.widthAnchor.constraint(equalTo: flg.widthAnchor,
                                                                constant: left + right)

        placeholderTopConstraint = topEQ
        placeholderLeadingConstraint = leadEQ
        placeholderTrailingConstraint = trailEQ

        NSLayoutConstraint.activate([topEQ, leadEQ, trailEQ, bottomEQ, widthEQ])
    }
}

