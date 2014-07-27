//
//  CustomIfearSlider.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 01/05/14.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import "CustomIfearSlider.h"

CGFloat const kDefaultTrackHeight = 20.0;
CGFloat const kDefaultHandlerSize = 44.0;

@interface CustomIfearSlider ()

@property (strong, nonatomic) UIImageView *leftHandler;
@property (strong, nonatomic) UIView *currentMovingHandler;

@end

@implementation CustomIfearSlider

#pragma mark - Public

- (id)initWithFrame:(CGRect)frame numberOfValues:(NSUInteger)values {
    self = [self initWithFrame:frame];
    
    if (self) {
        self.values = values;
        self.currentLeftSegment = 20;
    }
    
    return self;
}

- (void)setLeftHandlerImage:(UIImage *)leftHandlerImage {
    _leftHandlerImage = leftHandlerImage;
    self.leftHandler.image = leftHandlerImage;
}


#pragma mark - UIControl

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    CGPoint lastPoint = [touch locationInView:self];
    self.currentMovingHandler = [self handlerContainingPoint:lastPoint];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.currentMovingHandler) {
        [self moveHandler:self.currentMovingHandler usingTouch:touch];
    }
    [self updateCurrentSegmentsAndSendActionsIfNeeded];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.opaque = NO;
        [self setDefaultValues];
        [self initHandlers];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawBackgroundColor];
    //[self drawLineYAxisCentered];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.leftHandler.frame, point)) {
        return self;
    }
    
    return [super hitTest:point withEvent:event];
}

#pragma mark - Private

- (UIView *)handlerContainingPoint:(CGPoint)point {
    if (CGRectContainsPoint(self.leftHandler.frame, point)) {
        return self.leftHandler;
    }
    
    return nil;
}

// Actualiza la porción del segmento donde estamos
- (void)updateCurrentSegmentsAndSendActionsIfNeeded {
    
    NSUInteger leftSegment = [self segmentForXPosition:CGRectGetMidX(self.leftHandler.frame)];
    
    if (leftSegment != self.currentLeftSegment) {
        self.currentLeftSegment = leftSegment;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (NSUInteger)segmentForXPosition:(CGFloat)x {
    if (x != CGRectGetMaxX(self.bounds)) {
        return floor(x * self.values / CGRectGetWidth(self.bounds));
    }
    else {
        return self.values - 1;
    }
}

- (void)moveHandler:(UIView *)handler usingTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGFloat xOffset = location.x - previousLocation.x;
    CGFloat newHandlerCenterX = CGRectGetMidX(handler.frame) + xOffset;
    
    if ([self isValue:newHandlerCenterX betweenAllowedHorizontalBoundsForHandler:handler]) {
        handler.frame = CGRectOffset(handler.frame, xOffset, 0.0);
    }
}

- (BOOL)isValue:(CGFloat)value betweenAllowedHorizontalBoundsForHandler:(UIView *)handler {
    if (handler == self.leftHandler) {
        return [self isValueBetweenAllowedHorizontalBoundsForLeftHandler:value];
    }
    
    return NO;
}

- (BOOL)isValueBetweenAllowedHorizontalBoundsForLeftHandler:(CGFloat)value {
    CGFloat minAllowedX = CGRectGetMinX(self.bounds);
    CGFloat maxAllowedX = CGRectGetMaxX(self.bounds);
    return (minAllowedX < value) && (value < maxAllowedX);
}

- (BOOL)isValueBetweenAllowedHorizontalBoundsForRightHandler:(CGFloat)value {
    CGFloat minAllowedX = CGRectGetMinX(self.bounds);
    CGFloat maxAllowedX = CGRectGetMaxX(self.bounds);
    return (minAllowedX < value) && (value < maxAllowedX);
}

- (void)setDefaultValues {
    self.trackHeight = kDefaultTrackHeight;
    self.trackColor = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)initHandlers {
    [self initLeftHandler];
    
}

- (void)initLeftHandler {
    CGRect leftHandlerFrame = CGRectMake(0.0, 0.0, kDefaultHandlerSize, kDefaultHandlerSize);
    self.leftHandler = [[UIImageView alloc] initWithFrame:leftHandlerFrame];
    self.leftHandler.contentMode = UIViewContentModeCenter;
    self.leftHandler.image = self.leftHandlerImage;
    self.leftHandler.center = CGPointMake(0.0, CGRectGetMidY(self.bounds));
    [self addSubview:self.leftHandler];
}


- (void)drawBackgroundColor {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
}

- (void)drawLineYAxisCentered {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.trackColor.CGColor);
    CGContextSetLineWidth(context, self.trackHeight);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
    CGContextStrokePath(context);
}

@end
