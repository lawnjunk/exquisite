//
//  NetworkController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "NetworkController.h"
#import "Story.h"

@implementation NetworkController


+(id)sharedService {
    static NetworkController *theSharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theSharedService = [[NetworkController alloc] init];
    });
    return theSharedService;
}



-(void)createNewAccountWithUserName:(NSString *) username password:(NSString *)passwd{
    NSLog(@"i made a fake token");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = @"thisTokenIsATempForTest";
    [userDefaults setObject:token forKey:@"token"];
    [userDefaults synchronize];
}


-(void)fetchStoryWithCompletionHandler: (void (^)(NSDictionary *results, NSString *error)) completionHandler {
    
    // using json file for testing until we have working endpoints on the rest api
    NSString *pathToJson = [[NSBundle mainBundle] pathForResource:@"PretendStory" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:pathToJson];
    NSError *parseError;
    NSDictionary *storyDictionary = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    if (parseError) {
        NSLog(@"there was an error parsing the json story dictionary");
    } else {
        NSLog(storyDictionary.description);
      Story *wat = [[Story alloc]  initWithJSONData:storyDictionary];
      
    }
    
}

@end
