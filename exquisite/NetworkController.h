//
//  NetworkController.h
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Segment.h"

@interface NetworkController : NSObject

+(id)sharedService;
-(void)createNewAccountWithUserName:(NSString *) username password:(NSString *)passwd email:(NSString *)email location:(NSString*) location ;

-(void)fetchRandomStoryWithCompletionHandler: (void (^)(NSDictionary *results, NSString *error)) completionHandler;
-(void)fetchStoryWithIdentifier:(NSString * )storyID withCompletionHandler: (void (^)(NSDictionary *results, NSString *error)) completionHandler;

-(void)fetchStoriesForBrowserWithCompletionHandler: (void (^)(NSArray *results, NSString *error)) completionHandler;
-(void)fetchTimelineForUser:(User *)currentUser withCompletionHandler:(void (^)(NSDictionary *results, NSString *error)) completionHandler;
-(void)postSegment:(Segment *)segment;
@end
