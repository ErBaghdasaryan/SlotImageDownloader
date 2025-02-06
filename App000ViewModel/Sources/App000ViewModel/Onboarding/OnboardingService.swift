//
//  OnboardingService.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit
import App000Model

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "onboarding1",
                                        header: "Explore the best images and decorate your screen with stylish wallpapers!"),
            OnboardingPresentationModel(image: "onboarding2",
                                        header: "Discover the best and most downloaded wallpapers in the 'Popular' section!")
        ]
    }
}
