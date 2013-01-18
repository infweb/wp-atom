//
//  WPAtomHandler.h
//  WPAtom
//
//  Created by Rodolfo Carvalho on 1/17/13.
//  Copyright (c) 2013 iNF Web. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPAtomHandler : NSObject <NSXMLParserDelegate>

-(NSArray *)entries;

@end
