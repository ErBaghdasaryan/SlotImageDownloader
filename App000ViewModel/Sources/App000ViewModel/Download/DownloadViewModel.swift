//
//  DownloadViewModel.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000Model

public protocol IDownloadViewModel {
    var imageName: String { get }
}

public class DownloadViewModel: IDownloadViewModel {

    private let downloadService: IDownloadService
    public var imageName: String

    public init(downloadService: IDownloadService, navigationModel: DownloadNavigationModel) {
        self.downloadService = downloadService
        self.imageName = navigationModel.imageName
    }
}
