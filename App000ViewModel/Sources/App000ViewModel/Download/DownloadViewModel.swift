//
//  DownloadViewModel.swift
//  App000ViewModel
//
//  Created by Er Baghdasaryan on 06.02.25.
//

import Foundation
import App000Model

public protocol IDownloadViewModel {
    
}

public class DownloadViewModel: IDownloadViewModel {

    private let downloadService: IDownloadService

    public init(downloadService: IDownloadService) {
        self.downloadService = downloadService
    }
}
