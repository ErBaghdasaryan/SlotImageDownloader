//
//  ScreensaverViewModel.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000Model

public protocol IScreensaverViewModel {
    var popularItems: [GamePresentationModel] { get set }
    func loadPopularGames()
    var nonPopularItems: [GamePresentationModel] { get set }
    func loadNonPopularGames()
}

public class ScreensaverViewModel: IScreensaverViewModel {

    private let screensaverService: IScreensaverService
    public var popularItems: [GamePresentationModel] = []
    public var nonPopularItems: [GamePresentationModel] = []

    public init(screensaverService: IScreensaverService) {
        self.screensaverService = screensaverService
    }

    public func loadPopularGames() {
        popularItems = screensaverService.getPopularItems()
    }

    public func loadNonPopularGames() {
        nonPopularItems = screensaverService.getNonPopularItems()
    }
}
