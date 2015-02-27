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


-(Segment *)getRandomSegmentFromLastLevel{
    Level *lastLevel = self.levels.lastObject;
    Segment *randomSeg = lastLevel.segments[arc4random()%lastLevel.segments.count];
    return randomSeg;
}

-(void)addSegment:(Segment *)newSegment{
    
    
    //    NSLog(@"new seg text: %@", newSegment.text);
    //    Level *lastLevel = self.levels.lastObject;

    //    Segment *lastSegOnNewSeg = newSegArray.lastObject;
    //    NSLog(@"last segment text on newsegarray %@",lastSegOnNewSeg.text);
    //    lastLevel.segments = newSegArray;
//    
    Level *lastLevel = self.levels.lastObject;
    NSLog(@" last level segemnet count %lu",lastLevel.segments.count);
    if (lastLevel.segments.count >= 3 || self.levels.count == 1) {
        NSLog(@"we are gunna make a new level");
//        NSMutableArray *newMutableLevelArray = [[NSMutableArray alloc]initWithArray: self.levels];
//        NSMutableArray *newSegArray = [[NSMutableArray alloc] init];
//        newSegment.levelId = (int) self.levels.count -1;
//        [newSegArray addObject:newSegment];
//        Level *newLevel = [[Level alloc] init];
//        newLevel.segments = newSegArray;
//        [newMutableLevelArray addObject:newLevel];
//        self.levels = newMutableLevelArray;
        
        NSMutableArray *newSegArray = [[NSMutableArray alloc]init];
        Segment *segToAppend = newSegment;
        segToAppend.levelId = 2;
        [newSegArray addObject:segToAppend];
        
        
        
        NSMutableArray *newLevelArray = [[NSMutableArray alloc] initWithArray:self.levels];
        Level *newLevel = [[Level alloc]init];
        newLevel.segments = newSegArray;


        [newLevelArray addObject:newLevel];
        self.levels = newLevelArray;
        
    } else {
        NSLog(@"we are appending new seg to same level");
        NSMutableArray *newSegmentArray = [[NSMutableArray alloc] initWithArray:lastLevel.segments];
        newSegment.levelId = (int) self.levels.count -1;
        [newSegmentArray addObject:newSegment];
        lastLevel.segments = newSegmentArray;
    }
}

-(NSString *)getFullText{
  return nil;
}

@end
