//
//  WebViewController.h
//  BlogReader
//
//  Created by Dale Rivera on 7/16/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) NSURL *blogPostURL;
@end
