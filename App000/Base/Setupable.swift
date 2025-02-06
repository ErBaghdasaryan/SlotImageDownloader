//
//  Setupable.swift
//  App000
//
//  Created by Er Baghdasaryan on 04.02.25.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
