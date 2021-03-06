//
//  ChartListViewController.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/07.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class ChartListViewController: UIViewController {

    @IBOutlet weak var chartCollectionView: UICollectionView!
    @IBOutlet weak var chartTableView: UITableView!
    
    @IBOutlet weak var chartTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.requestCoinList{ result in
            
            switch result{
            
            case .success(let coins):
                print("coinList--->\(coins.count)")
            case .failure(let error):
                print("error --->\(error.localizedDescription)")
            }
        }
        
        NetworkManager.requestCoinChartData { result in
            switch result {
            case .success(let coinChartDats):
                print("--> chart data: \(coinChartDats.count)")
            case .failure(let error):
                print("--> error: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //이 시점 테이블뷰 contentsize 파악후, tableview 높이를 조정
        
        adjustTableViewheight()
    }
}

//MARK: - Private Method
extension ChartListViewController{
    
    private func adjustTableViewheight(){
        chartTableViewHeight.constant = chartTableView.contentSize.height
    }
    
    private func showDetail(){
        let storyBoard = UIStoryboard(name: "Chart", bundle: .main)
        let chartDetailVC = storyBoard.instantiateViewController(identifier: "ChartDetailViewController")
        
        navigationController?.pushViewController(chartDetailVC, animated: true)
    }
}

//MARK: - CollectionView
extension ChartListViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCardCell", for: indexPath) as? ChartCardCell else{
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension ChartListViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width:CGFloat = collectionView.bounds.width - 20 * 2 - 15
        let height:CGFloat = 200
        
        return CGSize(width: width, height: height)
    }
}

class ChartCardCell: UICollectionViewCell{
    
    
}

//MARK: - TableView
extension ChartListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartListCell", for: indexPath) as? ChartListCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

class ChartListCell:UITableViewCell{
    
}
