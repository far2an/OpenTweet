//
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            configureDataSourceCellProviders()
            collectionView.collectionViewLayout = collectionViewLayout
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.allowsMultipleSelection = false
        }
    }
    
    var viewModel: FeedViewModelProtocol = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTimeline()
    }
}

private extension TimelineViewController {
    var collectionViewLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else {
                return nil
            }
            return self.tweetSection(for: layoutEnvironment)
        }
    }
    
    func fetchTimeline() {
        guard viewModel.timeline.tweets.isEmpty else {
            return
        }
            
        viewModel.fetchTimeline()
    }
    
    func configureDataSourceCellProviders() {
        collectionView.register(TweetCell.nib, forCellWithReuseIdentifier: TweetCell.identifier)
    }
    
    func tweetSection(for layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        baseSection(itemSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150)))
    }
    
    func baseSection(itemSize: NSCollectionLayoutSize, itemContentInsets: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = itemContentInsets
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    func navigateToThread(with timeline: TimelineViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TimelineViewController") as! TimelineViewController
        vc.title = "Thread"
        vc.viewModel = FeedViewModel(timeline: timeline)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TimelineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.timeline.tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TweetCell.identifier, for: indexPath) as! TweetCell
        cell.update(with: viewModel.timeline.tweets[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TweetCell
        cell.animate(type: .expand)
        
        guard let viewModel = viewModel.tweetTapped(with: viewModel.timeline.tweets[indexPath.item].id) else {
            return
        }
        navigateToThread(with: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TweetCell
        cell.animate(type: .shrink)
    }
}

