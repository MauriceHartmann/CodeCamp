//
//  PageViewController.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "PageViewController.h"
#import "AppDelegate.h"
#import "Share.h"
#import "Creature.h"
@interface PageViewController ()

@end

UIImageView * petView;
UIImageView * hungerView;
UIImageView * thirstView;

@implementation PageViewController
Share* mySharesView;
CGFloat height;
CGFloat width;
int petViewWidth;
int petViewHeight;
NSTimer *needViewTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mySharesView = Share.sharedSingleton;
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    petViewWidth = width * 0.5;
    petViewHeight = height * 0.2;
    
    [self initViews];
    [self checkNeedView];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self checkNeedView];
    [super viewDidAppear:false];
    needViewTimer = [NSTimer scheduledTimerWithTimeInterval: time_tick_factor
                                         target: self
                                       selector:@selector(onTick:)
                                       userInfo: nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:false];
    [needViewTimer invalidate];
}

//timer method that ticks every Intervall of the timer
-(void)onTick:(NSTimer*)timer
{
    [self checkNeedView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initViews
{
    petView= [[UIImageView alloc] init];
    UIImage *myimg = [UIImage imageNamed:@"blob"];
    petView.image=myimg;
    petView.frame = CGRectMake(width/2 - petViewWidth /2, height/2 + petViewHeight/2, petViewWidth, petViewHeight);
    [self.view addSubview:petView];
    
    hungerView= [[UIImageView alloc] init];
    myimg = [UIImage imageNamed:@"hunger"];
    hungerView.image=myimg;
    hungerView.frame = CGRectMake(width/2 , height/2 , petViewWidth , petViewHeight);
    
    thirstView= [[UIImageView alloc] init];
    myimg = [UIImage imageNamed:@"thirst"];
    thirstView.image=myimg;
    thirstView.frame = CGRectMake(width/2 - petViewWidth , height/2 , petViewWidth , petViewHeight);
}

-(void) checkNeedView
{
    if([mySharesView getIntFromKey:HUNGER] <= HUNGER_LIMIT )
    {
        [self.view addSubview:hungerView];
    }
    else
    {
        [hungerView removeFromSuperview];
    }
    
    if([mySharesView getIntFromKey:THIRST] <= THIRST_LIMIT)
    {
        [self.view addSubview:thirstView];
    }
    else
    {
        [thirstView removeFromSuperview];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
