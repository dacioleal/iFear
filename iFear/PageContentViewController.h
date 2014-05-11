//
//  PageContentViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *midImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic) IBOutlet UILabel *topMovieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *midMovieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomMovieTitleLabel;

@property (weak, nonatomic) IBOutlet UITextView *topMovieTextView;
@property (weak, nonatomic) IBOutlet UITextView *midMovieTextView;
@property (weak, nonatomic) IBOutlet UITextView *bottomMovieTextView;

@property (weak, nonatomic) IBOutlet UIImageView *topMovieSoporteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *midMovieSoporteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomMovieSoporteImageView;

@property (weak, nonatomic) IBOutlet UIImageView *topMovieBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *midMovieBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomMovieBackgroundImageView;



@property (strong, nonatomic) NSArray * moviesArray; // Array que contiene las tres peliculas a mostrar
@property (nonatomic) NSUInteger index;
@property (nonatomic) NSUInteger numberOfPages;


@end
