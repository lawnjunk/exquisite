//
//  Segment.h
//  exquisite
//
//  Created by Adam Wallraff on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


@interface Segment : NSObject
-(instancetype)initWithDictionary:(NSDictionary *) segDictionary;
@property(strong, nonatomic) NSString *createdAt;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *segmentID;
@property(strong, nonatomic) NSString *author;
@property(nonatomic) NSInteger levelId;
@property(strong,nonatomic) NSString *storyId;
@property(strong,nonatomic) NSString *storyName;
@end
