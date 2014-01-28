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
    
    [self addChild:[self newBackImage]];
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
    fire.position = CGPointMake(39, 442);
    
    return fire;
}

- (SKEmitterNode *) newFireEmitter2
{
    NSString *firePath = [[NSBundle mainBundle] pathForResource:@"FireParticle"
                                                         ofType:@"sks"];
    SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    fire.position = CGPointMake(990, 442);
    
    return fire;
}

- (SKEmitterNode *) newSmokeEmitter1
{
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"SmokeParticle"
                                                          ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smoke.position = CGPointMake(39, 442);
    return smoke;
}

- (SKEmitterNode *) newSmokeEmitter2
{
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"SmokeParticle"
                                                          ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    smoke.position = CGPointMake(990, 442);
    return smoke;
}

- (SKSpriteNode *) newBackImage
{
    
    SKSpriteNode *backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"entrada_muestra_01.jpg"];
    backgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return backgroundImage;
}



@end
