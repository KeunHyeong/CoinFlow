//
//  ChartData.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/21.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation

struct ChartDataResponse: Codable {
    let chartDatas: [ChartData]
    
    enum CodingKeys: String, CodingKey {
        case chartDatas = "Data"
    }
}

struct ChartData: Codable {
    let time: TimeInterval
    let closePrice: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case closePrice = "close"
    }
}
