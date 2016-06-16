//
//  KSPreparations.h
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMResultSet;

@interface KSPreparations : NSObject
@property (nonatomic, assign) NSInteger  prepId;
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSAttributedString  *prepsInfo;
@property (nonatomic, strong) NSString  *imageName;

- (id)initWithFMDBSet:(FMResultSet *)set;

@end
