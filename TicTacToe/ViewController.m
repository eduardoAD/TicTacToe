//
//  ViewController.m
//  TicTacToe
//
//  Created by Eduardo Alvarado Díaz on 12/15/14.
//  Copyright (c) 2014 Organization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
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
@property NSArray *combinationsToWin;
@property (nonatomic, assign, getter=isTurnX) BOOL turnX;
@property (nonatomic, assign, getter=isGameOver) BOOL gameOver;
@property int turn;
@property CGPoint originalCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelsArray = [NSArray arrayWithObjects:self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive, self.labelSix, self.labelSeven, self.labelEight, self.labelNine, nil];
    self.combinationsToWin = [[NSArray alloc] initWithObjects:
                              @[self.labelOne, self.labelTwo, self.labelThree],
                              @[self.labelFour, self.labelFive, self.labelSix],
                              @[self.labelSeven, self.labelEight, self.labelNine],
                              @[self.labelOne, self.labelFour, self.labelSeven],
                              @[self.labelTwo, self.labelFive, self.labelEight],
                              @[self.labelThree, self.labelSix, self.labelNine],
                              @[self.labelOne, self.labelFive, self.labelNine],
                              @[self.labelThree, self.labelFive, self.labelSeven], nil];
    [self newGame];
}

- (void)viewDidAppear:(BOOL)animated {
    self.originalCenter = self.whichPlayerLabel.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newGame{
    for (UILabel *label in self.labelsArray) {
        label.text = @"";
    }
    self.turn = 1;
    self.turnX = YES;
    [self setTurnText:self.whichPlayerLabel];
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
    self.turn++;
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
        [self checkWhoWon];
        if (![self isGameOver]) {
            [self changeTurn];
        }
    }
}

-(NSString *)whoWon{
    for (NSArray *combo in self.combinationsToWin) {
        int count = 0;
        for (UILabel *label in combo) {
            if ([label.text isEqualToString:self.whichPlayerLabel.text]) {
                count ++;
                if (count == 3) {
                    return [NSString stringWithFormat:@"%@ has won :D",self.whichPlayerLabel.text];
                }
            }
        }
    }
    return @"";
}

-(void)checkWhoWon{
    NSString *winnerTitle = [self whoWon];
    NSString *winnerMsg = @"";

    if ([winnerTitle isEqualToString:@""]) {
        self.gameOver= NO;
    }else{
        self.gameOver = YES;
        if (self.turn == 9) {
            winnerMsg = @"That was close!";
        }else{
            winnerMsg = @"Play again";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:winnerTitle message:winnerMsg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        [self newGame];
    }
}

- (IBAction)onDragToLabel:(UIPanGestureRecognizer *)panGesture {
    CGPoint point = [panGesture locationInView:self.view];
    self.whichPlayerLabel.center = point;
    if (CGRectContainsPoint(self.whichPlayerLabel.frame, point)) {
        self.whichPlayerLabel.center = point;
        if ([panGesture state] == UIGestureRecognizerStateEnded) {
            UILabel *label = [self findLabelUsingPoint:point];
            self.whichPlayerLabel.center = self.originalCenter;
            if (label != nil) {
                [self setTurnText:label];
                [self checkWhoWon];
                if (![self isGameOver]) {
                    [self changeTurn];
                }
            }
        }
    }
}

@end
