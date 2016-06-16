//
//  ViewController.m
//  adamaTestProject
//
//  Created by Сергій Костюк on 14.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "KSPrepsViewController.h"
#import "KSPrepsDetailViewController.h"
#import "KSPreparations.h"
#import "KSDatabaseManager.h"
#import "FMDB.h"
#import "KSPrepsTableViewCell.h"
#import "AFNetworking.h"
#import "KSDownloadHelper.h"
#import "UIImageView+AFNetworking.h"
#import "KSMacro.h"

KSConstString(kKSURLString, @"http://office.icenter.com.ua/product_image/");
KSConstString(kKSCellIdentifier, @"KSPrepsTableViewCell");

@interface KSPrepsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) KSPrepsDetailViewController *detailVC;

@property (nonatomic, strong) NSMutableArray *preps;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation KSPrepsViewController

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.preps = [KSDatabaseManager loadFromBaseWithQuery:@"SELECT * FROM preps"];
    [self sortArrayAlphabeticly];
}

#pragma mark -
#pragma mark Private

- (void)sortArrayAlphabeticly {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    NSArray *sortedArray = [self.preps sortedArrayUsingDescriptors:@[sort]];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:sortedArray];
    self.preps = mutableArray;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[KSPrepsDetailViewController class]]) {
        KSPrepsDetailViewController *vc = segue.destinationViewController;
        vc.delegate = self;
        self.detailVC = vc;
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.preps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSPreparations *prep = self.preps[indexPath.row];
    self.images = [NSMutableArray array];
    
    KSPrepsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kKSCellIdentifier];
    cell.prepsTitleLablel.text = prep.title;
    cell.prepsInfoLablel.attributedText = prep.prepsInfo;
    
    
    NSURLRequest *request = [KSDownloadHelper requestWithURLSting:kKSURLString
                                                         fileName:prep.imageName];
    
    [cell.prepsPreviewImage setImageWithURLRequest:request placeholderImage:nil
                                           success:^(NSURLRequest * _Nonnull request,
                                                     NSHTTPURLResponse * _Nullable response,
                                                     UIImage * _Nonnull image)
     {
         cell.prepsPreviewImage.image = image;
         [self.images addObject:image];
         
     } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         NSLog(@"%@", error.localizedDescription);
     }] ;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KSPreparations *prep = self.preps[indexPath.row];
    self.detailVC.currentId = prep.prepId;
    self.detailVC.currentPrepName = prep.title;
    self.detailVC.currentImageName = prep.imageName;
}

@end
