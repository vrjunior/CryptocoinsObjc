//
//  TickerServices.h
//  CryptocoinsObjc
//
//  Created by Valmir Junior on 25/07/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ticker;

@interface TickerServices : NSObject

-(void) retriveTickersWithCompletion: (void(^)(NSMutableArray<Ticker*>*, NSError* error))callback;

@end
