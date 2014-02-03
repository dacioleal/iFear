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
    [self addChild:[self newFrontImage]];
    [self addChild:[self newSmokeEmitter1]];
    [self addChild:[self newSmokeEmitter2]];
    [self addChild:[self newFireEmitter1]];
    [self addChild:[self newFireEmitter2]];
    
    
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
    backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    backgroundImage.size = CGSizeMake(1024, 768);
    return backgroundImage;
}

- (SKSpriteNode *) newDoor
{
    SKSpriteNode *door = [SKSpriteNode spriteNodeWithImageNamed:@"reja.png"];
    door.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 60);
    door.size = CGSizeMake(791, 884);
    door.name = @"door";
    return door;
}

- (SKSpriteNode *) newFrontImage
{
    SKSpriteNode *frontImage = [SKSpriteNode spriteNodeWithImageNamed:@"arco_exterior_logo.png"];
    frontImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    frontImage.size = CGSizeMake(1024, 768);
    return frontImage;
}

- (void) riseDoor
{
    SKSpriteNode *door = (SKSpriteNode *) [self childNodeWithName:@"door"];
    SKAction *rise = [SKAction moveToY:door.position.y + 700 duration:2.4];
    SKAction *sound = [SKAction playSoundFileNamed:@"sonido_reja.mp3" waitForCompletion:YES];
    rise.timingMode = SKActionTimingEaseInEaseOut;
    SKAction *riseAndSound = [SKAction group:@[rise,sound]];
    [door runAction:riseAndSound];
    
}

@end








