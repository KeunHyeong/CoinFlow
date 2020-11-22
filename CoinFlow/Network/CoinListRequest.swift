//
//  CoinListRequest.swift
//  CoinFlow
//
//  Created by KeunHyeong on 2020/11/21.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation

struct CoinListRequest: Request {
    var method: HTTTPMethod = .get
    var params: RequestParam
    var path: String { return EndPoint.coinList + "pricemultifull" }
    
    init(param: RequestParam) {
        self.params = param
    }
}
