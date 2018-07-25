//
//  ViewController.m
//  CryptocoinsObjc
//
//  Created by Valmir Junior on 25/07/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

#import "ViewController.h"
#import "TickerServices.h"
#import "CoinCell.h"
#import "Ticker.h"

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

NSMutableArray<Ticker *> * tickers;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initialSetup];
    
    TickerServices* tickerServices = [TickerServices new];
    
    [tickerServices retriveTickersWithCompletion:^(NSMutableArray<Ticker *> *tickersList, NSError *error) {
        if (error) {
            NSLog(@"Somenthing went wront");
        } else {
            tickers = tickersList;
            [self->_tableView reloadData];
        }
    }];
}

- (void)initialSetup {
    
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CoinCell" forIndexPath:indexPath];
    
    CoinCell* coinCell = (CoinCell*) cell;
    
    if (coinCell == nil) {
        return cell;
    }
    
    Ticker *currentTicker = (Ticker *) [tickers objectAtIndex:indexPath.row];
    
    [coinCell.name setText:currentTicker.name];
    
    return coinCell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tickers) {
        return [tickers count];
    }
    
    return @0;
}


@end

