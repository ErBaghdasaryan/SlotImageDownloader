//
//  ScreensaverService.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000Model

public protocol IScreensaverService {
    func getItems() -> [GamePresentationModel]
}

public class ScreensaverService: IScreensaverService {

    public init() { }

    public func getItems() -> [GamePresentationModel] {
        [
            GamePresentationModel(image: "scrensaver1"),
            GamePresentationModel(image: "scrensaver2"),
            GamePresentationModel(image: "scrensaver3"),
            GamePresentationModel(image: "scrensaver4"),
            GamePresentationModel(image: "scrensaver5"),
            GamePresentationModel(image: "scrensaver6"),
            GamePresentationModel(image: "scrensaver7"),
            GamePresentationModel(image: "scrensaver8"),
            GamePresentationModel(image: "scrensaver9"),
            GamePresentationModel(image: "scrensaver10"),
            GamePresentationModel(image: "scrensaver11"),
            GamePresentationModel(image: "scrensaver12"),
            GamePresentationModel(image: "scrensaver13"),
            GamePresentationModel(image: "scrensaver14"),
            GamePresentationModel(image: "scrensaver15"),
            GamePresentationModel(image: "scrensaver16"),
            GamePresentationModel(image: "scrensaver17"),
            GamePresentationModel(image: "scrensaver18"),
            GamePresentationModel(image: "scrensaver19"),
            GamePresentationModel(image: "scrensaver20"),
            GamePresentationModel(image: "scrensaver21"),
            GamePresentationModel(image: "scrensaver22"),
            GamePresentationModel(image: "scrensaver23"),
            GamePresentationModel(image: "scrensaver24"),
            GamePresentationModel(image: "scrensaver25"),
            GamePresentationModel(image: "scrensaver26"),
            GamePresentationModel(image: "scrensaver27"),
            GamePresentationModel(image: "scrensaver28"),
            GamePresentationModel(image: "scrensaver29"),
            GamePresentationModel(image: "scrensaver30")
        ]
    }
}
