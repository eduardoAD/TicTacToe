//
//  ViewController.m
//  TicTacToe
//
//  Created by Eduardo Alvarado Díaz on 12/15/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelOne;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) IBOutlet UILabel *labelFour;
@property (strong, nonatomic) IBOutlet UILabel *labelFive;
@property (strong, nonatomic) IBOutlet UILabel *labelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UILabel *labelEight;
@property (strong, nonatomic) IBOutlet UILabel *labelNine;
@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@property NSArray *labelsArray;
@property (nonatomic, assign, getter=isTurnX) BOOL turnX;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.turnX = YES;
    [self setTurnText:self.whichPlayerLabel];
    self.labelsArray = [NSArray arrayWithObjects:self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTurnText:(UILabel *)label{
    if ([self isTurnX]) {
        label.textColor = [UIColor blueColor];
        label.text = @"X";
    }else{
        label.textColor = [UIColor redColor];
        label.text = @"O";
    }
}

-(void)changeTurn{
    self.turnX = !self.turnX;
    [self setTurnText:self.whichPlayerLabel];
}

- (UILabel *)findLabelUsingPoint:(CGPoint)point{
    for (UILabel *label in self.labelsArray)
    {
        if(CGRectContainsPoint(label.frame, point)) {
            if ([label.text isEqualToString:@""]) {
                return label;
            }
        }
    }
    return nil;
}

-(IBAction)onLabelTapped:(id)sender{
    CGPoint tapPoint = [sender locationInView:self.view];
    //NSLog(@"%f, %f",tapPoint.x,tapPoint.y);
    UILabel *label = [self findLabelUsingPoint:tapPoint];
    if (label != nil) {
        [self setTurnText:label];
        [self changeTurn];
    }
}

@end
