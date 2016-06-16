//
//  KSDownloadHelper.m
//  adamaTestProject
//
//  Created by Сергій Костюк on 16.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import "KSDownloadHelper.h"

@implementation KSDownloadHelper

#pragma mark -
#pragma mark Class Methods

+ (NSURLRequest *)requestWithURLSting:(NSString *)URLString fileName:(NSString *)fileName {
    NSString *string = [URLString stringByAppendingPathComponent:fileName];
    NSURL *URL = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    return request;
}

@end
