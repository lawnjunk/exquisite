//
//  Segment.m
//  exquisite
//
//  Created by Adam Wallraff on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "Segment.h"

@implementation Segment
-(instancetype)initWithDictionary:(NSDictionary *) segDictionary {
    self = [super init];
    
    self.text = segDictionary[@"text"];
    self.segmentID = 0;
    self.createdAt = segDictionary[@"createdAt"];

    return self;
}
@end
