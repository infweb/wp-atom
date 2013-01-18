//
//  WPPostViewController.m
//  WPAtom
//
//  Created by Rodolfo Carvalho on 1/17/13.
//  Copyright (c) 2013 iNF Web. All rights reserved.
//

#import "WPPostViewController.h"
@interface WPPostViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WPPostViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.postTitle;
    [self.webView loadHTMLString:self.postText baseURL:nil];
}
@end
