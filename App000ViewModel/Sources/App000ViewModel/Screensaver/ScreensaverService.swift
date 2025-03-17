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
            GamePresentationModel(image: "scrensaver1"),
            GamePresentationModel(image: "scrensaver2"),
            GamePresentationModel(image: "scrensaver3"),
            GamePresentationModel(image: "scrensaver4"),
            GamePresentationModel(image: "scrensaver5"),
            GamePresentationModel(image: "scrensaver6"),
            GamePresentationModel(image: "scrensaver7"),
            GamePresentationModel(image: "scrensaver8"),
            GamePresentationModel(image: "scrensaver9"),
            GamePresentationModel(image: "scrensaver1"),
            GamePresentationModel(image: "scrensaver2"),
            GamePresentationModel(image: "scrensaver3"),
            GamePresentationModel(image: "scrensaver4"),
            GamePresentationModel(image: "scrensaver5"),
            GamePresentationModel(image: "scrensaver6"),
            GamePresentationModel(image: "scrensaver7"),
            GamePresentationModel(image: "scrensaver8"),
            GamePresentationModel(image: "scrensaver9")
        ]
    }
}
