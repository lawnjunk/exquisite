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
    
    self.text = segDictionary[@"postBody"];
    self.segmentID = segDictionary[@"_id"];
    self.createdAt = segDictionary[@"createdAt"];
    self.author = segDictionary[@"author"];
    self.levelId = segDictionary[@"levelId"];
    self.storyId = segDictionary[@"storyId"];
    self.storyName = segDictionary[@"storyName"];
//    NSLog(@"seg ... the uesr is %@", self.user);
    return self;
}
@end
