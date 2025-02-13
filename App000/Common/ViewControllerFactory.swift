//
//  ViewControllerFactory.swift
//  App000
//
//  Created by Er Baghdasaryan on 04.02.25.
//

import Foundation
import Swinject
import App000Model
import App000ViewModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }

    //MARK: Screensaver
    static func makeScreensaverViewController() -> ScreensaverViewController {
        let assembler = Assembler(commonAssemblies + [ScreensaverAssembly()])
        let viewController = ScreensaverViewController()
        viewController.viewModel = assembler.resolver.resolve(IScreensaverViewModel.self)
        return viewController
    }

    //MARK: Download
    static func makeDownloadViewController(navigationModel: DownloadNavigationModel) -> DownloadViewController {
        let assembler = Assembler(commonAssemblies + [DownloadAssembly()])
        let viewController = DownloadViewController()
        viewController.viewModel = assembler.resolver.resolve(IDownloadViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    //MARK: About
    static func makeAboutViewController() -> AboutViewController {
        let viewController = AboutViewController()
        return viewController
    }

    //MARK: PrivacyPolicy
    static func makePrivacyViewController() -> PrivacyViewController {
        let viewController = PrivacyViewController()
        return viewController
    }

    //MARK: Terms
    static func makeTermsViewController() -> TermsViewController {
        let viewController = TermsViewController()
        return viewController
    }

}
