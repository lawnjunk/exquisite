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
        NSLog(@"level be makin now");
        Level *newLevel = [[Level alloc] initWithArray:level];
        [tempLevels addObject:newLevel];
    }
    
    self.levels = tempLevels;
  #warning fix date issue
  //  self.createdAt = jsonDataDictionary[@"createdAt"];

  return self;
}

-(Segment *)getLastSegment{
    Level *level = self.levels.lastObject;
    Segment *lastSegment = level.segments.lastObject;
    NSLog(@"lastSegmenttext %@", lastSegment.text);
    return  lastSegment;
}

-(void)addSegment:(Segment *)newSegment{
    
    
    //    NSLog(@"new seg text: %@", newSegment.text);
    //    Level *lastLevel = self.levels.lastObject;

    //    Segment *lastSegOnNewSeg = newSegArray.lastObject;
    //    NSLog(@"last segment text on newsegarray %@",lastSegOnNewSeg.text);
    //    lastLevel.segments = newSegArray;
//    
    Level *lastLevel = self.levels.lastObject;
    NSLog(@" last level segemnet count %ud",lastLevel.segments.count);
    if (lastLevel.segments.count == 3) {
        NSMutableArray *newMutableLevelArray = [[NSMutableArray alloc]initWithArray: self.levels];
        NSMutableArray *newSegArray = [[NSMutableArray alloc] initWithArray:lastLevel.segments];
        [newSegArray addObject:newSegment];
        Level *newLevel = [[Level alloc] init];
        newLevel.segments = newSegArray;
        [newMutableLevelArray addObject:newLevel];
        self.levels = newMutableLevelArray;
    } else {
        NSMutableArray *newSegmentArray = [[NSMutableArray alloc] initWithArray:lastLevel.segments];
        [newSegmentArray addObject:newSegment];
        lastLevel.segments = newSegmentArray;
    }
}

-(NSString *)getFullText{
  return nil;
}

@end
