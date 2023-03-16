//
//  Page1ViewController.swift
//  ArtemTestProject
//
//  Created by Артём on 14.03.2023.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
   
    typealias DataSourceType = UICollectionViewDiffableDataSource<MainViewModel.Section, MainViewModel.Item>
    
    var dataSource: DataSourceType!
    var model = MainModel()
    let dataFetcher = CombineNetworkManager()
    
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        dataSource = createDataSource()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        setupRefreshControl()
    
        model.selectCategoryImageNames = CategoryItem.categorySectionModel
        self.reloadData()
        getData()
    }
    
    
    private func getData() {
        cancellable = dataFetcher.getMain()
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.refreshControl.endRefreshing()
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (latest, flash) in
                guard let self = self else {return}
                self.model.latestItem = latest.latest
                self.model.flashSaleItem = flash.flashSale
                self.reloadData()
             
                self.refreshControl.endRefreshing()
            }

    }
    
    // MARK: - Setup Refresh Control
    private func setupRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateMain), for: .valueChanged)
    }
    
    @objc private func updateMain() {
       getData()
    }
    
    // MARK: -  NavigationBar & CollectionView setups
    private func setupNavigationBar() {
        navigationItem.title = "Trade by bata"
        
        let left = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: nil, action: nil)
        left.tintColor = .black
        navigationItem.leftBarButtonItem = left
        
        let right = AvatarLocationView(UIImage(named: "menu") )
        right.tintColor = #colorLiteral(red: 0.00884380471, green: 0.02381574176, blue: 0.1850150228, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(SearchFieldHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchFieldHeader.reuseId)
        collectionView.register(HeaderWithButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderWithButton.reuseId)
        collectionView.register(SelectCategoryCell.self, forCellWithReuseIdentifier: SelectCategoryCell.reuseId)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        collectionView.register(FlashSaleCell.self, forCellWithReuseIdentifier: FlashSaleCell.reuseId)

    }
    
  
    // MARK: - Reload Data
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<MainViewModel.Section, MainViewModel.Item>()
        snapShot.appendSections(MainViewModel.Section.allCases)
        
        let selectCategoryItems = model.selectCategoryImageNames.map {MainViewModel.Item.selectCategoryItem(category: $0) }
        snapShot.appendItems(selectCategoryItems, toSection: .selectCategorySection)
        
        let latestItem = model.latestItem.map {MainViewModel.Item.latestItem(latestItem: $0) }
        snapShot.appendItems(latestItem, toSection: .latestSection)

        let flashSaleItem = model.flashSaleItem.map {MainViewModel.Item.flashSaleItem(flashSaleItem: $0) }
        snapShot.appendItems(flashSaleItem, toSection: .flashSaleSection)
        
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
}

// MARK: - Create Data Source
extension MainViewController {
    func createDataSource()->DataSourceType{
        let dataSource = DataSourceType(collectionView: collectionView) { collectionView, indexPath, item  in
            switch item {
            case .selectCategoryItem(let category) :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseId, for: indexPath) as! SelectCategoryCell
                cell.configure(with: category)
                return cell
                
            case .latestItem(let latestItem) :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseId, for: indexPath) as! LatestCell
                cell.configure(with: latestItem)
                return cell
                
            case .flashSaleItem(let flashSaleItem):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashSaleCell.reuseId, for: indexPath) as! FlashSaleCell
               // cell.delegate = self
                cell.configure(with: flashSaleItem)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                switch section {
                case .selectCategorySection:
                    return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchFieldHeader.reuseId, for: indexPath) as! SearchFieldHeader
                default:
                    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderWithButton.reuseId, for: indexPath) as! HeaderWithButton
                    sectionHeader.configure(title: section.rawValue, buttonText: "see more")
                    return sectionHeader
                }
            default: return nil
            }
        }
        return dataSource
    }
}

// MARK: - Create Compositional Layout
extension MainViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {  sectionIndex, layoutEnvironment in
            
            switch self.dataSource.snapshot().sectionIdentifiers[sectionIndex] {
            case .selectCategorySection :
                return self.createSelectCategorySectionLayout()
            case .latestSection :
                return self.createLatestSectionLayout()
            case .flashSaleSection:
                return self.createFlashSaleSectionLayout()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createSelectCategorySectionLayout() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupWidth = 90.0
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .estimated(groupWidth + 10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = createSectionHeaderLayout()
        section.boundarySupplementaryItems = [sectionHeader]
      
        return section
    }
    
    private func createLatestSectionLayout()-> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/5), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 14
        section.contentInsets = .init(top: 16, leading: 14, bottom: 14, trailing: 14)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = createSectionHeaderLayout()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createFlashSaleSectionLayout()-> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(2/3) )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 14, bottom: 14, trailing: 14)
        section.interGroupSpacing = 14
        section.orthogonalScrollingBehavior = .continuous
       
        let sectionHeader = createSectionHeaderLayout()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let section = dataSource.sectionIdentifier(for: indexPath.section) else {return}
        switch section {
        case .selectCategorySection:
            print("selectCategorySection tapped")
        case .latestSection:
            print("hotSalesSection tapped")
        case .flashSaleSection:
            showNextVC()
            print("bestSellersSection tapped")
        }
    }
    
}

// MARK: - Routing
extension MainViewController {
    private func showNextVC() {
        let productDetailVC = UIViewController()
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

//MARK: - SwiftUI
import SwiftUI
struct MainControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = UINavigationController(rootViewController: MainViewController())
        
   
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }
}
