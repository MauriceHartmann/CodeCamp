//
//  OptionViewController.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionViewController.h"
#import "AppDelegate.h"
#import "Share.h"
#import "Creature.h"
@interface OptionViewController ()

@end

@implementation OptionViewController
Share* myShares;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myShares = Share.sharedSingleton;
}

- (IBAction)delayedNot:(UIButton *)sender {
    [Creature sendNotification:@"Debug" forSubtitle:@"delayed" forBody:@"Called by Debug Menu" forIntervall:20];
    
}

- (IBAction)deleteFile:(UIButton *)sender {
    NSLog(@"call");
    [AppDelegate deleteFile];
}
- (IBAction)triggerHunger:(UIButton *)sender {
    NSNumber *num = [NSNumber numberWithInt:20];
    [myShares changeValueOfKey:@"hunger":num];
}
- (IBAction)triggerThirst:(UIButton *)sender {
    NSNumber *num = [NSNumber numberWithInt:20];
    [myShares changeValueOfKey:@"thirst":num];
    
}
- (IBAction)killAnimal:(UIButton *)sender {
    [myShares updateKeyBy:@"life" :(-1)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
