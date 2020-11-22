//
//  NetworkManager.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/21.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation

//NetworkManager 책임
//URLSession
//dataTask
//3가지(코인리스트, 차트, 뉴스) 리퀘스트에 대한 메소드 제공

class NetworkManager {
    
    static let session = URLSession.shared
    
//    static func requestCoinList(compeltion: @escaping ([Coin]) -> Void) {
//        let coinListURL = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,DASH,LTC,ETC,XRP,BCH,XMR,QTUM,ZEC,BTG&tsyms=USD")!
//        let taskWithCoinListURL = session.dataTask(with: coinListURL) { (data, response, error) in
//            let successRange = 200..<300
//            guard error == nil,
//                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
//                  successRange.contains(statusCode) else{
//                return
//            }
//
//            guard let responseData = data else { return }
//            let decoder = JSONDecoder()
//            do {
//                let response = try decoder.decode(CoinListResponse.self, from: responseData)
//                print("--> success: \(response.raw.btg)")
//                let coinList = response.raw.allCoins()
//                compeltion(coinList)
//            } catch {
//                print("--> err: \(error.localizedDescription)")
//            }
//        }
//        taskWithCoinListURL.resume()
//    }
//
//    static func requestCoinChartData(compeltion: @escaping ([ChartData]) -> Void) {
//        let coinChartDataURL = URL(string: "https://min-api.cryptocompare.com/data/histohour?fsym=BTC&tsym=USD&limit=24")!
//        let taskWithCoinChartDataURL = session.dataTask(with: coinChartDataURL) { (data, response, error) in
//            let successRange = 200..<300
//            guard error == nil,
//                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
//                  successRange.contains(statusCode) else{
//                return
//            }
//
//            guard let responseData = data else { return }
//            let decoder = JSONDecoder()
//            do {
//                let response = try decoder.decode(ChartDataResponse.self, from: responseData)
//        //        print("--> success: \(response)")
//                let chartDatas = response.chartDatas
//                compeltion(chartDatas)
//            } catch {
//                print("--> err: \(error.localizedDescription)")
//            }
//        }
//        taskWithCoinChartDataURL.resume()
//    }
//
//    static func requestNewsList(compeltion: @escaping ([Article]) -> Void) {
//        let newsURL = URL(string: "http://coinbelly.com/api/get_rss")!
//        let taskWithNewsURL = session.dataTask(with: newsURL) { (data, response, error) in
//            let successRange = 200..<300
//            guard error == nil,
//                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
//                  successRange.contains(statusCode) else{
//                return
//            }
//
//            guard let responseData = data else { return }
//            let decoder = JSONDecoder()
//            do {
//                let response = try decoder.decode([NewsResponse].self, from: responseData)
//                let articles = response.flatMap { $0.articleArray }
//                //print("--> success: \(response.first?.articleArray.first)")
//                compeltion(articles)
//            } catch {
//                print("--> err: \(error.localizedDescription)")
//            }
//        }
//        taskWithNewsURL.resume()
//    }
}

extension NetworkManager {
    static func requestCoinList(compeltion: @escaping (Result<[Coin], Error>) -> Void) {
        
        
        let param: RequestParam = .url(["fsyms": "BTC,ETH,DASH,LTC,ETC,XRP,BCH,XMR,QTUM,ZEC,BTG", "tsyms":"USD"])
        guard let url = CoinListRequest(param: param).urlRequest().url else { return }
        let taskWithCoinListURL = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                compeltion(.failure(error))
                return
            }
            
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(CoinListResponse.self, from: responseData)
                let coinList = response.raw.allCoins()
                compeltion(.success(coinList))
            } catch let error {
                print("--> err: \(error.localizedDescription)")
                compeltion(.failure(error))
            }
        }
        taskWithCoinListURL.resume()
    }
    
    static func requestCoinChartData(compeltion: @escaping (Result<[ChartData], Error>) -> Void) {
        let param: RequestParam = .url(["fsym":"BTC", "tsym":"USD", "limit":"24"])
        guard let url = CoinChartDataRequest(period: .day, param: param).urlRequest().url else { return }
        let taskWithCoinChartDataURL = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                compeltion(.failure(error))
                return
            }
            
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ChartDataResponse.self, from: responseData)
                let chartDatas = response.chartDatas
                compeltion(.success(chartDatas))
            } catch {
                print("--> err: \(error.localizedDescription)")
                compeltion(.failure(error))
            }
        }
        taskWithCoinChartDataURL.resume()
    }
    
    static func requestNewsList(compeltion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = NewsListRequest().urlRequest().url else { return }
        let taskWithNewsURL = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                compeltion(.failure(error))
                return
            }
            
            guard let responseData = data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode([NewsResponse].self, from: responseData)
                let articles = response.flatMap { $0.articleArray }
                compeltion(.success(articles))
            } catch {
                print("--> err: \(error.localizedDescription)")
                compeltion(.failure(error))
            }
        }
        taskWithNewsURL.resume()
    }
}
