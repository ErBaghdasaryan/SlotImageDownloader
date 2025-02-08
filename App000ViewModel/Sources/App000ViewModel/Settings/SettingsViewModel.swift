//
//  SettingsViewModel.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000Model

public protocol ISettingsViewModel {
    
}

public class SettingsViewModel: ISettingsViewModel {

    private let settingsService: ISettingsService

    public init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }
}
