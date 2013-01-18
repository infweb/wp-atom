//
//  WPAtomHandler.m
//  WPAtom
//
//  Created by Rodolfo Carvalho on 1/17/13.
//  Copyright (c) 2013 iNF Web. All rights reserved.
//

#import "WPAtomHandler.h"

#define kWPEntryKey @"entry"

@interface WPAtomHandler ()
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableArray *mutableEntries;
@property (nonatomic, strong) NSMutableDictionary *currentEntry;
@end

@implementation WPAtomHandler

- (NSArray *)entries
{
    return [NSArray arrayWithArray:self.mutableEntries];
}

- (NSMutableArray *)mutableEntries
{
    if (!_mutableEntries) {
        _mutableEntries = [NSMutableArray array];
    }
    return _mutableEntries;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    self.currentElement = elementName;
    if (!self.currentEntry && [elementName isEqualToString:kWPEntryKey]) {
        self.currentEntry = [NSMutableDictionary dictionary];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.currentEntry) {
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (!string.length) return;
        
        NSString *currentValue = [self.currentEntry objectForKey:self.currentElement];
        if (!currentValue)
            currentValue = @"";
        [self.currentEntry setObject:[currentValue stringByAppendingString:string]
                              forKey:self.currentElement];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (self.currentEntry && [elementName isEqualToString:kWPEntryKey]) {
        [self.mutableEntries addObject:self.currentEntry];
        self.currentEntry = nil;
    }
    self.currentElement = nil;
}
@end
