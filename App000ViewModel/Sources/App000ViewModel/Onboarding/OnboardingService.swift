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
                                        header: "Wallpapers, Just for U",
                                        subHeader: "Hand-picked selection of 30 premium wallpapers, refreshed every 2 weeks."),
            OnboardingPresentationModel(image: "onboarding2",
                                        header: "Wallpapers Every 2 Weeks",
                                        subHeader: "Enjoy a brand-new collection of exclusive designs, carefully selected by our editors.")
        ]
    }
}
