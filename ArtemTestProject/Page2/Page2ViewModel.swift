//
//  Page2ViewModel.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit
import Combine

final class DetailViewModel {
    
    private let networkManager = CombineNetworkManager()
    private var model: DetailModel!
    var onUpdate = PassthroughSubject<Void, Never>()
    private var cancellable: AnyCancellable?
    
    var largeImageItems: [Item] {
        let largeImages = model.imageUrls.map{ImageModel(url: $0, id: 1) }
        return largeImages.map { Item.image(url: $0) }
    }
    
    var smallImageItems: [Item] {
        let smallImages = model.imageUrls.map{ImageModel(url: $0, id: 2) }
        return smallImages.map { Item.image(url: $0) }
    }
   
    var detailItem: Item {
        let detailInfo = DetailInfoModel(from: model)
        return Item.details(details: detailInfo)
    }
    
    var price: Double { model.price }
    
    func viewDidLoad() {
        cancellable = networkManager.getDetails()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(_):
                    self?.onUpdate.send()
                }
            } receiveValue: { [weak self] productDetailModel in
                guard let self = self else {return}
                self.model = productDetailModel
                self.onUpdate.send()
            }
    }

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
