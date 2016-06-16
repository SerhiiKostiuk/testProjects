//
//  KSPrepsTableViewCell.h
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSPrepsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *prepsPreviewImage;
@property (weak, nonatomic) IBOutlet UILabel *prepsTitleLablel;
@property (weak, nonatomic) IBOutlet UILabel *prepsInfoLablel;

@end
