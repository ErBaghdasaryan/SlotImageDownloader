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
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let popular = UILabel(text: "Popular",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 20))
    var popularCollectionView: UICollectionView!
    
    private let games = UILabel(text: "Games",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 20))
    var nonpopularCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = .white

        self.header.textAlignment = .left
        self.popular.textAlignment = .left
        self.games.textAlignment = .left

        //MARK: Populat CollectionView's setup
        let popularlayout = UICollectionViewFlowLayout()
        popularlayout.itemSize = CGSize(width: 93, height: 122)
        popularlayout.scrollDirection = .horizontal
        popularlayout.minimumLineSpacing = 8
        popularlayout.minimumInteritemSpacing = 8

        popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: popularlayout)
        popularCollectionView.showsHorizontalScrollIndicator = false
        popularCollectionView.backgroundColor = .clear

        popularCollectionView.register(PopularCell.self)
        popularCollectionView.backgroundColor = .clear
        popularCollectionView.isScrollEnabled = true

        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self

        //MARK: Nonpopular CollectionView's setup
        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 12
        let totalSpacing = ((numberOfColumns - 1) * spacing)
        let availableWidth = self.view.frame.width - totalSpacing
        let itemWidth = availableWidth / numberOfColumns

        let nonpopularlayout = UICollectionViewFlowLayout()
        nonpopularlayout.itemSize = CGSize(width: itemWidth, height: 226)
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
        self.view.addSubview(popular)
        self.view.addSubview(popularCollectionView)
        self.view.addSubview(games)
        self.view.addSubview(nonpopularCollectionView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        viewModel?.loadPopularGames()
        self.popularCollectionView.reloadData()
        viewModel?.loadNonPopularGames()
        self.nonpopularCollectionView.reloadData()
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(74)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        popular.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(25)
        }

        popularCollectionView.snp.makeConstraints { view in
            view.top.equalTo(popular.snp.bottom).offset(10)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview()
            view.height.equalTo(122)
        }

        games.snp.makeConstraints { view in
            view.top.equalTo(popularCollectionView.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(25)
        }

        nonpopularCollectionView.snp.makeConstraints { view in
            view.top.equalTo(games.snp.bottom).offset(10)
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

}

extension ScreensaverViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollectionView {
            return self.viewModel?.popularItems.count ?? 0
        } else if collectionView == nonpopularCollectionView {
            return self.viewModel?.nonPopularItems.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PopularCell = collectionView.dequeueReusableCell(for: indexPath)

        if collectionView == popularCollectionView {
            cell.setup(image: viewModel?.popularItems[indexPath.row].image ?? "")
        } else if collectionView == nonpopularCollectionView {
            cell.setup(image: viewModel?.nonPopularItems[indexPath.row].image ?? "")
        }

        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 4

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == popularCollectionView {
            return CGSize(width: 93, height: 122)
        } else if collectionView == nonpopularCollectionView {
            let numberOfColumns: CGFloat = 2
            let spacing: CGFloat = 12
            let totalSpacing = ((numberOfColumns - 1) * spacing)
            let availableWidth = self.view.frame.width - totalSpacing - 32
            let itemWidth = availableWidth / numberOfColumns

            return CGSize(width: itemWidth, height: 226)
        }
        return .zero
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
