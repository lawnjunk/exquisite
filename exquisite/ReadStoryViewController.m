//
//  ReadStoryViewController.m
//  exquisite
//
//  Created by drwizzard on 2/23/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

#import "ReadStoryViewController.h"

@interface ReadStoryViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *testTextView;
@property (strong,nonatomic) UIGestureRecognizer *tapTextFiled;
@end

@implementation ReadStoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tapTextFiled.delegate = self;
    self.tapTextFiled = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(textTapped:)];
    
    NSString *text = @"whatsupp madude i was wondering what dude";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange first = [text rangeOfString:@"whatsupp madude"];
    NSRange second = [text rangeOfString:@"i was wondering what dude"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:first];
    [str addAttribute:@"fragmentIndex" value:@1 range:first];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:first];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:second];
    [str addAttribute:@"fragmentIndex" value:@2 range:second];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:second];
    self.testTextView.attributedText = str;
    self.testTextView.editable = false;
    self.testTextView.selectable = false;
    [self.testTextView addGestureRecognizer:self.tapTextFiled];
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


#pragma turn of the time/battery status bar
-(BOOL)prefersStatusBarHidden {
    return true;
}


@end
