//
//  ScreensaverRouter.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import UIKit
import App000ViewModel
import App000Model

final class ScreensaverRouter: BaseRouter {
    static func showDownloadViewController(in navigationController: UINavigationController,
                                           navigationModel: DownloadNavigationModel) {
        let viewController = ViewControllerFactory.makeDownloadViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
