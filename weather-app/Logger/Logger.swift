//
//  Logger.swift
//  weather-app
//
//  Created by Ming Chu on 21/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Log

let logger: Logger = {
    let logger = Logger()
    #if !DEBUG
    logger.enabled = false
    #endif
    return logger
}()
