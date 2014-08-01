//
//  BlogPost.h
//  BlogReader
//
//  Created by Dale Rivera on 7/16/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *author;
@property(strong,nonatomic) NSString *thumbnail;
@property(strong,nonatomic) NSString *date;
@property(strong,nonatomic) NSURL *url;
//Designated Initializer
- (id) initWithTitle:(NSString *) title;
+ (id) blogPostWithTitle:(NSString *) title;
- (NSURL *) thumbnailURL;
- (NSString *) formattedDate;
@end
