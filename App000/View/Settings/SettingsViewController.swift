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

    private let header = UILabel(text: "About us",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let welcomeImage = UIImageView()
    private let terms = PrivacyAndTermsButton(title: "Terms&Conditions",
                                              icon: UIImage(named: "terms"))
    private let privacy = PrivacyAndTermsButton(title: "Privacy Policy",
                                              icon: UIImage(named: "privacyPolicy"))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = .white

        self.header.textAlignment = .left

        self.welcomeImage.layer.masksToBounds = true
        self.welcomeImage.layer.cornerRadius = 4
        self.welcomeImage.image = UIImage(named: "welcomeImage")
        self.welcomeImage.contentMode = .scaleAspectFill

        self.view.addSubview(header)
        self.view.addSubview(welcomeImage)
        self.view.addSubview(terms)
        self.view.addSubview(privacy)
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

        welcomeImage.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(206)
        }

        terms.snp.makeConstraints { view in
            view.top.equalTo(welcomeImage.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(74)
        }

        privacy.snp.makeConstraints { view in
            view.top.equalTo(terms.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(74)
        }
    }
}


extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Make buttons actions
extension SettingsViewController {
    
    private func makeButtonsAction() {
        self.terms.readButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        self.privacy.readButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
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
