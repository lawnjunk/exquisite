//
//  ReadStoryViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "ReadStoryViewController.h"
#import "NetworkController.h"
#import "Story.h"
#import "Segment.h"

@interface ReadStoryViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *readStoryTextView;

@property (strong,nonatomic) UIGestureRecognizer *tapTextFiled;
@end

@implementation ReadStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NetworkController sharedService] fetchStoryWithCompletionHandler:^(NSDictionary *results, NSString *error) {
//        NSLog(@"results is %@", results);
//        self.selectedStory = [[Story alloc] initWithJSONData:results];
//    }];
//    
//    NSLog(@"first level = %@", self.selectedStory.levels[0]);
//    
//    Level *currentLevel = self.selectedStory.levels[0];
//    
//    Segment *newSegment = currentLevel.segments[0];
//    NSLog(@" current segement text = %@",newSegment.text);
//    
//    
    NSLog(@"selected story title %@", self.selectedStory.title);
    
    
    // Do any additional setup after loading the view.
//    self.tapTextFiled.delegate = self;
//    self.tapTextFiled = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(textTapped:)];
//    
//    NSString *text = @"whatsupp madude i was wondering what dude";
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
//    NSRange first = [text rangeOfString:@"whatsupp madude"];
//    NSRange second = [text rangeOfString:@"i was wondering what dude"];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:first];
//    [str addAttribute:@"fragmentIndex" value:@1 range:first];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:first];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:second];
//    [str addAttribute:@"fragmentIndex" value:@2 range:second];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:second];
//    self.readStoryTextView.attributedText = str;
//    self.readStoryTextView.editable = false;
//    self.readStoryTextView.selectable = false;
//    [self.readStoryTextView addGestureRecognizer:self.tapTextFiled];
//    
//    
    
    
    NSMutableAttributedString *fulltext = [[NSMutableAttributedString alloc] init];

    int levelcount = 0;
    for(Level *level in self.selectedStory.levels){
        levelcount += 1;
        NSLog(@" this the level %@", level);
        for (Segment *seg in level.segments) {
            
            
            NSLog(@"%@", seg.text);
            NSMutableAttributedString *tempAtr = [[NSMutableAttributedString alloc] initWithString:seg.text];
            //NSAttributedString *temp = [[NSAttributedString alloc] initWithString:seg.text];
            //[mutStr appendAttributedString:temp];
            //
            //NSMutableAttributedString *currentSegmentText = [[NSMutableAttributedString alloc] initWithString:seg.text];
            NSRange fullSegment = [seg.text rangeOfString:seg.text];
            if (levelcount %2  == 0){
                [tempAtr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:fullSegment];
            } else {
                [tempAtr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:fullSegment];
            }
//            NSAttributedString *str = [[NSAttributedString alloc] initWithString:seg.text];
            
            
            [fulltext appendAttributedString:tempAtr];
//            NSLog(@"%@", fulltext);

        }
    }
    
    
    self.readStoryTextView.attributedText = fulltext;
    NSLog(@"%@",fulltext);
//    self.readStoryTextView.text = fullText;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textTapped:(UITapGestureRecognizer *)recognizer {
    UITextView *textView = (UITextView *) recognizer.view;
    
    NSLayoutManager *layoutManager = textView.layoutManager;
    CGPoint location = [recognizer locationInView:textView];
    location.x -= textView.textContainerInset.left;
    location.y -= textView.textContainerInset.right;
    
//    NSLog(@"we got the location %@", NSStringFromCGPoint(location));
    
    NSUInteger characterIndex;
    characterIndex = [layoutManager characterIndexForPoint:location inTextContainer:textView.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
    
    if (characterIndex < textView.textStorage.length) {
        NSRange range;
        NSDictionary *attributes = [textView.textStorage attributesAtIndex:characterIndex effectiveRange:&range];
        //        NSLog(@" %@, %@", attributes, NSStringFromRange(range));
        
        if ( attributes[@"fragmentIndex"] == @1) {
            NSLog(@"selected the first dude");
        } else if (attributes[@"fragmentIndex"] == @2 ){
            NSLog(@"selected dude number 2");
        }
    }
}

- (IBAction)finishedButtonPressed:(UIButton *)sender {
  [self dismissViewControllerAnimated:true completion:^{
    //Done Berah
  }];
}




#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}


@end
