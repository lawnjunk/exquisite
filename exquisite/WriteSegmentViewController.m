//
//  WriteSegmentViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "WriteSegmentViewController.h"
#import "NetworkController.h"
#import "ReadStoryViewController.h"

@interface WriteSegmentViewController () <UIGestureRecognizerDelegate, UITextViewDelegate>

@property (strong,nonatomic) NetworkController *networkController;
@property (strong,nonatomic) NSString *initialFragment;
@property NSUInteger initialFragmentLength;
@property (strong,nonatomic) Segment *lastSegment;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic) NSString *username;
@property (nonatomic) NSInteger levelId;

@end

@implementation WriteSegmentViewController
-(void)viewWillAppear:(BOOL)animated{
    

    
    

    
//    [self.networkController fetchStoryWithIdentifier:@"this should get changed" withCompletionHandler:^(NSDictionary *results, NSString *error) {
        [self.networkController fetchRandomStoryWithCompletionHandler:^(NSDictionary *results, NSString *error) {

        NSLog(@"%@ this is my username", self.username);
        
        NSLog(results.description);
        self.currentStory = [[Story alloc] initWithJSONData:results];
        self.lastSegment = [self.currentStory getLastSegment];
        NSLog(@"last seg text: %@", self.lastSegment.text);
        self.initialFragment = self.lastSegment.text;
        
        self.initialFragmentLength = self.initialFragment.length;
        
        //    NSLog(@"the inital %@", self.initialFragmentLength);
        
        self.textView.text = self.initialFragment;
        //        NSLog(@"we just tried to init the current story %@", self.currentStory.title);
        //        NSLog(@"we this is level 0 %@ ", self.currentStory.levels);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    [self.textView setReturnKeyType:UIReturnKeyDone];
    self.networkController = [NetworkController sharedService];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //    [userDefaults setObject:@"dug" forKey:@"username"];
    [userDefaults synchronize];
    NSString *defaultsUsername = [userDefaults objectForKey:@"username"];
    if (!defaultsUsername){
        NSLog(@"there was no username in userdfaults");
        //        [self.networkController createNewAccountWithUserName:@"grumbler" password:@"password" email:@"grumbler@slug.website" location:@"hereOrThere"  withCompletionHandler:^(NSString *token) {
        //            [userDefaults setObject:token forKey:@"username"];
        //        };
        //        self.username = [userDefaults objectForKey:@"username"];
//        [self performSegueWithIdentifier:@"show_login" sender:self];
        //        [self.networkController createNewAccountWithUserName:@"farrrt" password:@"password" email:@"nudedmyapp@sadfadfas()" location:@"nunyah" withCompletionHandler:^(NSString *token, NSString *username) {
        //            NSLog(@"in the collback we get the username %@", username);
        //            [userDefaults setObject:token forKey:@"token"];
        //            [userDefaults synchronize];
        //            self.username = username;
        //        }];
    } else {
        NSLog(@"self.username is %@", self.username);
        self.username = defaultsUsername;
    }
//    if (self.username == nil){
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        self.username = [userDefaults objectForKey:@"username"];
//    }


    
//    NSString *token = [userDefaults stringForKey:@"token"];
//    if (!token) {
//        #warning we shut be presenting modal a login controller
//        NSLog(@"there was no token");
////        [self.networkController createNewAccountWithUserName:@"lulwat" password:@"passwordJokes"];
//    }
    

    
    
//    self.username = @"booger";
//    [self.networkController fetchStoryWithIdentifier:@"LDFKSDLFJ" withCompletionHandler:^(NSDictionary *results, NSString *error) {
//    [self.networkController fetchStoryWithCompletionHandler:^(NSDictionary *results, NSString *error) {


    
    

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SHOW_READ_FROM_WRITE"]){
        ReadStoryViewController *readVC = segue.destinationViewController;
        readVC.selectedStory = self.currentStory;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (range.location <= self.initialFragmentLength - 1){
        return NO;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"hit return");
    NSRange rangeOfNewText = NSMakeRange(self.initialFragmentLength, self.textView.text.length - self.initialFragmentLength);
    NSString *newText = [self.textView.text substringWithRange:rangeOfNewText];
    NSString *trimmedString = [newText stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableDictionary *newSegDictionary = [[NSMutableDictionary alloc] init];
    NSString *segmentText = [ NSString stringWithFormat: @"%@ ", trimmedString];
    
    
//    [newSegDictionary setObject:[NSNumber numberWithInt:2] forKey:@"levelId"];
    NSLog(@"my username prop immediatly b4 the postdict set: %@", self.username);
    [newSegDictionary setObject:self.username forKey:@"author"];
    [newSegDictionary setObject:segmentText forKey:@"postBody"];
    
    NSLog(@"last segment.storyID %@", self.lastSegment.storyId);
    [newSegDictionary setObject:self.lastSegment.storyName forKey:@"storyName"];
    [newSegDictionary setObject:self.lastSegment.storyId forKey:@"storyId"];
    
 #warning update this to actually grab the username from ns user defaults


    NSLog(@"dictionary text %@", newSegDictionary[@"postBody"]);

    
    Segment *newSeg = [[Segment alloc] initWithDictionary:newSegDictionary];
//    [self.networkController postSegment:newSeg];
    [self.currentStory addSegment:newSeg];
    NSLog(@"previous post was layer %ld, this one is layer %ld", self.currentStory.levels.count, [self.currentStory getLastSegment].levelId);
//    [self.networkController postSegment:self.currentStory.getLastSegment];
    [self.networkController postSegment:self.currentStory.getLastSegment withUserName:self.username];
    [self performSegueWithIdentifier:@"SHOW_READ_FROM_WRITE" sender:self];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}





@end
