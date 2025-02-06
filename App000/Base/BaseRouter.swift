//
//  BaseRouter.swift
//  App000
//
//  Created by Er Baghdasaryan on 04.02.25.
//

import UIKit
import Combine
import App000ViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
