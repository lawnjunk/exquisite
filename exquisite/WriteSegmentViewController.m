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

@end

@implementation WriteSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    [self.textView setReturnKeyType:UIReturnKeyDone];
    self.networkController = [NetworkController sharedService];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"token"];
    if (!token) {
        #warning we shut be presenting modal a login controller
        NSLog(@"there was no token");
        [self.networkController createNewAccountWithUserName:@"lulwat" password:@"passwordJokes"];
    }
    
    [self.networkController fetchStoryWithIdentifier:@"LDFKSDLFJ" withCompletionHandler:^(NSDictionary *results, NSString *error) {
//    [self.networkController fetchStoryWithCompletionHandler:^(NSDictionary *results, NSString *error) {
//        NSLog(@"whatttt the fuuuuuuk are we dooing");
//        NSLog(@"%@ thesse results", results);
        self.currentStory = [[Story alloc] initWithJSONData:results];
//        NSLog(@"we just tried to init the current story %@", self.currentStory.title);
//        NSLog(@"we this is level 0 %@ ", self.currentStory.levels);
    }];
    
    
    self.lastSegment = [self.currentStory getLastSegment];
    NSLog(@"last seg text: %@", self.lastSegment.text);
    self.initialFragment = self.lastSegment.text;
    
    self.initialFragmentLength = self.initialFragment.length;
    
//    NSLog(@"the inital %@", self.initialFragmentLength);
    
    self.textView.text = self.initialFragment;
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
    [newSegDictionary setObject:segmentText forKey:@"text"];
 #warning update this to actually grab the username from ns user defaults
    [newSegDictionary setObject:@"nacnud" forKey:@"user"];
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    [newSegDictionary setValue:dateString forKey:@"createdAt"];
    NSLog(@"dictionary text %@", newSegDictionary[@"text"]);
    Segment *newSeg = [[Segment alloc] initWithDictionary:newSegDictionary];
    [self.currentStory addSegment:newSeg];
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
