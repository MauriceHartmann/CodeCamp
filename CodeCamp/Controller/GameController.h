//
//  Game.h
//  CodeCamp
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#ifndef Game_h
#define Game_h

#import <UIKit/UIKit.h>

@interface GameController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *Btn1;
@property (weak, nonatomic) IBOutlet UIButton *Btn2;
@property (weak, nonatomic) IBOutlet UIButton *Btn3;
@property (weak, nonatomic) IBOutlet UIButton *Btn4;
@property (weak, nonatomic) IBOutlet UIButton *Btn5;
@property (weak, nonatomic) IBOutlet UIButton *Btn6;
@property (weak, nonatomic) IBOutlet UIButton *Btn7;
@property (weak, nonatomic) IBOutlet UIButton *Btn8;
@property (weak, nonatomic) IBOutlet UIButton *Btn9;
@property (weak, nonatomic) IBOutlet UIButton *BackButton;

-(int)getRandomNumberBetween:(int)from and:(int)to;
@end

#endif /* Game_h */
