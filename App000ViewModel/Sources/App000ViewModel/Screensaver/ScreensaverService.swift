//
//  ScreensaverService.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000Model

public protocol IScreensaverService {
    func getPopularItems() -> [GamePresentationModel]
    func getNonPopularItems() -> [GamePresentationModel]
}

public class ScreensaverService: IScreensaverService {

    public init() { }

    public func getPopularItems() -> [GamePresentationModel] {
        [
            GamePresentationModel(image: "popular1"),
            GamePresentationModel(image: "main7"),
            GamePresentationModel(image: "main1"),
            GamePresentationModel(image: "main3"),
            GamePresentationModel(image: "popular2"),
            GamePresentationModel(image: "main9"),
            GamePresentationModel(image: "main2"),
            GamePresentationModel(image: "main5"),
            GamePresentationModel(image: "popular3"),
            GamePresentationModel(image: "main4"),
            GamePresentationModel(image: "main8"),
            GamePresentationModel(image: "main6")
        ]
    }

    public func getNonPopularItems() -> [GamePresentationModel] {
        [
            GamePresentationModel(image: "main1"),
            GamePresentationModel(image: "main2"),
            GamePresentationModel(image: "main3"),
            GamePresentationModel(image: "popular1"),
            GamePresentationModel(image: "main4"),
            GamePresentationModel(image: "popular2"),
            GamePresentationModel(image: "popular3"),
            GamePresentationModel(image: "main5"),
            GamePresentationModel(image: "main6"),
            GamePresentationModel(image: "main7"),
            GamePresentationModel(image: "main8"),
            GamePresentationModel(image: "main9")
        ]
    }

}
