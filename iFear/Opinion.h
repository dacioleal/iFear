//
//  Opinion.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 14/09/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Opinion : NSObject

@property (strong, nonatomic) NSString * movieTitle;
@property (strong, nonatomic) NSString * flashReview;
@property (strong, nonatomic) NSString * review;
@property (strong, nonatomic) NSString * terrorScore;
@property (strong, nonatomic) NSString * goreScore;
@property (strong, nonatomic) NSString * humorScore;
@property (strong, nonatomic) NSString * calidadScore;

- (id) initWithMovieTitle: (NSString *) title andFlashReview: (NSString *) flashR andReview: (NSString *) rvw andTerrorScore: (NSString *) teScore andGoreScore: (NSString *) gorScore andHumorScore: (NSString *) humScore andCalidadScore: (NSString *) calScore;

@end
