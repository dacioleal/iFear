//
//  ProgresSlider.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 01/05/14.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import "ProgresSlider.h"

@implementation ProgresSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (CGRect)trackRectForBounds:(CGRect)bounds
{
    // Se le da la altura de la barra
    return CGRectMake(0, 0, bounds.size.width, 35);
}

@end
