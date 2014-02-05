//
//  MainScene.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 28/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "MainScene.h"

@interface MainScene ()

@property BOOL contentCreated;

@end

@implementation MainScene

- (void) didMoveToView:(SKView *)view
{
    if (!self.contentCreated) {
        
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void) createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    [self addChild:[self newBackgroundImage]];
    [self addChild:[self newDoor]];
    [self addChild:[self newFrontImageColor]];
    [self addChild:[self newTorchsLightEffect]];
    [self addChild:[self newFrontImageLines]];
    [self addChild:[self newLogo]];
    [self addChild:[self newSmokeEmitter1]];
    [self addChild:[self newSmokeEmitter2]];
    [self addChild:[self newFireEmitter1]];
    [self addChild:[self newFireEmitter2]];
    [self fadeTorchs];
    
    
}

- (SKEmitterNode *) newFireEmitter1
{
    NSString *firePath = [[NSBundle mainBundle] pathForResource:@"FireParticle"
                                                         ofType:@"sks"];
    SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    fire.position = CGPointMake(55, 442);
    
    return fire;
}

- (SKEmitterNode *) newFireEmitter2
{
    NSString *firePath = [[NSBundle mainBundle] pathForResource:@"FireParticle"
                                                         ofType:@"sks"];
    SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    fire.position = CGPointMake(972, 442);
    
    return fire;
}

- (SKEmitterNode *) newSmokeEmitter1
{
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"SmokeParticle"
                                                          ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smoke.position = CGPointMake(55, 452);
    return smoke;
}

- (SKEmitterNode *) newSmokeEmitter2
{
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"SmokeParticle"
                                                          ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smoke.position = CGPointMake(972, 452);
    return smoke;
}

- (SKSpriteNode *) newBackgroundImage
{
    
    SKSpriteNode *backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"arco_interior.png"];
    backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 30);
    backgroundImage.size = CGSizeMake(789, 699);
    return backgroundImage;
}

- (SKSpriteNode *) newDoor
{
    SKSpriteNode *door = [SKSpriteNode spriteNodeWithImageNamed:@"reja.png"];
    door.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 90);
    door.size = CGSizeMake(791, 884);
    door.name = @"door";
    return door;
}

- (SKSpriteNode *) newFrontImageColor
{
    SKSpriteNode *frontImageColor = [SKSpriteNode spriteNodeWithImageNamed:@"color_arco_exterior.png"];
    frontImageColor.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    frontImageColor.size = CGSizeMake(1024, 768);
    
    return frontImageColor;
}

- (SKSpriteNode *) newTorchsLightEffect
{
    SKSpriteNode *torchsLightEffect = [SKSpriteNode spriteNodeWithImageNamed:@"efecto_antorchas.png"];
    torchsLightEffect.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    torchsLightEffect.size = CGSizeMake(1024, 768);
    torchsLightEffect.alpha = 0.5;
    torchsLightEffect.name = @"torchsLightEffect";
    return torchsLightEffect;
}

- (SKSpriteNode *) newFrontImageLines
{
    SKSpriteNode *frontImageLines = [SKSpriteNode spriteNodeWithImageNamed:@"lineas_arco.png"];
    frontImageLines.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    frontImageLines.size = CGSizeMake(1024, 768);
    return frontImageLines;
}

- (SKSpriteNode *) newLogo
{
    SKSpriteNode *logo = [SKSpriteNode spriteNodeWithImageNamed:@"logo_ifear.png"];
    logo.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    logo.size = CGSizeMake(651, 495);
    logo.name = @"logo";
    return logo;
}



- (void) riseDoor
{
    SKSpriteNode *door = (SKSpriteNode *) [self childNodeWithName:@"door"];
    SKAction *rise = [SKAction moveToY:door.position.y + 730 duration:2.4];
    SKAction *sound = [SKAction playSoundFileNamed:@"sonido_reja.mp3" waitForCompletion:YES];
    rise.timingMode = SKActionTimingEaseInEaseOut;
    SKAction *riseAndSound = [SKAction group:@[rise,sound]];
    [door runAction:riseAndSound];
    [self fadeOutLogo];
    
}

- (void) fadeOutLogo
{
    SKSpriteNode *logo = (SKSpriteNode *) [self childNodeWithName:@"logo"];
    SKAction *wait = [SKAction waitForDuration:1.0];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:1.5];
    SKAction *fadeGroup = [SKAction sequence:@[wait,fadeOut]];
    [logo runAction:fadeGroup];
    
}

- (void) fadeTorchs
{
    SKSpriteNode *torchsLightEffect = (SKSpriteNode *) [self childNodeWithName:@"torchsLightEffect"];
    SKAction *fadeAlphaDown = [SKAction fadeAlphaBy:-0.07 duration:0.1];
    SKAction *fadeAlphaUp = [SKAction fadeAlphaBy:0.07 duration:0.1];
    SKAction *fadeAlpha = [SKAction sequence:@[fadeAlphaDown, fadeAlphaUp]];
    SKAction *fadeLights = [SKAction repeatActionForever:fadeAlpha];
    [torchsLightEffect runAction:fadeLights];
    
}

@end








