//
//  TickerServices.m
//  CryptocoinsObjc
//
//  Created by Valmir Junior on 25/07/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TickerServices.h"
#import "Ticker.h"
#import "Quote.h"

@interface TickerServices()


@end

@implementation TickerServices

-(void) retriveTickersWithCompletion: (void(^)(NSMutableArray<Ticker*>*, NSError* error))callback {
    NSString *endpoint = @"https://api.coinmarketcap.com/v2/ticker/?sort=rank";
    
    NSURL *url = [[NSURL alloc] initWithString:endpoint];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^
     (NSData * _Nullable data,
      NSURLResponse * _Nullable response,
      NSError * _Nullable error) {
        
         if (error) {
             dispatch_sync(dispatch_get_main_queue(), ^{
                 callback(nil, error);
             });
         } else {
             
             NSError *error = nil;
             NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             
             if (error != nil) {
                 NSLog(@"Error parsing JSON.");
             } else {
                 NSMutableDictionary *tickersDic = [jsonDic valueForKey:@"data"];
                 
                 NSMutableArray<Ticker *>* tickers = [self parseTickers:tickersDic];
                 
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     callback(tickers, nil);
                 });
             }

         }
         
     }] resume];
}

-(NSMutableArray<Ticker *> *) parseTickers:(NSMutableDictionary *) jsonDic {
    
    NSMutableArray<Ticker *> * tickers = [NSMutableArray new];
    
    for (NSMutableDictionary* item in [jsonDic allValues]) {
        
        if (item) {
            
            Ticker * ticker = [self parseTicker:item];
            
            [tickers addObject:ticker];
        }
    }
    
    return tickers;
}

-(Ticker *) parseTicker:(NSDictionary *) json {
    Ticker *ticker = [Ticker new];
    
    ticker.tickerId = [[json valueForKey:@"id"] integerValue];
    ticker.name = (NSString *)[json valueForKey:@"name"];
    ticker.symbol = (NSString *)[json valueForKey:@"symbol"];
    
    NSDictionary* quotesJson = (NSDictionary *)[json valueForKey:@"quotes"];
    NSDictionary* usdQuoteJson = (NSDictionary *)[quotesJson valueForKey:@"USD"];
    
    ticker.usdQuote = [self parseQuote:usdQuoteJson];
    
    return ticker;
}

-(Quote *) parseQuote:(NSDictionary *) json {
    
    Quote *quote = [Quote new];
    
    quote.price = (NSDecimalNumber *)[json valueForKey:@"price"];
    quote.percentChange24h = (NSNumber *)[json valueForKey:@"percent_change_24h"];
    
    return quote;
}

@end
