//
//  KSPreparations.m
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "KSPreparations.h"
#import "KSDatabaseManager.h"
#import "NSAttributedString+DDHTML.h"
#import "FMDB.h"

@implementation KSPreparations

- (instancetype)init {
    self = [super init];
    if (self) {
//        [self loadFromBase];
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = [dictionary [@"prepname"] stringValue];
        
    }
    
    return self;
}

- (id)initWithFMDBSet:(FMResultSet *)set {
    self = [super init];
    if (self) {
        _title = [set stringForColumn:@"prepname"];
        NSAttributedString *attributedString = [NSAttributedString attributedStringFromHTML:[set stringForColumn:@"about"]];
        _prepsInfo = attributedString;
        _prepId = [[set stringForColumn:@"id"] integerValue];
        _imageName = [set stringForColumn:@"preppict"];
    }
    
    return self;
}

- (void)loadFromBase {
    KSDatabaseManager *dbmanager = [KSDatabaseManager sharedDatabaseManager];
    
    [dbmanager.database open];
    
    if (![dbmanager.database open]) {
        NSLog(@"Could not open/create database");
    }
    
    FMResultSet *results = [dbmanager performQuery:@"SELECT * FROM preps"];
    while ([results next]) {
        self.title = [results stringForColumn:@"prepname"];
        self.prepsInfo = [results stringForColumn:@"about"];
        self.imageName = [results stringForColumn:@"preppict"];

        NSLog(@"%@", self.title);
        NSLog(@"%@", self.prepsInfo);
        NSLog(@"%@", self.imageName);
    } ;
}

@end
