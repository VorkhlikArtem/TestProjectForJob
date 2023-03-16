//
//  Page1ViewModel.swift
//  ArtemTestProject
//
//  Created by Артём on 15.03.2023.
//

import Foundation

enum MainViewModel {
    enum Section: String, Hashable, CaseIterable {
        case selectCategorySection = ""
        case latestSection = "Latest"
        case flashSaleSection = "Flash Sale"
    }
    enum Item : Hashable {
        case selectCategoryItem(category: CategoryItem  )
        case latestItem(latestItem: LatestItem)
        case flashSaleItem(flashSaleItem: FlashSaleItem)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            
            case .selectCategoryItem(let category):
                hasher.combine(category.title )
            case .latestItem(let latestItem):
                hasher.combine(latestItem.name)
            case .flashSaleItem(let flashSaleItem):
                hasher.combine(flashSaleItem.name)
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
