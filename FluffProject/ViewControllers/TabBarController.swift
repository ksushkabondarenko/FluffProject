import UIKit

class TabBarController: UITabBarController {
    // MARK: - Private
    private let weightVC = UINavigationController(rootViewController: WeightViewController())
    private let caloriesVC = UINavigationController(rootViewController: CaloriesViewController())
    private let profileVC = UINavigationController(rootViewController: ProfileViewController())
    private let statisticVC = UINavigationController(rootViewController: MainTableViewController())
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBarController()
    }
    // MARK: - Setups
    private func setUpTabBarController() {
        tabBar.backgroundColor = .systemBackground
        setViewControllers([profileVC,weightVC, statisticVC, caloriesVC], animated: false)
        setUpTabBarItems()
    }
    // MARK: - Helpers
    private func setUpTabBarItems() {
        profileVC.title = "My Profile"
        weightVC.title = "Weight Control"
        statisticVC.title = "Daily Reports"
        caloriesVC.title = "Calories Control"
        let images = ["person.fill","plus","list.dash","fork.knife"]
        guard let items = tabBar.items else { return }
        for index in 0..<items.count {
            items[index].image = UIImage(systemName: images[index])
        }
    }
}
