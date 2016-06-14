//
//  ViewController.m
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "ViewController.h"
#import "KSDatabaseManager.h"
#import "FMDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KSDatabaseManager *dbmanager = [KSDatabaseManager sharedDatabaseManager];
    
    [dbmanager.database open];
    
    if (![dbmanager.database open]) {
        NSLog(@"Could not open/create database");
    }
    
    FMResultSet *results = [dbmanager performQuery:@"SELECT * FROM preps"];
    while ([results next]) {
        NSString *string = [results stringForColumn:@"prepname"];
        NSLog(@"%@", string);
    } ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
