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
#import "UIColor+ColorPalet.h"

@interface ReadStoryViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *readStoryTextView;

@property (strong,nonatomic) UIGestureRecognizer *tapTextFiled;
@end

@implementation ReadStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.readStoryTextView.editable = false;
    self.readStoryTextView.selectable = false;
    self.readStoryTextView.scrollEnabled = true;
    NSLog(@"selected story title %@", self.selectedStory.title);
    self.tapTextFiled = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(textTapped:)];

    NSMutableAttributedString *fulltext = [[NSMutableAttributedString alloc] initWithString:@"\t\t"];
    int levelcount = 0;
    for(Level *level in self.selectedStory.levels){
        
        NSLog(@" this the level %@", level);
        Segment *seg = level.segments[0];
        
        
        NSLog(@"%@", seg.text);
        NSMutableAttributedString *tempAtr = [[NSMutableAttributedString alloc] initWithString:seg.text];
        
        NSRange fullSegment = [seg.text rangeOfString:seg.text];
        
        if (levelcount %2  == 0){
            [tempAtr addAttribute:NSForegroundColorAttributeName value:[UIColor tirqLight] range:fullSegment];
            [tempAtr addAttribute:@"levelId" value:[NSString stringWithFormat:@"%d", levelcount] range:fullSegment];
        } else {
            [tempAtr addAttribute:NSForegroundColorAttributeName value:[UIColor tirqMedium] range:fullSegment];
            [tempAtr addAttribute:@"levelId" value:[NSString stringWithFormat:@"%d", levelcount] range:fullSegment];
        }
        
        [fulltext appendAttributedString:tempAtr];
        levelcount += 1;
    }
    
    [fulltext addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21] range:NSMakeRange(0, fulltext.length -1)];
    self.readStoryTextView.attributedText = fulltext;
    [self.readStoryTextView addGestureRecognizer:self.tapTextFiled];
//    NSLog(@"%@",fulltext);
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
    
    NSLog(@"we got the location %@", NSStringFromCGPoint(location));
    
    NSUInteger characterIndex;
    characterIndex = [layoutManager characterIndexForPoint:location inTextContainer:textView.textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
    
    if (characterIndex < textView.textStorage.length) {
        NSRange range;
        NSDictionary *attributes = [textView.textStorage attributesAtIndex:characterIndex effectiveRange:&range];
        //        NSLog(@" %@, %@", attributes, NSStringFromRange(range));
        
        
        
        NSString *levelId = attributes[@"levelId"];
        NSLog(@"levelId at click is : %@", levelId);
        if ( [levelId isEqualToString:@"0" ]) {
            NSLog(@"selected the first dude");
        } else if ([levelId isEqualToString:@"1"] ){
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
