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

@end
