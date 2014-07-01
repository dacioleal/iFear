//
//  CustomIfearSlider.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 01/05/14.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomIfearSlider : UIControl

// Cantidad de valores que tendrá el Slider
@property (assign, nonatomic) NSUInteger values;
// TODO
@property (assign, nonatomic) NSUInteger currentLeftSegment;
// Altura para el track
@property (assign, nonatomic) CGFloat trackHeight;
// Color del track
@property (strong, nonatomic) UIColor *trackColor;
// color de fondo de todo el frame del Slider
@property (strong, nonatomic) UIColor *backgroundColor;
// Manejador del Slider
@property (strong, nonatomic) UIImage *leftHandlerImage;
// TODO
@property (strong, nonatomic) UIImage *trackImage;

@property (strong, nonatomic) UIImageView *leftHandler;
@property (strong, nonatomic) UIView *currentMovingHandler;

- (id)initWithFrame:(CGRect)frame numberOfValues:(NSUInteger)values;
- (void) resetHandler;
- (void)initLeftHandler;

@end
