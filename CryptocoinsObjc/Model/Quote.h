//
//  Quote.h
//  CryptocoinsObjc
//
//  Created by Valmir Junior on 25/07/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject
    @property (nonatomic, readwrite) double* symbol;
    @property (nonatomic, readwrite) double* percentChange24h;
@end
