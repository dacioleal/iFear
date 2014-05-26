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
#import <AVFoundation/AVFoundation.h>
#import "MainViewController.h"

@interface EntradaViewController () {
    
   
}

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
    
    MainScene *mainScene = [MainScene sceneWithSize:CGSizeMake(1024, 768)];
    
    SKView *spriteView = (SKView *) self.view;
    
    [spriteView presentScene:mainScene];
    
    
    // Animación para la aparición de la pantalla suavemente modificando la opacidad
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.9];
    opacityAnimation.duration = 2.5;
    
    [spriteView.layer addAnimation:opacityAnimation forKey:@"opacity"];
    
    
    // Reproduce los sonidos
    
    //[self playEntranceSound];
    [self playTorchsSound];
    [self playBackgroundSound];
        
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Métodos propios


// Método para reproducir sonido inicial de entrada

- (void) playEntranceSound
{
    NSString *entranceSoundPath = [[NSBundle mainBundle] pathForResource:@"sonido_entrada" ofType:@"mp3"];
    NSURL *entranceAudioURL = [NSURL fileURLWithPath:entranceSoundPath];
    NSError *error;
    self.audioPlayerOne = [[AVAudioPlayer alloc] initWithContentsOfURL:entranceAudioURL error:&error];
    
    [self.audioPlayerOne prepareToPlay];
    [self.audioPlayerOne playAtTime:self.audioPlayerOne.deviceCurrentTime + 0.3];
    
}

// Método para reproducir sonido de las antorchas

- (void) playTorchsSound
{
    NSString *torchsSoundPath = [[NSBundle mainBundle] pathForResource:@"sonido_antorcha" ofType:@"mp3"];
    NSURL *torchAudioURL = [NSURL fileURLWithPath:torchsSoundPath];
    NSError *error;
    self.audioPlayerTwo = [[AVAudioPlayer alloc] initWithContentsOfURL:torchAudioURL error:&error];
    self.audioPlayerTwo.numberOfLoops = -1;
    [self.audioPlayerTwo prepareToPlay];
    [self.audioPlayerTwo playAtTime:self.audioPlayerTwo.deviceCurrentTime + 1.6];
}

// Método para reproducir sonido de fondo

- (void) playBackgroundSound
{
    NSString *backgroundSoundPath = [[NSBundle mainBundle] pathForResource:@"sonido_fondo" ofType:@"mp3"];
    NSURL *backgroundAudioURL = [NSURL fileURLWithPath:backgroundSoundPath];
    NSError *error;
    self.audioPlayerThree = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundAudioURL error:&error];
    self.audioPlayerThree.numberOfLoops = -1;
    [self.audioPlayerThree prepareToPlay];
    [self.audioPlayerThree playAtTime:self.audioPlayerThree.deviceCurrentTime + 2.0];
    
}

// Método para realizar la animación de la cadena

- (void) makeChainAnimation {
    
    UIView *view = [self.view viewWithTag:1];
    [UIView animateWithDuration:2.4 animations:^{
        view.center = CGPointMake(view.center.x - 770, view.center.y);
    }];
}

// Método para cargar la pantalla del menu

- (void) loadMainScreen
{
    [self.audioPlayerTwo stop];
    [self.audioPlayerThree stop];
        
    
    MainViewController *mainViewController = (MainViewController *)self.parentViewController;
    UIViewController *menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];
    [mainViewController specialTransitionFromViewController:self toViewController:menuViewController];
    
    
}



#pragma mark - IBActions

- (IBAction)entrarPushButton:(id)sender
{
    SKView *spriteView = (SKView *) self.view;
    MainScene *scene = (MainScene *)[spriteView scene];
    [scene riseDoor];
    [self makeChainAnimation];
    [self performSelector:@selector(loadMainScreen) withObject:sender afterDelay:6.0]; //Ponemos un retardo para permitir las animaciones y luego pasar al menu
    
}





@end




