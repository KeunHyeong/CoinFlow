//
//  NewsViewController.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/07.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.requestNewsList{ result in
            switch result{
            case .success(let articles):
                print("coinList--->\(articles.count)")
            case .failure(let error):
                print("error ----->\(error.localizedDescription)")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension NewsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as? NewsListCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}

class NewsListCell:UITableViewCell{
    
}
