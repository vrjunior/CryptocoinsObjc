//
//  Quote.h
//  CryptocoinsObjc
//
//  Created by Valmir Junior on 25/07/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject
    @property (nonatomic, readwrite) NSDecimalNumber* price;
    @property (nonatomic, readwrite) NSNumber* percentChange24h;
@end
