//
//  Story.m
//  exquisite
//
//  Created by Adam Wallraff on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "Story.h"


@implementation Story

-(instancetype)initWithJSONData:(NSDictionary *)jsonDataDictionary{
  self = [super init];
  self.storyID = (int) jsonDataDictionary[@"storyID"];
  self.title = jsonDataDictionary[@"title"];
    
    NSMutableArray *tempLevels = [[NSMutableArray alloc] init];
    for (NSArray* level in jsonDataDictionary[@"levels"]) {
        Level *newLevel = [[Level alloc] initWithArray:level];
        [tempLevels addObject:newLevel];
    }
    
    self.levels = tempLevels;
  #warning fix date issue
  //  self.createdAt = jsonDataDictionary[@"createdAt"];

  return self;
}

-(Segment *)getLastSegment{
  return nil;
}

-(void)addSegment:(Segment *)newSegment{
  
}

-(NSString *)getFullText{
  return nil;
}

@end
