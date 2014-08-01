//
//  TableViewController.m
//  BlogReader
//
//  Created by Dale Rivera on 7/15/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"
@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                    options:0 error:&error];
    self.blogPosts = [NSMutableArray array];
    
    NSArray *blogPostsArray = [dataDictionary objectForKey:@"posts"];
    
    for (NSDictionary *bpDictionary in blogPostsArray) {
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
        blogPost.author = [bpDictionary objectForKey:@"author"];
        blogPost.thumbnail = [bpDictionary objectForKey:@"thumbnail"];
        blogPost.date = [bpDictionary objectForKey:@"date"];
        blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"url"]];
        [self.blogPosts addObject:blogPost];
    }
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.blogPosts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
    
    if([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:blogPost.thumbnailURL];
    
        cell.imageView.image = [UIImage imageWithData:imageData];
    }else {
        cell.imageView.image = [UIImage imageNamed:@"logo.jpeg"];
    }
    cell.textLabel.text = blogPost.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",blogPost.author, [blogPost formattedDate]];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showBlogPost"]) {
        NSIndexPath *indexPath = [self.tableView  indexPathForSelectedRow];
        BlogPost *blogpost = [self.blogPosts objectAtIndex:indexPath.row];
        
        [segue.destinationViewController setBlogPostURL:blogpost.url];
        
    }
   
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
