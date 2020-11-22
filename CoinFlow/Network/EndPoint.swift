//
//  EndPoint.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/21.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation

//https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,DASH,LTC,ETC,XRP,BCH,XMR,QTUM,ZEC,BTG&tsyms=USD
//https://min-api.cryptocompare.com/data/histohour?fsym=BTC&tsym=USD&limit=24

//3개의 네트워크 요청 URL
enum EndPoint {
    static let coinList: String = "https://min-api.cryptocompare.com/data/"
    static let coinChartData: String = "https://min-api.cryptocompare.com/data/"
    static let newsList: String = "http://coinbelly.com/api/get_rss"
}

