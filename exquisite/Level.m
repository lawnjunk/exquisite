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
    
    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary* segDictionary in levelArray ) {
        Segment *newSegment = [[Segment alloc] initWithDictionary:segDictionary];
//        NSLog(@"seg user %@", segDictionary[@"text"]);
        [tempArray addObject: newSegment];
    }
    self.segments = tempArray;

    
    return self;
}


-(instancetype)init {
    self = [super init];
    
    return self;
}



@end
