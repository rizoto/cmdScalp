//
//  Scalp.swift
//  cmdScalp
//
//  Created by Lubor Kolacny on 8/5/20.
//  Copyright © 2020 Lubor Kolacny. All rights reserved.
//

import Foundation
import ArgumentParser
import TradingToolBox

struct Scalp: ParsableCommand {

    @Flag(help: "Dry run without any real action.")
    var dryRun: Bool
    
    @Argument(help: "The instrument for backtesting in this strategy.")
    var instrument: String

    func run() throws {
        let instrument10 = String((instrument + String(repeating: " ", count: 9)).prefix(10))
        let cancellable = TickCache().eraseToAnyPublisher()
        let trader = Trader(account: Account(hedgingEnabled: true), ticks: cancellable)
        let strategy = ScalpingStrategy(instrument: instrument10, endOf: {_exit(0)})
        trader.runStrategy(strategy: strategy)
        dispatchMain()
    }
}
