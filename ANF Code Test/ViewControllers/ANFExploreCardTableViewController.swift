//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    private var exploreData: [[AnyHashable: Any]]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
         let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
         let jsonDictionary = try? JSONSerialization.jsonObject(with: fileContent, options: .mutableContainers) as? [[AnyHashable: Any]] {
            return jsonDictionary
        }
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.register(ExploreContentTableViewCell.self, forCellReuseIdentifier: ExploreContentTableViewCell.identifier)
        
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
           let name = exploreData?[indexPath.row]["backgroundImage"] as? String,
           let image = UIImage(named: name) {
            imageView.image = image.resizeHighImage(image: image)
        }
        if let topDescriptionLabel = cell.viewWithTag(2) as? UILabel,
           let topDescriptionText = exploreData?[indexPath.row]["topDescription"] as? String {
            topDescriptionLabel.text = topDescriptionText
        }
        if let titleLabel = cell.viewWithTag(3) as? UILabel,
           let titleText = exploreData?[indexPath.row]["title"] as? String {
            titleLabel.text = titleText
        }
        if let promoMessageLabel = cell.viewWithTag(4) as? UILabel,
           let promoMessageText = exploreData?[indexPath.row]["promoMessage"] as? String {
            promoMessageLabel.text = promoMessageText
        }
        if let bottomDescriptionLabel = cell.viewWithTag(5) as? UILabel,
           let bottomDescriptionText = exploreData?[indexPath.row]["bottomDescription"] as? String {
            bottomDescriptionLabel.text = bottomDescriptionText
        }
        guard let contentData = exploreData?[indexPath.row]["content"] as? [Dictionary<String, String>] else {return UITableViewCell()}
        cell.configureContent(with: contentData)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
}
