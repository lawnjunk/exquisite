//
//  Level.m
//  exquisite
//
//  Created by Adam Wallraff on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "Level.h"
#import "Segment.h"
@implementation Level
-(instancetype)initWithArray:(NSArray *) levelArray {
    self = [super init];
    
    for (NSDictionary* segDictionary in levelArray ) {
        Segment *newSegment = [[Segment alloc] initWithDictionary:segDictionary];
        [self.segments addObject: newSegment];
    }
    
    return self;
}
@end
