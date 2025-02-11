//
//  TermsViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 07.02.25.
//
import UIKit
import WebKit
import SnapKit

final class TermsViewController: BaseViewController {

    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.webView.backgroundColor = .clear
        self.title = "Terms&Conditions"
        if let url = URL(string: "https://www.termsfeed.com/live/701e5003-2103-4902-a0d7-4e3ba3a1e63f") {
            webView.load(URLRequest(url: url))
        }

        setupConstraints()
    }

    private func setupConstraints() {
        self.view.addSubview(webView)

        webView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }
    }

    override func setupViewModel() {

    }

}

import SwiftUI

struct TermsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let termsViewController = TermsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TermsViewControllerProvider.ContainerView>) -> TermsViewController {
            return termsViewController
        }

        func updateUIViewController(_ uiViewController: TermsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TermsViewControllerProvider.ContainerView>) {
        }
    }
}

