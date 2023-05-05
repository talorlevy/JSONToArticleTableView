//
//  ViewController.swift
//  JsonDataExample
//
//  Created by Talor Levy on 2/8/23.
//

import UIKit

class ViewController: UIViewController {
    
// MARK: @IBOutlet
    
    @IBOutlet weak var articlesTableView: UITableView!
    
    var viewModel: ObjectViewModel?
    var myObject: ObjectModel = ObjectModel()
    var articlesArray: [ArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ObjectViewModel()
        viewModel?.fetchUsersData {
            DispatchQueue.main.async {
                if self.viewModel?.myObject.status == "ok" {
                    self.myObject = self.viewModel?.myObject ?? ObjectModel()
                    for item in self.myObject.articles ?? [] {
                        self.articlesArray.append(item)
                    }
                    self.articlesTableView.reloadData()
                }
            }
        }
    }
    
    func formatDate(stringToFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: stringToFormat)!
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}


// MARK: UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell") as? ArticlesTableViewCell else { return UITableViewCell() }
        let article = articlesArray[indexPath.row]
        let date = formatDate(stringToFormat: article.publishedAt ?? "")
        cell.authorLabel.text = article.title ?? ""
        cell.descriptionLabel.text = article.description ?? ""
        cell.publishedAtLabel.text = date
        cell.cellImageView.load(urlString: article.urlToImage ?? "")
        return cell
    }
}


// MARK: UITableViewCell

class ArticlesTableViewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
}


// MARK: UIImageView

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
