//
//  Ticker.h
//  CryptocoinsObjc
//
//  Created by Valmir Junior on 25/07/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Quote;

@interface Ticker : NSObject
    @property (nonatomic, readwrite) NSInteger* tickerId;
    @property (nonatomic, readwrite) NSString* name;
    @property (nonatomic, readwrite) NSString* symbol;
    @property (nonatomic, readwrite) NSDate* lastUpdate;
    @property (nonatomic, readwrite) Quote* usdQuote;
@end
