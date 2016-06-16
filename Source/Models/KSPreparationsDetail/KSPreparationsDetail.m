//
//  KSPreparationsDetail.m
//  adamaTestProject
//
//  Created by Сергій Костюк on 15.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "KSPreparationsDetail.h"
#import "NSAttributedString+DDHTML.h"

#import "FMDB.h"

@implementation KSPreparationsDetail

- (id)initWithFMDBSetDetail:(FMResultSet *)set {
    self = [super init];
    if (self) {
        _sectionName = [set stringForColumn:@"name"];
        NSAttributedString *attributedString = [NSAttributedString attributedStringFromHTML:[set stringForColumn:@"text_of"]];

        _sectionText = attributedString;
    }
    
    return self;
}



@end
