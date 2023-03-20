//
//  Page2ViewModel.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit

struct DetailCVViewModel {

    enum Section: Int, CaseIterable {
        case largeImages
        case smallImages
        case detailInfo
    }

    enum Item: Hashable {
        case image(url: ImageModel)
        case details(details: DetailInfoModel)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .image(let url):
                hasher.combine(url)
            case .details(let details):
                hasher.combine(details)
            }
        } 
    }
}
