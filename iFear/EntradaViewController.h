//
//  EntradaViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 28/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EntradaViewController : UIViewController

@property (nonatomic, strong) AVAudioPlayer *audioPlayerOne;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerTwo;
@property (nonatomic, strong) AVAudioPlayer *audioPlayerThree;
- (IBAction)entrarPushButton:(id)sender;

@end
