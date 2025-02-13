//
//  AboutViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 13.02.25.
//

import UIKit
import App000ViewModel
import SnapKit
import Toast

class AboutViewController: BaseViewController, UICollectionViewDelegate {

    private let header = UILabel(text: "About",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let text = UILabel(text: "",
                               textColor: .white,
                               font: UIFont(name: "SFProText-Regular", size: 15))
    private let back = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#1C1C1E")

        self.header.textAlignment = .left

        self.text.numberOfLines = 0
        self.text.lineBreakMode = .byWordWrapping
        self.text.textAlignment = .left
        self.text.text = """
        We believe in quality over quantity. Instead of overwhelming users with thousands of random images, we offer a carefully curated selection of 30 premium wallpapers, refreshed every two weeks.


        Handpicked by our team – Only high-quality, optimized designs.
         Exclusive & regularly updated – New themes every 14 days.
         Optimized for all devices – Perfect fit for any screen size.


        We are committed to delivering a seamless experience with fresh, high-resolution wallpapers that enhance your device's look. Stay tuned for regular updates and new collections! 


        Transparency & Trust We respect our users and provide a clean, ad-free experience with clear privacy policies. No hidden fees – just top-tier wallpapers!
        """

        self.back.setTitle("Back", for: .normal)
        self.back.setTitleColor(.white, for: .normal)
        self.back.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
        self.back.backgroundColor = UIColor(hex: "#393939")
        self.back.layer.masksToBounds = true
        self.back.layer.cornerRadius = 12

        self.view.addSubview(header)
        self.view.addSubview(text)
        self.view.addSubview(back)
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

        text.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(244)
        }

        back.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(101)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }
}

//MARK: Make buttons actions
extension AboutViewController {
    
    private func makeButtonsAction() {
        self.back.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }

        navigationController.popViewController(animated: true)
    }
}

//MARK: Preview
import SwiftUI

struct AboutViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let aboutViewController = AboutViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<AboutViewControllerProvider.ContainerView>) -> AboutViewController {
            return aboutViewController
        }

        func updateUIViewController(_ uiViewController: AboutViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AboutViewControllerProvider.ContainerView>) {
        }
    }
}
