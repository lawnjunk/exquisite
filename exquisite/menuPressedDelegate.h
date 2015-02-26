//
//  menuPressedDelegate.h
//  exquisite
//
//  Created by Adam Wallraff on 2/26/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuPressedDelegate <NSObject>

-(void)menuOptionSelected:(NSInteger)selectedRow;

@end
