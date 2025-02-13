//
//  ScreensaverViewModel.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000Model

public protocol IScreensaverViewModel {
    var items: [GamePresentationModel] { get set }
    func loadItems()
}

public class ScreensaverViewModel: IScreensaverViewModel {

    private let screensaverService: IScreensaverService
    public var items: [GamePresentationModel] = []

    public init(screensaverService: IScreensaverService) {
        self.screensaverService = screensaverService
    }

    public func loadItems() {
        items = screensaverService.getItems()
    }
}
