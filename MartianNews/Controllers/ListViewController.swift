//
//  ListViewController.swift
//  MartianNews
//
//  Created by Bryan Gula on 10/22/18.
//  Copyright © 2018 Gula, Inc. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var translationSwitch: UISwitch!
    var translateArticles = false
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        API.get { articles in
            
            guard let articles = articles else { return }
            
            DispatchQueue.main.async {
                self.articles = articles
                self.articleTableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
        self.articleTableView.delegate = self
        self.articleTableView.dataSource = self
        self.articleTableView.rowHeight = 100
    }
    
    @IBAction func translateArticles(_ sender: Any) {
        translateArticles = !translateArticles
        
        DispatchQueue.main.async {
            self.articleTableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
        
        if articles.indices.contains(indexPath.row) {
            
            let article = articles[indexPath.row]
            
            if translateArticles {
                cell.titleLabel.text = Translator.toMartian(from: article.title)
            } else {
                cell.titleLabel.text = article.title
            }

            cell.listImageView.contentMode = .scaleAspectFill
            
            API.imageManager.download(with: URL(string: article.images.first!.url)!, withCompletion: { image in
                DispatchQueue.main.async {
                    cell.listImageView.image = image
                }
            })
            
        } else {
            
            cell.titleLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if articles.indices.contains(indexPath.row) {
            
            let article = articles[indexPath.row]
            
            guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "articleVC") as? ArticleViewController else { return }
            
            vc.article = article
            vc.translateArticles = translateArticles
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
