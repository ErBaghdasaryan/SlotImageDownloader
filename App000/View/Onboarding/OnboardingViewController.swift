//
//  OnboardingViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit
import App000ViewModel
import SnapKit
import StoreKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let header = UILabel(text: "Header",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 24))
    private let subHeader = UILabel(text: "Subheader",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Regular", size: 15))
    private let pageControl = AdvancedPageControlView()
    private let nextButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#1C1C1E")

        self.header.numberOfLines = 1
        self.header.lineBreakMode = .byWordWrapping

        self.subHeader.numberOfLines = 2
        self.subHeader.lineBreakMode = .byWordWrapping

        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.setTitleColor(.black, for: .normal)
        self.nextButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
        self.nextButton.backgroundColor = UIColor(hex: "#0084FF")
        self.nextButton.layer.masksToBounds = true
        self.nextButton.layer.cornerRadius = 12

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(OnboardingCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false

        pageControl.drawer = ExtendedDotDrawer(numberOfPages: 2,
                                               height: 10,
                                               width: 10,
                                               space: 8,
                                               indicatorColor: UIColor(hex: "#0084FF"),
                                               dotsColor: UIColor(hex: "#E6E7E8"),
                                               isBordered: true,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .orange,
                                               indicatorBorderWidth: 0.0)
        pageControl.setPage(0)

        self.view.addSubview(pageControl)
        self.view.addSubview(collectionView)
        self.view.addSubview(header)
        self.view.addSubview(subHeader)
        self.view.addSubview(nextButton)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
        collectionView.reloadData()
        self.setHeaderAttributedText(of: 0)
        subHeader.text = viewModel?.onboardingItems[0].subHeader
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width - 128
            let heightt = self.view.frame.size.height - 326
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        pageControl.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(89)
            view.centerX.equalToSuperview()
            view.width.equalTo(70)
            view.height.equalTo(10)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(pageControl.snp.bottom).offset(123)
            view.leading.equalToSuperview().offset(32)
            view.trailing.equalToSuperview().inset(32)
            view.bottom.equalToSuperview().inset(319)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(collectionView.snp.bottom).offset(60)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        subHeader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(16)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(40)
        }

        nextButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(75)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {
    
    private func makeButtonsAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    private func setHeaderAttributedText(of index: Int) {

        guard let fullText = viewModel?.onboardingItems[index].header else { return }
        var highlightedText: String!

        switch index {
        case 0:
            highlightedText = "U"
        case 1:
            highlightedText = "2 Weeks"
        case 2:
            highlightedText = "Updated"
        default:
            break
        }

        let attributedString = NSMutableAttributedString(string: fullText)

        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: fullText.count))

        if let range = fullText.range(of: highlightedText) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#0084FF")!, range: nsRange)
        }

        header.attributedText = attributedString
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            performActionForPage(index: currentIndex)
        } else {
            OnboardingRouter.showTabBarViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
            performActionForPage(index: currentIndex)
        }
    }

    func performActionForPage(index: Int) {
        switch index {
        case 0:
            pageControl.setPage(0)
            self.setHeaderAttributedText(of: index)
            subHeader.text = viewModel?.onboardingItems[index].subHeader
        case 1:
            pageControl.setPage(1)
            self.setHeaderAttributedText(of: index)
            subHeader.text = viewModel?.onboardingItems[index].subHeader
        case 2:
            pageControl.setPage(2)
            self.setHeaderAttributedText(of: index)
            subHeader.text = viewModel?.onboardingItems[index].subHeader
        default:
            break
        }
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.onboardingItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(image: viewModel?.onboardingItems[indexPath.row].image ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
