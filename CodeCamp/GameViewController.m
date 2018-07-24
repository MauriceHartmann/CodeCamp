//
//  GameViewController.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "NotificationHandler.m"

NotificationHandler* notifications;

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    notifications = [[NotificationHandler alloc]init];
    
    [notifications initNotification];
    
    // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
    // including entities and graphs.
    GKScene *scene = [GKScene sceneWithFileNamed:@"GameScene"];
    
    // Get the SKScene from the loaded GKScene
    GameScene *sceneNode = (GameScene *)scene.rootNode;
    
    // Copy gameplay related content over to the scene
    sceneNode.entities = [scene.entities mutableCopy];
    sceneNode.graphs = [scene.graphs mutableCopy];
    
    // Set the scale mode to scale to fit the window
    sceneNode.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:sceneNode];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    /*
     Showing time on screen
     */
    _timeLabel.hidden = YES;
    _timeLabel.text = [[NSDate date] description];
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(showTime)
                                   userInfo:nil
                                    repeats:YES];
    
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)showNotification:(id)sender {
    [notifications sendNotification:@"XYZ hat Hunger" forSubtitle:@"" forBody:@"XYZ hat eine Weile nichts gegessen. Schaue doch mal nach ihm" forIntervall:5];
    
}

//get current time as NSString
-(NSString *) getCurrentTime {
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    return resultString;
}


-(void)showTime{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    _timeLabel.hidden = NO;
    _timeLabel.text=resultString;
}


@end
