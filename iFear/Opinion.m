//
//  Opinion.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 14/09/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "Opinion.h"

@implementation Opinion

@synthesize terrorScore,goreScore,humorScore,calidadScore, movieTitle, review, flashReview;


- (id) initWithMovieTitle: (NSString *) title andFlashReview: (NSString *) flashR andReview: (NSString *) rvw andTerrorScore: (NSString *) teScore andGoreScore: (NSString *) gorScore andHumorScore: (NSString *) humScore andCalidadScore: (NSString *) calScore
{
    self = [super init];
    
    if (self) {
        [self setMovieTitle:title];
        [self setFlashReview:flashR];
        [self setReview:rvw];
        [self setTerrorScore:teScore];
        [self setHumorScore:humScore];
        [self setCalidadScore:calScore];
        [self setGoreScore:gorScore];
    }
    
    return self;
}

@end
