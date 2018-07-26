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
#import "Store.h"
#import "Saloon.h"
#import "Kitchen.h"

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
    
    // Handle Swipes
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipe];
    
    mySharesView = Share.sharedSingleton;
    

    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipe];
    
    self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:self.tapGR];
    
    //creature Setup
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
    petView.frame = CGRectMake(width/2 - petViewWidth /2, height/2 + petViewHeight*1.1 /*petViewHeight/2*/, petViewWidth, petViewHeight);
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
    
    if([mySharesView getIntFromKey:@"life"] == 0){
        NSLog(@"Dead");
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"GOScreen"];
        [self presentViewController:vc animated:YES completion:nil];
        //[UIViewController presentViewController:viewController animated:NO completion:nil];
        return;
        
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
            /*
                0 -> Home
                1 -> Saloon
                2 -> Mall
                3 -> Options
             */
        switch (self.tabBarController.selectedIndex) {
            case 0:
                self.tabBarController.selectedIndex = 1;
                break;

            case 1:
                self.tabBarController.selectedIndex = 2;
                break;

            case 2:
                self.tabBarController.selectedIndex = 2;
                break;

            default:
                self.tabBarController.selectedIndex = 0;
                break;
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            /*
                0 -> Home
                1 -> Saloon
                2 -> Mall
                3 -> Options
             */
        switch (self.tabBarController.selectedIndex) {
            case 0:
                self.tabBarController.selectedIndex = 0;
                break;

            case 1:
                self.tabBarController.selectedIndex = 0;
                break;

            case 2:
                self.tabBarController.selectedIndex = 1;
                break;

            default:
                self.tabBarController.selectedIndex = 0;
                break;
        }
    }
    

}

- (void) handleTap: (UITapGestureRecognizer*) recognize
{
    
    switch (self.tabBarController.selectedIndex) {
        case 0:
            [Kitchen doAction: mySharesView];
            break;
        case 1:
            [Saloon doAction: mySharesView];
            break;
        case 2:
            [Store doAction: mySharesView:self];
        default:
            break;
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
