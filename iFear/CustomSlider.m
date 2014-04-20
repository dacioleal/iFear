//
//  CustomSlider.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 20/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    // Set the fill color
//    [[UIColor colorWithWhite:0 alpha:0.8] setFill];
//    // Create the path for the rounded rectanble
//    CGRect roundedRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height * 0.8);
//    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:6.0];
//    // Create the arrow path
//    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
//    CGFloat midX = CGRectGetMidX(self.bounds);
//    CGPoint p0 = CGPointMake(midX, CGRectGetMaxY(self.bounds));
//    [arrowPath moveToPoint:p0];
//    [arrowPath addLineToPoint:CGPointMake((midX - 10.0), CGRectGetMaxY(roundedRect))];
//    [arrowPath addLineToPoint:CGPointMake((midX + 10.0), CGRectGetMaxY(roundedRect))];
//    [arrowPath closePath];
//    // Attach the arrow path to the rounded rectangle
//    [roundedRectPath appendPath:arrowPath];
//    [roundedRectPath fill];
    
    [self setThumbImage:[UIImage imageNamed:@"indicador_107x58.png"] forState:UIControlStateNormal];
    
    
}

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    NSLog(@"ENTRA rect");
    return CGRectMake(0, 0, 500, 20);
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    NSLog(@"%F",value);
    rect = CGRectMake(0, 40, 500, 20);
    return [super thumbRectForBounds:bounds trackRect:rect value:value];
}

@end
