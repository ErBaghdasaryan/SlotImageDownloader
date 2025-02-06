//
//  UntilOnboardingViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 04.02.25.
//

import UIKit
import App000ViewModel
import SnapKit

class UntilOnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let logoImage = UIImageView(image: .init(named: "appIcon"))
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let progressLabel = UILabel(text: "0%",
                                        textColor: UIColor(hex: "#04193A")!,
                                        font: UIFont(name: "SFProText-Semibold", size: 17))
    private var progressStack: UIStackView!

    private var progress: Float = 1.0 {
        willSet {
            self.progressLabel.text = "\(Int(newValue))%"
        }
    }
    private var timer: Timer?
    private var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = .white

        activityIndicator.color = UIColor(hex: "#04193A")

        progressStack = UIStackView(arrangedSubviews: [activityIndicator, progressLabel],
                                    axis: .horizontal,
                                    spacing: 2)
        progressStack.distribution = .fillProportionally

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {
        self.view.addSubview(logoImage)
        self.view.addSubview(progressStack)

        logoImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(173)
            view.centerX.equalToSuperview()
            view.height.equalTo(282)
            view.width.equalTo(252)
        }

        progressStack.snp.makeConstraints { view in
            view.top.equalTo(logoImage.snp.bottom).offset(180)
            view.centerX.equalToSuperview()
            view.width.equalTo(85)
            view.height.equalTo(22)
        }
    }
}


extension UntilOnboardingViewController: IViewModelableController {
    typealias ViewModel = IUntilOnboardingViewModel
}

//MARK: Progress View
extension UntilOnboardingViewController {
    private func startLoading() {
        activityIndicator.startAnimating()
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }

    @objc private func updateProgress(timer: Timer) {
        guard let _ = self.navigationController else { return }
        if self.progress < 99  {
            self.progress += 1
        } else {
            timer.invalidate()
            goToNextPage()
            activityIndicator.stopAnimating()
        }
    }

    private func goToNextPage() {
        guard let navigationController = self.navigationController else { return }
        guard var viewModel = self.viewModel else { return }
        if viewModel.appStorageService.hasData(for: .skipOnboarding) {
            UntilOnboardingRouter.showOnboardingViewController(in: navigationController)
        } else {
            viewModel.skipOnboarding = true
            UntilOnboardingRouter.showOnboardingViewController(in: navigationController)
        }
    }
}

//MARK: Preview
import SwiftUI

struct UntilOnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let untilOnboardingViewController = UntilOnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) -> UntilOnboardingViewController {
            return untilOnboardingViewController
        }

        func updateUIViewController(_ uiViewController: UntilOnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
