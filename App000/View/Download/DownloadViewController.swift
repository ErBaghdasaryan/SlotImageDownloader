//
//  DownloadViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit
import App000ViewModel
import SnapKit

class DownloadViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = .white

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

    }
}


extension DownloadViewController: IViewModelableController {
    typealias ViewModel = IDownloadViewModel
}

//MARK: Make buttons actions
extension DownloadViewController {
    
    private func makeButtonsAction() {
        
    }

}

//MARK: Preview
import SwiftUI

struct DownloadViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let downloadViewController = DownloadViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DownloadViewControllerProvider.ContainerView>) -> DownloadViewController {
            return downloadViewController
        }

        func updateUIViewController(_ uiViewController: DownloadViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DownloadViewControllerProvider.ContainerView>) {
        }
    }
}
