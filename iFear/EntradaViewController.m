//
//  EntradaViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 28/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "EntradaViewController.h"
#import "MainScene.h"
#import <SpriteKit/SpriteKit.h>

@interface EntradaViewController ()

@end

@implementation EntradaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    MainScene *mainScene = [MainScene sceneWithSize:CGSizeMake(1024, 768)];
    
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene:mainScene];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.9];
    opacityAnimation.duration = 2.0;
    
    [spriteView.layer addAnimation:opacityAnimation forKey:@"opacity"];
    
    
    AVAudioPlayer *audioPlayer;
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"sonido" ofType:@"mp3"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&error];
    //audioPlayer.delegate = self;
    
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
