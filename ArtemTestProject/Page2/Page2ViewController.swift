//
//  Page2ViewController.swift
//  ArtemTestProject
//
//  Created by Артём on 16.03.2023.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    var collectionView: UICollectionView!
    let bottomView = BottomView()
    let likeShareBlock = LikeShareStack()
    
    var dataSource: UICollectionViewDiffableDataSource<DetailCVViewModel.Section, DetailCVViewModel.Item>?
    let networkManager = CombineNetworkManager()
    var model: DetailModel!
    
    var cancellable: AnyCancellable?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        cancellable = networkManager.getDetails()
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] productDetailModel in
                guard let self = self else {return}
                self.model = productDetailModel
                self.setupCollectionView()
                self.createDataSource()
                self.reloadData()
                self.setupButtomView()
                self.setupLikeShareBlock()
            }
    }
    
    // MARK: - Setup Collection View and Navigation Bar
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .background
        view.addSubview(collectionView)
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        collectionView.register(DetailInfoCell.self, forCellWithReuseIdentifier: DetailInfoCell.reuseId)
    }
    
    private func setupNavigationBar() {
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(goBack))
        back.tintColor = .black
        navigationItem.leftBarButtonItem = back
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Bottom View
    func setupButtomView() {
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        view.addSubviewAtTheBottom(subview: bottomView, height: 80 + tabBarHeight)
        bottomView.configure(with: model.price, bottomOffset: tabBarHeight)
    }
    
    func setupLikeShareBlock() {
        likeShareBlock.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(likeShareBlock)
        NSLayoutConstraint.activate([
            likeShareBlock.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            likeShareBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    // MARK: - Reload Data
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<DetailCVViewModel.Section, DetailCVViewModel.Item>()
        snapShot.appendSections([.largeImages, .smallImages, .detailInfo])
        
        let largeImages = model.imageUrls.map{ImageModel(url: $0, id: 1) }
        let smallImages = model.imageUrls.map{ImageModel(url: $0, id: 2) }
        let largeImageItems = largeImages.map { DetailCVViewModel.Item.image(url: $0) }
        let smallImageItems = smallImages.map { DetailCVViewModel.Item.image(url: $0) }
        
        snapShot.appendItems(largeImageItems, toSection: .largeImages)
        snapShot.appendItems(smallImageItems, toSection: .smallImages)

        let detailInfo = DetailInfoModel(from: model)
        let detailItem = DetailCVViewModel.Item.details(details: detailInfo)
        snapShot.appendItems([detailItem], toSection: .detailInfo)
   
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
}

// MARK: - Create Data Source
extension DetailViewController {
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            switch item {
            case .image(let imageModel):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell else { fatalError("Unable to dequeue cell")}
                cell.configure(with: imageModel.url)
                return cell
                
            case .details(let details):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailInfoCell.reuseId, for: indexPath) as? DetailInfoCell else { fatalError("Unable to dequeue cell")}
                cell.configure(with: details)
                return cell
            }
            
        })
    }
}

// MARK: - Create Compositional Layout
extension DetailViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {  section, layoutEnvironment in
            switch self.dataSource?.snapshot().sectionIdentifiers[section] {
            case .largeImages:
                return self.createLargeImagesSectionLayout()
            case .smallImages:
                return self.createSmallImagesSectionLayout()
            case .detailInfo:
                return self.createDetailSectionLayout()
            default: return nil
            }
        }
        return layout
    }
    
    private func createLargeImagesSectionLayout() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 14, bottom: 0, trailing: 14)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            
            guard let itemWidth = items.last?.bounds.width else { return }
            let insets = (environment.container.contentSize.width - itemWidth)
            let page = Int(offset.x / (itemWidth + insets))
          //  print(items)
            if let ind = self.dataSource?.snapshot().indexOfSection(.smallImages) {
                
              //  self.collectionView.scrollToItem(at: IndexPath(row: items.last!.indexPath.row, section: ind), at: .centeredHorizontally, animated: true)
            }
            
            
        }

        return section
    }
    
    func createSmallImagesSectionLayout() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/5), heightDimension: .fractionalWidth(1/10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 5
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        return section
    }
    
    func createDetailSectionLayout() -> NSCollectionLayoutSection? {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(220) )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 0, leading: 14, bottom: 0, trailing: 14)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(220) )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
       
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 14, bottom: 100, trailing: 14)
        return section
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }

}
// MARK: -  UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let section = dataSource?.sectionIdentifier(for: indexPath.section) else {return}
        switch section {
        case .smallImages:
            print("smallImages tapped", indexPath )
            collectionView.scrollToItem(at: IndexPath(item: indexPath.item, section: 1), at: .centeredHorizontally, animated: true)
            collectionView.scrollToItem(at: IndexPath(item: indexPath.item, section: 0), at: .centeredHorizontally, animated: true)
            //dataSource?.snapshot(for: .smallImages).visibleItems.
        case .largeImages:
            print("largeImages tapped", indexPath)
        case .detailInfo:
            print("detailInfo tapped")
        }
    }
    
}


//MARK: - SwiftUI
import SwiftUI
struct DetailProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = UINavigationController(rootViewController: DetailViewController())
        
   
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }
}
