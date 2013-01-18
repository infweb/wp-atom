//
//  WPApi.m
//  WPAtom
//
//  Created by Rodolfo Carvalho on 1/17/13.
//  Copyright (c) 2013 iNF Web. All rights reserved.
//

#import "WPApi.h"
#import "WPAtomHandler.h"

#define WP_ATOM_BASE_URL @"http://en.blog.wordpress.com"

@implementation WPApi
+(WPApi *)sharedApi
{
    static WPApi *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[WPApi alloc] initWithBaseURL:[NSURL URLWithString:WP_ATOM_BASE_URL]];
    });
    return __sharedInstance;
}

- (void)getPostsWithSuccess:(void (^)(NSArray *))successBlock
                    failure:(void (^)(NSError *))failureBlock
{
    [self getPath:@"feed/atom/" parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (successBlock) {
                  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseObject];
                  WPAtomHandler *handler = [[WPAtomHandler alloc] init];
                  parser.delegate = handler;
                  [parser parse];
                  
                  successBlock(handler.entries);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failureBlock) {
                  failureBlock(error);
              }
          }];
}
@end
