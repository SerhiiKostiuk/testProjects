//
//  KSDownloadHelper.h
//  adamaTestProject
//
//  Created by Сергій Костюк on 16.06.16.
//  Copyright © 2016 Сергій Костюк. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSDownloadHelper : NSObject

+ (NSURLRequest *)requestWithURLSting:(NSString *)URLString fileName:(NSString *)fileName;

@end
