//
//  ReusableView.swift
//  App000
//
//  Created by Er Baghdasaryan on 04.02.25.
//

import UIKit

protocol IReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension IReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
