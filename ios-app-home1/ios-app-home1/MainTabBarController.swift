import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        styleTabBar()
        hideNavigationBars()
    }

    func setupTabs() {

        let home = UINavigationController(rootViewController: HomeViewController())
        home.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house"),
                                       selectedImage: UIImage(systemName: "house.fill"))

        
        let insights = UINavigationController(rootViewController: InsightsViewController())
        insights.tabBarItem = UITabBarItem(title: "Insights",
                                           image: UIImage(systemName: "chart.bar"),
                                           selectedImage: UIImage(systemName: "chart.bar.fill"))

        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem = UITabBarItem(title: "Profile",
                                          image: UIImage(systemName: "person"),
                                          selectedImage: UIImage(systemName: "person.fill"))

        viewControllers = [home, insights, profile]
    }

    func styleTabBar() {
        let pink = UIColor(hex: "#F4716A")

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        appearance.stackedLayoutAppearance.normal.iconColor = pink.withAlphaComponent(0.5)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: pink.withAlphaComponent(0.5)
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = pink
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: pink
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    func hideNavigationBars() {
        viewControllers?.forEach { vc in
            if let nav = vc as? UINavigationController {
                nav.setNavigationBarHidden(true, animated: false)
            }
        }
    }
}
