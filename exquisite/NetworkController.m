//
//  NetworkController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "NetworkController.h"

@implementation NetworkController


+(id)sharedService {
    static NetworkController *theSharedService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theSharedService = [[NetworkController alloc] init];
    });
    return theSharedService;
}


@end
