//
//  Page1ViewModel.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit
import Combine

class MainViewModel {
    
    var model = MainModel()
    let dataFetcher = CombineNetworkManager()
    let localDataManager: LocalDataManager
    var user: User
    
    var onUpdate = PassthroughSubject<Void, Error>()
    var showWords = PassthroughSubject<[String], Error>()
    var cancellable: AnyCancellable?
    
    init() {
        localDataManager = LocalDataManager.shared
        user = localDataManager.currentUser!
    }
    
    var avatarImage: UIImage {
        guard let data = user.avatar, let image = UIImage(data: data) else {
            return UIImage(named: "profile")!
        }
        return image
    }
    
    func getData() {
        model.selectCategoryImageNames = CategoryItem.categorySectionModel
        
        cancellable = dataFetcher.getMain()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.onUpdate.send(completion: .failure(error))
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (latest, flash) in
                guard let self = self else {return}
                self.model.latestItems = latest.latest
                self.model.flashSaleItems = flash.flashSale
                self.model.brandsItems = latest.latest.map{BrandsItem(imageUrl: $0.imageUrl)} + flash.flashSale.map{BrandsItem(imageUrl: $0.imageUrl)}
                self.onUpdate.send()
            }

    }
    
    func getSearchingWords(_ searchText: String) -> AnyPublisher<[String], Never> {
        self.dataFetcher.getSearchWords()
            .map { words in
                words.filter{
                    $0.lowercased().hasPrefix(searchText.lowercased())
                }
            }.catch{ error in
                return Just([])
            }.eraseToAnyPublisher()

    }
    
    
    
    enum Section: String, Hashable, CaseIterable {
        case selectCategorySection = ""
        case latestSection = "Latest"
        case flashSaleSection = "Flash Sale"
        case brandsSection = "Brands"
    }
    enum Item : Hashable {
        case selectCategoryItem(category: CategoryItem  )
        case latestItem(latestItem: LatestItem)
        case flashSaleItem(flashSaleItem: FlashSaleItem)
        case brandsItem(brandsItem: BrandsItem)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            
            case .selectCategoryItem(let category):
                hasher.combine(category.title )
            case .latestItem(let latestItem):
                hasher.combine(latestItem.name)
            case .flashSaleItem(let flashSaleItem):
                hasher.combine(flashSaleItem.name)
            case .brandsItem(let brandsItem):
                hasher.combine(brandsItem)
            }
        }
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            switch (lhs, rhs) {
            case (.selectCategoryItem(let lCategory) , .selectCategoryItem(let rCategory)):
                return lCategory.title == rCategory.title
            case (.latestItem(let llatestItem), .latestItem(let rlatestItem) ):
                return llatestItem.name == rlatestItem.name
            case (.flashSaleItem(let lfleshSaleItem), .flashSaleItem(let rfleshSaleItem)):
                return lfleshSaleItem.name == rfleshSaleItem.name
            default: return false
            }
        }
    }
}
