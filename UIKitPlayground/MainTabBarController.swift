import UIKit
import SwiftUI

final class MainTabBarController: UITabBarController {

    private var didLogContentLayoutGuide = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupTabs()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard !didLogContentLayoutGuide else { return }
        didLogContentLayoutGuide = true

        if #available(iOS 26.0, *) {
            let layoutFrame = contentLayoutGuide.layoutFrame
            Swift.debugPrint("tabBar.contentLayoutGuide.layoutFrame = \(layoutFrame)")
        } else {
            
            // Fallback on earlier versions
        }
        let safeFrame = tabBar.safeAreaLayoutGuide.layoutFrame
        
        Swift.debugPrint("tabBar.safeAreaLayoutGuide.layoutFrame = \(safeFrame)")
    }

    private func configureAppearance() {
        // Active/inactive colors
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .secondaryLabel

        // Modern appearance configuration
        let appearance = UITabBarAppearance()
        
        appearance.configureWithTransparentBackground()
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        appearance.inlineLayoutAppearance.selected.iconColor = .systemBlue
        appearance.compactInlineLayoutAppearance.selected.iconColor = .systemBlue

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        
        if #available(iOS 26.0, *) {
            // Accessory content without stack view; use default sizing
            let vc = UIHostingController(rootView: MiniPlayerView())
            vc.view.backgroundColor = .clear
            
            // Place accessory above the tab bar using UITabAccessory
            let bottomAccessory = UITabAccessory(contentView: vc.view)
            setBottomAccessory(bottomAccessory, animated: true)

            // Keep minimize behavior on scroll down
            tabBarMinimizeBehavior = .onScrollDown
        } else {
            // Fallback on earlier versions
        }
        
    }
    
  
    private func setupTabs() {
        let home = makeNav(
            title: "ホーム",
            systemImageName: "house",
            backgroundColor: .systemBackground
        )

        let search = makeNav(
            title: "検索",
            systemImageName: "magnifyingglass",
            backgroundColor: .systemBackground
        )

        let settings = makeNav(
            title: "設定",
            systemImageName: "gear",
            backgroundColor: .systemGroupedBackground
        )

        viewControllers = [home, search, settings]
    }
    
    
    func menuHandler(action: UIAction) {
        Swift.debugPrint("Menu handler: \(action.title)")
    }


    private func makeNav(title: String, systemImageName: String, backgroundColor: UIColor) -> UINavigationController {
        if #available(iOS 26.0, *) {
            let vc = SimplePlaceholderViewController(titleText: title, backgroundColor: backgroundColor)
            vc.title = title
            let shareBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                 style: .plain,
                                                 target: nil,
                                                 action: nil)
            let infoBarButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                style: .plain,
                                                target: nil,
                                                action: nil)
            let addBarButton = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(showModal)
            )
            
            let barButtonMenu = UIMenu(title: "", children: [
                UIAction(title: NSLocalizedString("Copy", comment: ""), image: UIImage(systemName: "doc.on.doc"), handler: menuHandler),
                UIAction(title: NSLocalizedString("Rename", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
                UIAction(title: NSLocalizedString("Duplicate", comment: ""), image: UIImage(systemName: "plus.square.on.square"), handler: menuHandler),
                UIAction(title: NSLocalizedString("Move", comment: ""), image: UIImage(systemName: "folder"), handler: menuHandler)
            ])
            let options = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), menu: barButtonMenu)
            addBarButton.style = .prominent
            vc.navigationItem.rightBarButtonItems = [
                addBarButton,
                .fixedSpace(10),
                infoBarButton,
                options,
                .fixedSpace(20),
                shareBarButton,
            ]
            
            let nav = UINavigationController(rootViewController: vc)
            
            // Make the navigation bar background transparent
            let navAppearance = UINavigationBarAppearance()
            navAppearance.configureWithTransparentBackground()
            navAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
            navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
            
            nav.navigationBar.standardAppearance = navAppearance
            nav.navigationBar.scrollEdgeAppearance = navAppearance
            nav.navigationBar.compactAppearance = navAppearance
            nav.navigationBar.tintColor = .systemBlue
            
            nav.navigationBar.prefersLargeTitles = true
            
            nav.tabBarItem = UITabBarItem(title: title,
                                          image: UIImage(systemName: systemImageName),
                                          selectedImage: nil)
            
            return nav
        } else {
            fatalError("iOS 26.0以降に対応していないため、このコードは実行できません。")
        }
    }
    
    
    @objc private func showModal() {
        let modalVC = ModalViewController()
        modalVC.modalPresentationStyle = .automatic  // iOS 13以降はデフォルトでシート風
        present(modalVC, animated: true)
    }
}




extension UIColor {
    static var random: UIColor {
        UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
}

