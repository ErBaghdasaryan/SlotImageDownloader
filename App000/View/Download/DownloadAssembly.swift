//
//  DownloadAssembly.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000ViewModel
import App000Model
import Swinject
import SwinjectAutoregistration

final class DownloadAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IDownloadViewModel.self, argument: DownloadNavigationModel.self, initializer: DownloadViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IDownloadService.self, initializer: DownloadService.init)
    }
}
