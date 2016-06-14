//
//  KSDatabaseManager.h
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMResultSet;
@class FMDatabase;

@interface KSDatabaseManager : NSObject
@property (nonatomic, strong) FMDatabase *database;

+(instancetype)sharedDatabaseManager;

- (FMResultSet *)performQuery:(NSString *)query;

@end
