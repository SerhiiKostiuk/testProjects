//
//  KSPrepsDetailViewController.m
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "KSPrepsDetailViewController.h"
#import "KSPrepsDetailTableViewCell.h"
#import "KSPreparationsDetail.h"
#import "KSHeaderTableViewCell.h"
#import "KSDatabaseManager.h"
#import "FMDB.h"
#import "UIImageView+AFNetworking.h"
#import "KSDownloadHelper.h"
#import "KSMacro.h"

KSConstString(kKSURLString, @"http://office.icenter.com.ua/product_image/");
KSConstString(kKSCellIdentifier, @"KSPrepsDetailTableViewCell");

@interface KSPrepsDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *prepsDetail;

@end

@implementation KSPrepsDetailViewController

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadFromBase];
    
    self.navigationItem.title  = self.currentPrepName;
}

#pragma mark -
#pragma mark Private

- (void)loadFromBase {
    KSDatabaseManager *dbmanager = [KSDatabaseManager sharedDatabaseManager];

    self.prepsDetail = [NSMutableArray array];
    
    NSString *stringForID = [NSString stringWithFormat:@"%d", (int)self.currentId];
    NSString *query = [NSString stringWithFormat:@"SELECT name,text_of FROM all_inf_preps WHERE prepid = %@", stringForID];
    
    FMResultSet *results = [dbmanager performQuery:query];
    while ([results next]) {
        KSPreparationsDetail *prepsDetail = [[KSPreparationsDetail alloc]initWithFMDBSetDetail:results];

        [self.prepsDetail addObject:prepsDetail];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.prepsDetail.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
    KSPreparationsDetail  *preps = [self.prepsDetail objectAtIndex:section - 1];
    return preps.sectionName;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 0) && (indexPath.row == 0)) {
            KSHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSHeaderTableViewCell"];
        NSURLRequest *request = [KSDownloadHelper requestWithURLSting:kKSURLString fileName:self.currentImageName];
        
        
            [cell.headerImageView setImageWithURLRequest:request placeholderImage:nil
                                                   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
             {
                 cell.headerImageView.image = image;
                 cell.headerImageView.contentMode = UIViewContentModeScaleAspectFit;
             } failure:nil] ;
        return cell;

    } else {
    KSPrepsDetailTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kKSCellIdentifier forIndexPath:indexPath];
    KSPreparationsDetail  *preps = [self.prepsDetail objectAtIndex:indexPath.row];
    
    cell.prepInfoTextLabel.attributedText = preps.sectionText;
        return cell;

    }
    
}

@end
