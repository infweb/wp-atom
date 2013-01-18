//
//  WPApi.h
//  WPAtom
//
//  Created by Rodolfo Carvalho on 1/17/13.
//  Copyright (c) 2013 iNF Web. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface WPApi : AFHTTPClient
+ (WPApi *)sharedApi;

- (void)getPostsWithSuccess:(void (^)(NSArray *))successBlock
                    failure:(void (^)(NSError *))failureBlock;
@end
