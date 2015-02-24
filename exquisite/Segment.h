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

@property(strong, nonatomic) NSString *createdAt;
@property (strong, nonatomic) NSString *text;

@property (nonatomic) int segmentID;

@property(strong, nonatomic) User *user;


@end
