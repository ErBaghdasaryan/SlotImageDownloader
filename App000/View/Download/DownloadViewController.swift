//
//  DownloadViewController.swift
//  App000
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import UIKit
import App000ViewModel
import SnapKit
import Photos
import Toast

class DownloadViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let emptyLabel = UILabel(text: "You do not have a selected image to upload, please select an image in the 'Screensavers' section. ",
                                     textColor: .white,
                                     font: UIFont(name: "SFProText-Regular", size: 17))
    private let downloadButton = UIButton(type: .system)
    private let image = UIImageView()
    private var style = ToastStyle()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let name = self.viewModel?.imageName else { return }
        self.image.image = UIImage(named: name)
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#1C1C1E")

        self.title = "Download"

        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        self.downloadButton.setTitle("Download", for: .normal)
        self.downloadButton.setTitleColor(.black, for: .normal)
        self.downloadButton.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 15)
        self.downloadButton.backgroundColor = UIColor(hex: "#0084FF")
        self.downloadButton.layer.masksToBounds = true
        self.downloadButton.layer.cornerRadius = 12

        self.image.layer.masksToBounds = true
        self.image.layer.cornerRadius = 30
        self.image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        self.emptyLabel.numberOfLines = 3

        self.style.backgroundColor = UIColor.white
        self.style.messageColor = UIColor.black

        self.view.addSubview(downloadButton)
        self.view.addSubview(emptyLabel)
        self.view.addSubview(image)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {
        downloadButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(101)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(50)
        }

        emptyLabel.snp.makeConstraints { view in
            view.leading.equalToSuperview().offset(26)
            view.trailing.equalToSuperview().inset(26)
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview()
            view.height.equalTo(70)
        }

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().inset(140)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(179)
        }
    }
}


extension DownloadViewController: IViewModelableController {
    typealias ViewModel = IDownloadViewModel
}

//MARK: Make buttons actions
extension DownloadViewController {
    
    private func makeButtonsAction() {
        self.downloadButton.addTarget(self, action: #selector(downloadImage), for: .touchUpInside)
    }

    @objc func downloadImage() {
        guard let imageToSave = image.image else {
            self.view.makeToast("You do not have a selected image to upload.", duration: 2.0, position: .bottom, style: style)
            return
        }

        PHPhotoLibrary.requestAuthorization { [self] status in
            if status == .authorized {
                UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(self.imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                self.view.makeToast("There is no permission to save the image.", duration: 2.0, position: .bottom, style: style)
            }
        }
    }

    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.view.makeToast("Saving error.", duration: 2.0, position: .bottom, style: style)
        } else {

            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success", message: "Image has been saved to your gallery.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
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
