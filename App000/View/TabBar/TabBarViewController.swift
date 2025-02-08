//
//  TabBarViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit
import App000ViewModel
import SnapKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        lazy var screensaverViewController = self.createNavigation(title: "Screensavers",
                                                                   image: "screensaver",
                                                                   vc: ViewControllerFactory.makeScreensaverViewController())

        lazy var downloadViewController = self.createNavigation(title: "Download",
                                                                image: "download",
                                                                vc: ViewControllerFactory.makeDownloadViewController())

        lazy var settingsViewController = self.createNavigation(title: "Settings",
                                                                image: "settings",
                                                                vc: ViewControllerFactory.makeSettingsViewController())

        self.setViewControllers([screensaverViewController, downloadViewController, settingsViewController], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPageToTeam), name: Notification.Name("ResetCompleted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPageToTeam), name: NSNotification.Name("NewMessage"), object: nil)
        self.selectedIndex = 1

        screensaverViewController.delegate = self
        downloadViewController.delegate = self
        settingsViewController.delegate = self
    }

    @objc func setCurrentPageToTeam() {
        self.selectedIndex = 1
    }

    private func createNavigation(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.barTintColor = UIColor(hex: "#37A2F4")!
        self.tabBar.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        self.tabBar.layer.borderWidth = 1

        let nonselectedTitleColor: UIColor = UIColor.gray.withAlphaComponent(0.7)
        let selectedTitleColor: UIColor = UIColor(hex: "#37A2F4")!

        let unselectedImage = UIImage(named: image)?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(nonselectedTitleColor)

        let selectedImage = UIImage(named: image)?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(selectedTitleColor)

        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.tabBarItem.title = title

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: nonselectedTitleColor
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedTitleColor
        ]

        navigation.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        navigation.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)

        return navigation
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("NewMessage"), object: nil)
        #endif
    }
}

//MARK: Navigation & TabBar Hidden
extension TabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}

//MARK: Preview
import SwiftUI

struct TabBarViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let tabBarViewController = TabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) -> TabBarViewController {
            return tabBarViewController
        }

        func updateUIViewController(_ uiViewController: TabBarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) {
        }
    }
}
