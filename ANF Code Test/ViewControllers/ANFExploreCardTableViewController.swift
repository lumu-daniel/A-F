//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import Combine
import SDWebImage

class ANFExploreCardTableViewController: UITableViewController {
    
    
    private var cancellable: AnyCancellable?
    
//    let viewModel: ExploreItemViewModel = ExploreItemViewModel(dataAccessRepository: LocalExploreDataImpl()) //Local Data
    let viewModel: ExploreItemViewModel = ExploreItemViewModel(dataAccessRepository: RemoteExploreDataImpl()) //Remote Data
    
    private var exploreData: [ExploreDataItem]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.getDataList{[weak self] result in
            switch result{
            case .success(let result):
                self?.viewModel.updateList(with: result)
            case .failure(let error):
                self?.viewModel.updateError(with: error)
            }
        }
        
        getExploreData()
        
        tableView.register(ExploreContentTableViewCell.self, forCellReuseIdentifier: ExploreContentTableViewCell.identifier)
        
    }
    
    private func getExploreData() {
        cancellable = viewModel.$items.sink(receiveValue: { [weak self] it in
            self?.exploreData = it
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ExploreContentTableViewCell.identifier, for: indexPath) as? ExploreContentTableViewCell else {return UITableViewCell()}
        if let imageView = cell.viewWithTag(1) as? UIImageView,
           let name = exploreData?[indexPath.row].backgroundImage{
            let image = UIImage(named: name)
            imageView.sd_setImage(with: URL(string: name.getHttps()), placeholderImage: image?.resizeHighImage(image: image!)) {(image: UIImage?, error: Error?, cacheType:SDImageCacheType!, imageURL: URL?) in
                imageView.image = imageView.image?.resizeHighImage(image: imageView.image!)
            }
        }
        if let topDescriptionLabel = cell.viewWithTag(2) as? UILabel,
           let topDescriptionText = exploreData?[indexPath.row].topDescription {
            topDescriptionLabel.text = topDescriptionText
        }
        if let titleLabel = cell.viewWithTag(3) as? UILabel,
           let titleText = exploreData?[indexPath.row].title {
            titleLabel.text = titleText
        }
        if let promoMessageLabel = cell.viewWithTag(4) as? UILabel,
           let promoMessageText = exploreData?[indexPath.row].promoMessage {
            promoMessageLabel.text = promoMessageText
        }
        if let bottomDescriptionLabel = cell.viewWithTag(5) as? UILabel,
           let bottomDescriptionText = exploreData?[indexPath.row].bottomDescription {
            bottomDescriptionLabel.text = bottomDescriptionText
        }
        guard let contentData = exploreData?[indexPath.row].content else {return UITableViewCell()}
        cell.configureContent(with: contentData)
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700

    }
}
