//
//  ScoreBar.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 25/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ScoreBar.h"

@interface ScoreBar ()
{
    CGImageRef tiledImageRef;
}

@end

@implementation ScoreBar


- (id)initWithFrame:(CGRect)frame andTiledImage:(CGImageRef) imageRef
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    tiledImageRef = imageRef;
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //CGImageRef image = [UIImage imageNamed:@"tramo_azul_47x6.jpg"].CGImage;
    CGContextDrawTiledImage(ref, self.bounds, tiledImageRef);
}


@end
