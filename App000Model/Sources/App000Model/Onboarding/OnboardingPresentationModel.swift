//
//  OnboardingPresentationModel.swift
//  App000Model
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation

public struct OnboardingPresentationModel {
    public let image: String
    public let header: String
    public let subHeader: String

    public init(image: String, header: String, subHeader: String) {
        self.image = image
        self.header = header
        self.subHeader = subHeader
    }
}
