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
            GamePresentationModel(image: "popular2"),
            GamePresentationModel(image: "popular3")
        ]
    }

    public func getNonPopularItems() -> [GamePresentationModel] {
        [
            GamePresentationModel(image: "nonPopular1"),
            GamePresentationModel(image: "nonPopular2"),
            GamePresentationModel(image: "nonPopular3"),
            GamePresentationModel(image: "nonPopular4"),
            GamePresentationModel(image: "nonPopular5"),
            GamePresentationModel(image: "nonPopular6"),
            GamePresentationModel(image: "nonPopular7"),
            GamePresentationModel(image: "nonPopular8"),
            GamePresentationModel(image: "nonPopular9"),
            GamePresentationModel(image: "nonPopular10")
        ]
    }

}
