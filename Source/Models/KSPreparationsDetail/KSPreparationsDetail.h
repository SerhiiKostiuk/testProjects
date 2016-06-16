//
//  KSPreparationsDetail.h
//  adamaTestProject
//
//  Created by Сергій Костюк on 15.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "KSPreparations.h"

@interface KSPreparationsDetail : KSPreparations
@property (nonatomic, strong) NSString *sectionName;
@property (nonatomic, strong) NSAttributedString *sectionText;

- (id)initWithFMDBSetDetail:(FMResultSet *)set;



@end
