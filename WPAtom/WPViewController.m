//
//  WPViewController.m
//  WPAtom
//
//  Created by Rodolfo Carvalho on 1/17/13.
//  Copyright (c) 2013 iNF Web. All rights reserved.
//

#import "WPViewController.h"
#import "WPApi.h"
#import "WPPostViewController.h"

@interface WPViewController ()
@property (nonatomic, strong) NSArray *posts;
@end

@implementation WPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[WPApi sharedApi]
     getPostsWithSuccess:^(NSArray *entries) {
         self.posts = entries;
         [self.tableView reloadData];
     }
     failure:^(NSError *error) {
         [[[UIAlertView alloc] initWithTitle:@"Error!"
                                     message:[error localizedDescription]
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil] show];
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"post"];
    NSDictionary *current = self.posts[indexPath.row];
    cell.textLabel.text = [current objectForKey:@"title"];
    cell.detailTextLabel.text = [current objectForKey:@"summary"];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showPost"]) {
        NSDictionary *current = self.posts[[self.tableView indexPathForSelectedRow].row];
        WPPostViewController *vc = segue.destinationViewController;
        vc.postText = current[@"content"];
        vc.postTitle = current[@"title"];
    }
}
@end
