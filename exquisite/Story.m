//
//  Story.m
//  exquisite
//
//  Created by Adam Wallraff on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "Story.h"
#import "Level.h"

@implementation Story

-(instancetype)initWithJSONData:(NSDictionary *)jsonDataDictionary{
  self = [super init];
  
  self.storyID = jsonDataDictionary[@"storyID"];
  self.title = jsonDataDictionary[@"title"];
  
#warning fix date issue
//  self.createdAt = jsonDataDictionary[@"createdAt"];
  
  self.levels = jsonDataDictionary[@"levels"];
  
  NSLog(@"This story has %lu Levels.",(unsigned long)self.levels.count);

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
