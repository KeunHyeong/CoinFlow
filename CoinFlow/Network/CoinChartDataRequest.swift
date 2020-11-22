//
//  CoinChartDataRequest.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/21.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation

struct CoinChartDataRequest: Request {
    var method: HTTTPMethod = .get
    var params: RequestParam
    var path: String
    
    init(period: Period, param: RequestParam) {
        self.path = EndPoint.coinChartData + period.urlPath
        self.params = param
    }
}
