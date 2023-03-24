//
//  Page1ViewModel.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import UIKit
import Combine

class MainViewModel {
    
    private let dataFetcher = CombineNetworkManager()
    private let localDataManager: LocalDataManager
    private var model = MainModel()
    private var user: User
    
    var onUpdate = PassthroughSubject<Void, Never>()
    var showWords = PassthroughSubject<[String], Error>()
    private var cancellable: AnyCancellable?
    
    var avatarImage: UIImage {
        guard let data = user.avatar, let image = UIImage(data: data) else {
            return UIImage(named: "profile")!
        }
        return image
    }
    
    let title: NSMutableAttributedString = {
        var str = NSMutableAttributedString.init(string: "Trade by bata")
        let attr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blue]
        str.addAttributes(attr, range: NSRange.init(location: 9, length: 4)  )
        return str
    }()
    
    var selectCategoryItems: [Item] {
        model.selectCategoryImageNames.map { MainViewModel.Item.selectCategoryItem(category: $0) }
    }
    
    var latestItems: [Item] {
        model.latestItems.map { MainViewModel.Item.latestItem(latestItem: $0) }
    }
    
    var flashSaleItems: [Item] {
        model.flashSaleItems.map { MainViewModel.Item.flashSaleItem(flashSaleItem: $0) }
    }
    
    var brandsItems: [Item]  {
        model.brandsItems.map{ MainViewModel.Item.brandsItem(brandsItem: $0) }
    }

    init() {
        localDataManager = LocalDataManager.shared
        user = localDataManager.currentUser!
    }
    
    func getData() {
        model.selectCategoryImageNames = CategoryItem.categorySectionModel
        
        cancellable = dataFetcher.getMain()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.onUpdate.send()
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
