//
//  ScreensaverViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit
import App000ViewModel
import SnapKit

class ScreensaverViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Screensavers",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    var nonpopularCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#1C1C1E")

        self.header.textAlignment = .left

        //MARK: Screensavers CollectionView's setup
        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 18
        let totalSpacing = ((numberOfColumns - 1) * spacing)
        let availableWidth = self.view.frame.width - totalSpacing
        let itemWidth = availableWidth / numberOfColumns

        let nonpopularlayout = UICollectionViewFlowLayout()
        nonpopularlayout.itemSize = CGSize(width: itemWidth, height: 279)
        nonpopularlayout.scrollDirection = .vertical
        nonpopularlayout.minimumLineSpacing = spacing
        nonpopularlayout.minimumInteritemSpacing = spacing

        nonpopularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: nonpopularlayout)
        nonpopularCollectionView.showsHorizontalScrollIndicator = false
        nonpopularCollectionView.backgroundColor = .clear

        nonpopularCollectionView.register(PopularCell.self)
        nonpopularCollectionView.backgroundColor = .clear
        nonpopularCollectionView.isScrollEnabled = true

        nonpopularCollectionView.delegate = self
        nonpopularCollectionView.dataSource = self

        self.view.addSubview(header)
        self.view.addSubview(nonpopularCollectionView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        viewModel?.loadItems()
        self.nonpopularCollectionView.reloadData()
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(74)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        nonpopularCollectionView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
    }
}


extension ScreensaverViewController: IViewModelableController {
    typealias ViewModel = IScreensaverViewModel
}

//MARK: Make buttons actions
extension ScreensaverViewController {
    
    private func makeButtonsAction() {
        
    }

    private func downloadImage(imageName: String) {
        guard let navigationController = self.navigationController else { return }

        ScreensaverRouter.showDownloadViewController(in: navigationController,
                                                     navigationModel: .init(imageName: imageName))
    }

}

extension ScreensaverViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PopularCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.setup(image: viewModel?.items[indexPath.row].image ?? "")

        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 18
        let totalSpacing = ((numberOfColumns - 1) * spacing)
        let availableWidth = self.view.frame.width - totalSpacing - 32
        let itemWidth = availableWidth / numberOfColumns

        return CGSize(width: itemWidth, height: 279)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let imageName = self.viewModel?.items[indexPath.row].image {
            self.downloadImage(imageName: imageName)
        }
    }
}

//MARK: Preview
import SwiftUI

struct ScreensaverViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let screensaverViewController = ScreensaverViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ScreensaverViewControllerProvider.ContainerView>) -> ScreensaverViewController {
            return screensaverViewController
        }

        func updateUIViewController(_ uiViewController: ScreensaverViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ScreensaverViewControllerProvider.ContainerView>) {
        }
    }
}
