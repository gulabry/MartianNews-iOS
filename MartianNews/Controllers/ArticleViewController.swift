//
//  ArticleViewController.swift
//  MartianNews
//
//  Created by Bryan Gula on 10/22/18.
//  Copyright © 2018 Gula, Inc. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var bodyText: UILabel!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    var article: Article!
    var translateArticles = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        navigationController?.navigationItem.title = ""
        
        setupArticleView()
    }
    
    func setupArticleView() {
        
        guard let article = article else { return }
        
        //  Set proper translation for the page
        //
        if translateArticles {
            titleTextLabel.text = Translator.toMartian(from: article.title)
            bodyText.text = Translator.toMartian(from: article.body)
        } else {
            titleTextLabel.text = article.title
            bodyText.text = article.body
        }
        
        //  Title and body sizing
        //
        titleTextLabel.numberOfLines = 0
        titleTextLabel.sizeToFit()
        
        bodyText.numberOfLines = 0
        bodyText.sizeToFit()
        
        articleImageView.contentMode = .scaleAspectFill
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.contentSize = scrollView.subviews.reduce(CGRect.zero, {
            return $0.union($1.frame)
        }).size
        
        guard let image = article.images.first,
            let url = URL(string: image.url) else { return }
        
        // Fetch the image for the article
        //
        API.imageManager.download(with: url, withCompletion: { image in
            DispatchQueue.main.async {
                self.articleImageView.image = image
            }
        })
    }
}
