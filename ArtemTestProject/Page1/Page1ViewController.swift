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
    var avatarView: AvatarLocationView!
   
    typealias DataSourceType = UICollectionViewDiffableDataSource<MainViewModel.Section, MainViewModel.Item>
    
    var dataSource: DataSourceType!
    var viewModel: MainViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        viewModel.onUpdate
            .sink { [weak self] in
                self?.refreshControl.endRefreshing()
                self?.reloadData()
            }.store(in: &cancellables)

        viewModel.getData()
        reloadData()
        
        setupNavigationBar()
        setupCollectionView()
        setupRefreshControl()
        hideKeyboardAfterTapping()
        
        dataSource = createDataSource()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAvatar()
    }
    
    
    // MARK: - Setup Refresh Control
    private func setupRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateMain), for: .valueChanged)
    }
    
    @objc private func updateMain() {
        viewModel.getData()
    }
    
    // MARK: -  NavigationBar & CollectionView setups
    private func setupNavigationBar() {
        let label = UILabel(font: .montserratBold(20), textColor: .black)
        label.attributedText = viewModel.title
        navigationItem.titleView = label
        
        let left = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: nil, action: nil)
        left.tintColor = .black
        navigationItem.leftBarButtonItem = left
        
        avatarView = AvatarLocationView()
        setAvatar()
        avatarView.tintColor = #colorLiteral(red: 0.00884380471, green: 0.02381574176, blue: 0.1850150228, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: avatarView)
    }
    
    private func setAvatar() {
        avatarView.configue(with: viewModel.avatarImage)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .background
        view.addSubview(collectionView)
        
        collectionView.register(SearchFieldHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchFieldHeader.reuseId)
        collectionView.register(HeaderWithButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderWithButton.reuseId)
        collectionView.register(SelectCategoryCell.self, forCellWithReuseIdentifier: SelectCategoryCell.reuseId)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        collectionView.register(FlashSaleCell.self, forCellWithReuseIdentifier: FlashSaleCell.reuseId)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)

    }
    
  
    // MARK: - Reload Data
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<MainViewModel.Section, MainViewModel.Item>()
        snapShot.appendSections(MainViewModel.Section.allCases)
        
        let selectCategoryItems = viewModel.selectCategoryItems
        snapShot.appendItems(selectCategoryItems, toSection: .selectCategorySection)
        
        let latestItems = viewModel.latestItems
        snapShot.appendItems(latestItems, toSection: .latestSection)

        let flashSaleItems = viewModel.flashSaleItems
        snapShot.appendItems(flashSaleItems, toSection: .flashSaleSection)
        
        let brandsItems = viewModel.brandsItems
        snapShot.appendItems(brandsItems, toSection: .brandsSection)
        
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
                cell.configure(with: flashSaleItem)
                return cell
                
            case .brandsItem(let brandsItem):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell
                cell.configure(with: brandsItem.imageUrl)
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
                    let searchHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchFieldHeader.reuseId, for: indexPath) as! SearchFieldHeader
                    
                    searchHeader.changedSearchTextPublisher.flatMap { words in
                        self.viewModel.getSearchingWords(words)
                    }.sink(receiveValue: { words in
                        searchHeader.prefixWords = words
                    })
                    .store(in: &searchHeader.cancellables)
                    
                    searchHeader.textFieldTappedPublisher.sink { [weak self] tableView in
                        guard let self = self else {return}
                        self.view.addSubview(tableView)
                        let topBarHeight = (self.navigationController?.navigationBar.frame.height ?? 0) + (self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
                        tableView.frame = CGRect(x: 60, y: 55 + topBarHeight, width: self.view.frame.width - 120, height: 0)
                    }.store(in: &searchHeader.cancellables)
                    
                    return searchHeader
                default:
                    let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderWithButton.reuseId, for: indexPath) as! HeaderWithButton
                    sectionHeader.configure(title: section.rawValue)
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
            case .brandsSection:
                return self.createLatestSectionLayout()
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
            print("latestSection tapped")
        case .flashSaleSection:
            showNextVC()
        case .brandsSection:
            print("brandsSection tapped")
        }
    }
 
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: .hideSearchingList, object: nil)
    }
    
}

// MARK: - Routing
extension MainViewController {
    private func showNextVC() {
        let productDetailVC = DetailViewController()
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

