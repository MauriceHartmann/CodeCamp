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

int gameCondition = 0; //0 = Game is not started. 1 = Game finished. 2 = Game is running
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

//Add all Buttons to an Array
-(void)viewDidLoad{
    gameCondition = 0;
    timeLeft = 1.5; // Starttime. Wil decrease after each Round
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
        return; // Abort if Game is not running anymore
    }
    sender.backgroundColor = [UIColor whiteColor];
    if([gameTimer isValid]) //Stop timer
        [gameTimer invalidate];
    gameTimer = nil;
    if(sender == temp){
        if(timeLeft < 0.5){ // If Button is tapped within this TimeLimit the Game is won
            [self gameFinished:@"Won"];
            return;
        }
        [self chooseNewBtn];
        gameTimer = [NSTimer scheduledTimerWithTimeInterval: timeLeft
                                                    target: self
                                                  selector:@selector(onGameTick:)
                                                  userInfo: nil repeats:NO];
        timeLeft -= 0.1; 
    }else{
        [self gameFinished:@"Lost"];
    }
}

-(int)getRandomNumberBetween:(int)from and:(int)to { // Generates a random number between two numbers
    
    return (int)from + arc4random() % (to-from+1);
}

-(void) chooseNewBtn{ // Chooses a Button and colors it red
    int num = [self getRandomNumberBetween:0 and:8];
    while(num == lastNum){ // Avoid using the same Button twice in a row to avoid confusion
        num = [self getRandomNumberBetween:0 and:8];
    }
    temp = [btnArray objectAtIndex:num];
    temp.backgroundColor = [UIColor redColor];
    lastNum = num;
    
}

-(void)gameFinished:(NSString*) title{ //Ends the Game and sets the title of the return Button to either Won or Lost
    gameCondition = 1;
    [_BackButton setTitle:title forState:UIControlStateNormal];
    [gameTimer invalidate];
    gameTimer = nil;
    
}

@end
