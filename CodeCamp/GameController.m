//
//  Game.m
//  CodeCamp
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "GameController.h"
#import "Share.h"
#import "Creature.h"

@interface GameController ()

@end

int gameCondition = 0;
NSTimer *gameTimer;
NSMutableArray *btnArray;
double timeLeft;
UIButton *temp;
int lastNum;

@implementation GameController
- (IBAction)BackButton:(UIButton *)sender {
    if(gameCondition == 0){
        [self chooseNewBtn];
        gameTimer = [NSTimer scheduledTimerWithTimeInterval: timeLeft
                                                     target: self
                                                   selector:@selector(onGameTick:)
                                                   userInfo: nil repeats:NO];
        
        timeLeft -= 0.1;
        gameCondition = 2;
    }else if(gameCondition == 1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        
    }
}

-(void)viewDidLoad{
    gameCondition = 0;
    timeLeft = 1.5;
    btnArray = [[NSMutableArray alloc]initWithCapacity:9];
    [btnArray addObject:_Btn1];
    [btnArray addObject:_Btn2];
    [btnArray addObject:_Btn3];
    [btnArray addObject:_Btn4];
    [btnArray addObject:_Btn5];
    [btnArray addObject:_Btn6];
    [btnArray addObject:_Btn7];
    [btnArray addObject:_Btn8];
    [btnArray addObject:_Btn9];
}

-(void)onGameTick:(NSTimer*)timer{
    gameCondition = 1;
    [self gameFinished:@"Lost"];
}

- (IBAction)clicked:(UIButton *)sender {
    if(gameCondition!=2){
        return;
    }
    sender.backgroundColor = [UIColor whiteColor];
    if([gameTimer isValid])
        [gameTimer invalidate];
    gameTimer = nil;
    if(sender == temp){
        
        if(timeLeft < 0.6){
            [self gameFinished:@"Won"];
            return;
        }
        [self chooseNewBtn];
        gameTimer = [NSTimer scheduledTimerWithTimeInterval: timeLeft
                                                    target: self
                                                  selector:@selector(onGameTick:)
                                                  userInfo: nil repeats:NO];
        timeLeft -= (timeLeft*0.2);
    }else{
        [self gameFinished:@"Lost"];
    }
}

-(int)getRandomNumberBetween:(int)from and:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

-(void) chooseNewBtn{
    int num = [self getRandomNumberBetween:0 and:8];
    while(num == lastNum){
        num = [self getRandomNumberBetween:0 and:8];
    }
    temp = [btnArray objectAtIndex:num];
    temp.backgroundColor = [UIColor redColor];
    lastNum = num;
    
}

-(void)gameFinished:(NSString*) title{
    gameCondition = 1;
    [_BackButton setTitle:title forState:UIControlStateNormal];
    [gameTimer invalidate];
    gameTimer = nil;
    
}

@end
