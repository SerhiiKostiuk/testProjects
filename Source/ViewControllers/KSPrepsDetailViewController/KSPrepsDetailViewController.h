//
//  KSPrepsDetailViewController.h
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSPrepsDetailViewController : UIViewController
@property (nonatomic, strong) id  delegate;

@property (nonatomic, assign) NSUInteger currentId;
@property (nonatomic, strong) NSString *currentPrepName;
@property (nonatomic, strong) NSString *currentImageName;

@end
