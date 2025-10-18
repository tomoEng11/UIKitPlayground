import UIKit
import SwiftUI

/// コンテンツタブの上に常時表示されるミニプレイヤーを備えた画面。
/// iOS 26 以降の UITabAccessory などは使わず、従来 API のみで構成する。
final class MiniPlayerTabViewController: UIViewController {

    private let tabController = UITabBarController()
    private let miniPlayerHostController = UIHostingController(rootView: MiniPlayerBarView())
    private let bannerView = BannerMessageView()
    private let miniPlayerHeight: CGFloat = 76
    private let bannerHeight: CGFloat = 48
    private let stackSpacing: CGFloat = 8

    private var contentBottomInset: CGFloat {
        miniPlayerHeight + bannerHeight + (stackSpacing * 2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureChildTabController()
        configureMiniPlayer()
    }

    private func configureChildTabController() {
        addChild(tabController)
        tabController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabController.view)

        NSLayoutConstraint.activate([
            tabController.view.topAnchor.constraint(equalTo: view.topAnchor),
            tabController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tabController.didMove(toParent: self)
        tabController.viewControllers = makeTabs()
    }

    private func configureMiniPlayer() {
        addChild(miniPlayerHostController)

        guard let miniPlayerView = miniPlayerHostController.view else {
            miniPlayerHostController.removeFromParent()
            return
        }

        miniPlayerView.translatesAutoresizingMaskIntoConstraints = false
        miniPlayerView.backgroundColor = .clear
        bannerView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(miniPlayerView)
        view.addSubview(bannerView)

        let topAnchor = tabController.tabBar.topAnchor

        NSLayoutConstraint.activate([
            miniPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            miniPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            miniPlayerView.bottomAnchor.constraint(equalTo: topAnchor, constant: -stackSpacing),
            miniPlayerView.heightAnchor.constraint(equalToConstant: miniPlayerHeight),

            bannerView.leadingAnchor.constraint(equalTo: miniPlayerView.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: miniPlayerView.trailingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: miniPlayerView.topAnchor, constant: -stackSpacing),
            bannerView.heightAnchor.constraint(equalToConstant: bannerHeight)
        ])

        miniPlayerHostController.didMove(toParent: self)
    }

    private func makeTabs() -> [UIViewController] {
        let home = makeNavigationController(
            title: "ホーム",
            systemImageName: "house.fill",
            backgroundColor: .systemBackground
        )

        let library = makeNavigationController(
            title: "ライブラリ",
            systemImageName: "books.vertical.fill",
            backgroundColor: .systemGroupedBackground
        )

        let refreshable = makeRefreshableNavigationController()

        let settings = makeNavigationController(
            title: "設定",
            systemImageName: "gear",
            backgroundColor: .secondarySystemBackground
        )

        return [home, library, refreshable, settings]
    }

    private func makeNavigationController(title: String, systemImageName: String, backgroundColor: UIColor) -> UINavigationController {
        let root = SimplePlaceholderViewController(titleText: title, backgroundColor: backgroundColor)
        root.title = title
        root.additionalSafeAreaInsets.bottom = contentBottomInset

        let navigationController = UINavigationController(rootViewController: root)
        navigationController.additionalSafeAreaInsets.bottom = contentBottomInset
        configureNavigationAppearance(for: navigationController)

        navigationController.tabBarItem = UITabBarItem(title: title,
                                                       image: UIImage(systemName: systemImageName),
                                                       selectedImage: nil)

        return navigationController
    }

    private func makeRefreshableNavigationController() -> UINavigationController {
        if #available(iOS 26.0, *) {
            let refreshableHost = UIHostingController(rootView: RefreshableScrollView())
            refreshableHost.title = "リフレッシュ"
            refreshableHost.additionalSafeAreaInsets.bottom = contentBottomInset

            let navigationController = UINavigationController(rootViewController: refreshableHost)
            navigationController.additionalSafeAreaInsets.bottom = contentBottomInset
            configureNavigationAppearance(for: navigationController)

            navigationController.tabBarItem = UITabBarItem(title: "リフレッシュ",
                                                           image: UIImage(systemName: "arrow.clockwise"),
                                                           selectedImage: nil)
            return navigationController
        } else {
            return makeNavigationController(title: "リフレッシュ",
                                            systemImageName: "arrow.clockwise",
                                            backgroundColor: .systemBackground)
        }
    }

    private func configureNavigationAppearance(for navigationController: UINavigationController) {
        navigationController.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
}

// MARK: - Mini player view

struct MiniPlayerBarView: View {

    var body: some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(Color.primary.opacity(0.2))
                .frame(width: 36, height: 4)

            HStack(spacing: 12) {
                Image(systemName: "music.note")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.primary)
                    .frame(width: 48, height: 48)
                    .background(Color.primary.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                VStack(alignment: .leading, spacing: 2) {
                    Text("Sample Track")
                        .font(.callout)
                        .foregroundStyle(Color.primary)
                        .lineLimit(1)

                    Text("Sample Artist")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                        .lineLimit(1)
                }

                Spacer(minLength: 0)

                HStack(spacing: 12) {
                    Button(action: {}) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 32, height: 32)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(Color.primary)

                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 32, height: 32)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(Color.primary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
        .padding(.top, 8)
        .frame(height: 76, alignment: .top)
        .frame(maxWidth: .infinity)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(.systemBackground).opacity(0.3))
        )
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
