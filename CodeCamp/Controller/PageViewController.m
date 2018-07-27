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
#import "Shower.h"
#import "Arcade.h"

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
int myUpdateTime = 1;
int noDrinkWarning = 1;
int noFoodWarning = 1;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Sounds
    NSURL *soundGameOverURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"game_over" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundGameOverURL, &soundGameOver);
    
    NSURL *soundBlobIsSadURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blob_is_sad" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundBlobIsSadURL, &soundBlobIsSad);
    
    NSURL *soundBlobIsAngryURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blob_is_angry" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundBlobIsAngryURL, &soundBlobIsAngry);
    
    NSURL *soundBlobIsEatingURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blob_is_eating" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundBlobIsEatingURL, &soundBlobIsEating);
    
    NSURL *soundBlobIsDrinkingURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"blob_is_drinking" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundBlobIsDrinkingURL, &soundBlobIsDrinking);
    
    NSURL *soundBuyDrinksURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buy_drinks" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundBuyDrinksURL, &soundBuyDrinks);
    
    NSURL *soundBuyFoodURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"buy_food" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundBuyFoodURL, &soundBuyFood);
    
    NSURL *soundPageturnURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"page_turn" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundPageturnURL, &soundPageturn);
    
    NSURL *soundClickMenuURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"click_menu" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundClickMenuURL, &soundClickMenu);
    
    NSURL *soundClickMiniGameURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"click_minigame" ofType:@"mp3"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundClickMiniGameURL, &soundClickMinigame);
    
    // Hide the Tab Bar by default
    [self.tabBarController.tabBar setHidden:YES];
    
    // Handle Swipes to change between screens
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipe];
    
    // Handle Swipes to show or hide the Tab Bar
    self.upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.upSwipe];
    
    self.downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:self.downSwipe];

    // Handle tap on screen
    mySharesView = Share.sharedSingleton;
    
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
    needViewTimer = [NSTimer scheduledTimerWithTimeInterval: myUpdateTime
                                         target: self
                                       selector:@selector(onTick:)
                                       userInfo: nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:true];
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
    petView.frame = CGRectMake(width/2 - petViewWidth /2, height/2 + petViewHeight /*petViewHeight/2*/, petViewWidth, petViewHeight);
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
    // If hunger is below 20;
    if([mySharesView getIntFromKey:HUNGER] <= HUNGER_LIMIT )
    {
        [self.view addSubview:hungerView];
        AudioServicesPlaySystemSound(soundBlobIsAngry);
    }
    else
    {
        [hungerView removeFromSuperview];
    }
    
    if([mySharesView getIntFromKey:THIRST] <= THIRST_LIMIT )
    {
        [self.view addSubview:thirstView];
        AudioServicesPlaySystemSound(soundBlobIsAngry);
    }
    else
    {
        [thirstView removeFromSuperview];
    }
    
    if([mySharesView getIntFromKey:DIRT] <= DIRT_LIMIT)
    {
        UIImage *myimg = [UIImage imageNamed:@"dirt"];
        petView.image=myimg;
        [self.view addSubview:petView];
    }
    else
    {
        UIImage *myimg = [UIImage imageNamed:@"blob"];
        petView.image=myimg;
        [self.view addSubview:petView];
    }
    
    if([mySharesView getIntFromKey:DRINKS]<3){
        if(noDrinkWarning == 1){
            [self disptachDrinkWarning];
        }
    }else{
        noDrinkWarning = 1;
    }
    
    if([mySharesView getIntFromKey:HUNGER]<3){
        if(noFoodWarning == 1){
            [self disptachFoodWarning];
        }
    }else{
        noFoodWarning = 1;
    }
    
    if([mySharesView getIntFromKey:@"life"] == 0){
        NSLog(@"Dead");
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"GOScreen"];
        [self presentViewController:vc animated:YES completion:nil];
        AudioServicesPlaySystemSound(soundGameOver);
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
                3 -> Shower
                4 -> Arcade
             */
        switch (self.tabBarController.selectedIndex) {
            case 0:
                self.tabBarController.selectedIndex = 1;
                AudioServicesPlaySystemSound(soundPageturn);
                break;
            case 1:
                self.tabBarController.selectedIndex = 2;
                AudioServicesPlaySystemSound(soundPageturn);
                break;
            case 2:
                self.tabBarController.selectedIndex = 3;
                break;
            case 3:
                self.tabBarController.selectedIndex = 4;
                break;
            case 4:
                self.tabBarController.selectedIndex = 4;
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
                3 -> Shower
                4 -> Arcade
             */
        switch (self.tabBarController.selectedIndex) {
            case 0:
                self.tabBarController.selectedIndex = 0;
                break;
            case 1:
                self.tabBarController.selectedIndex = 0;
                AudioServicesPlaySystemSound(soundPageturn);
                break;
            case 2:
                self.tabBarController.selectedIndex = 1;
                AudioServicesPlaySystemSound(soundPageturn);
                break;
            case 3:
                self.tabBarController.selectedIndex = 2;
                break;
            case 4:
                self.tabBarController.selectedIndex = 3;
                break;

            default:
                self.tabBarController.selectedIndex = 0;
                break;
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        [self.tabBarController.tabBar setHidden:NO];
        AudioServicesPlaySystemSound(soundClickMenu);
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        [self.tabBarController.tabBar setHidden:YES];
        AudioServicesPlaySystemSound(soundClickMenu);
    }
}

- (void) handleTap: (UITapGestureRecognizer*) recognize
{
    switch (self.tabBarController.selectedIndex) {
        case 0:
            NSLog(@"Kitchen");
            [Kitchen doAction: mySharesView :self];
            AudioServicesPlaySystemSound(soundBlobIsEating);
            break;
        case 1:
            NSLog(@"Saloon");
            [Saloon doAction: mySharesView :self];
            AudioServicesPlaySystemSound(soundBlobIsDrinking);
            break;
        case 2:
            NSLog(@"Store");
            [Store doAction: mySharesView:self];
            break;
        case 3:
            NSLog(@"Shower");
            [Shower doAction: mySharesView:self];
            break;
        case 4:
            NSLog(@"Arcade");
            [Arcade doAction:mySharesView :self];
            break;
        default:
            break;
            
            
    }
    [self checkNeedView];
}


-(void)disptachDrinkWarning{
    noDrinkWarning = 0;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Drinks are almost empty!" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}


-(void)disptachFoodWarning{
    noFoodWarning = 0;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Food is almost empty!" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
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
