//
//  SettingsViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit
import App000ViewModel
import SnapKit
import Toast

class SettingsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Settings",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let about = PrivacyAndTermsButton()
    private let terms = PrivacyAndTermsButton()
    private let privacy = PrivacyAndTermsButton()
    private let notify = NotifButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#1C1C1E")

        self.header.textAlignment = .left

        self.about.setTitle("About our project", for: .normal)
        self.terms.setTitle("Terms&Conditions", for: .normal)
        self.privacy.setTitle("Privacy Policy", for: .normal)
        self.notify.setTitle("Push Notification", for: .normal)

        self.view.addSubview(header)
        self.view.addSubview(about)
        self.view.addSubview(terms)
        self.view.addSubview(privacy)
        self.view.addSubview(notify)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(74)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        about.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(56)
        }

        terms.snp.makeConstraints { view in
            view.top.equalTo(about.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(56)
        }

        privacy.snp.makeConstraints { view in
            view.top.equalTo(terms.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(56)
        }

        notify.snp.makeConstraints { view in
            view.top.equalTo(privacy.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(56)
        }
    }
}


extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Make buttons actions
extension SettingsViewController {
    
    private func makeButtonsAction() {
        self.about.addTarget(self, action: #selector(aboutTapped), for: .touchUpInside)
        self.terms.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        self.privacy.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
    }

    @objc func aboutTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showAboutViewController(in: navigationController)
    }

    @objc func termsTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showTermsViewController(in: navigationController)
    }

    @objc func privacyTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showPrivacyViewController(in: navigationController)
    }

}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
