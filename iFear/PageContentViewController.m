//
//  PageContentViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "PageContentViewController.h"
#import "Pelicula.h"


@interface PageContentViewController () {
    
    NSArray *titleLabelsArray;
    NSArray *textViewsArray;
    NSArray *imageViewsArray;
}
@property (nonatomic, strong) NSMutableAttributedString *attributedString;

- (IBAction)topImageTap:(UITapGestureRecognizer *)sender;
- (IBAction)midImageTap:(UITapGestureRecognizer *)sender;
- (IBAction)bottomImageTap:(UITapGestureRecognizer *)sender;


@end



@implementation PageContentViewController

- (NSMutableAttributedString *) attributedString
{
    if (!_attributedString) {
        _attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    return _attributedString;
}

- (IBAction)topImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:0];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:movie, @"movie", nil];
    [defaultCenter postNotificationName:@"goToMovieDetail" object:self userInfo:userInfo];
   
}

- (IBAction)midImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:1];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:movie, @"movie", nil];
    [defaultCenter postNotificationName:@"goToMovieDetail" object:self userInfo:userInfo];
    
}

- (IBAction)bottomImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:2];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:movie, @"movie", nil];
    [defaultCenter postNotificationName:@"goToMovieDetail" object:self userInfo:userInfo];
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImages) name:@"imagesSetFinished" object:nil];
    
   
    titleLabelsArray = @[_topMovieTitleLabel, _midMovieTitleLabel, _bottomMovieTitleLabel];
    textViewsArray = @[_topMovieTextView, _midMovieTextView, _bottomMovieTextView];
    imageViewsArray = @[_topImageView, _midImageView, _bottomImageView];
    
    
    
    if (_moviesArray)
    {
        for (int i = 0; i < _moviesArray.count ; i++) {
            
            Pelicula *movie = (Pelicula *) [_moviesArray objectAtIndex:i];
            UILabel *titleLabel = (UILabel *) [titleLabelsArray objectAtIndex:i];
            UITextView *textView = (UITextView *) [textViewsArray objectAtIndex:i];
            UIImageView *imageView = (UIImageView *) [imageViewsArray objectAtIndex:i];
            
            textView.layer.opacity = 0.9;
            UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:28.0];
            UIColor *textColor = [UIColor colorWithRed:0.65 green:0.24 blue:0.21 alpha:1.0];
            NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:movie.titulo attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
            
            titleLabel.attributedText = titleAttributedString;
            
            font = [UIFont fontWithName:@"TeluguSangamMN" size:15.0];
            textColor = [UIColor whiteColor];
            NSAttributedString *textAttributedString = [[NSAttributedString alloc] initWithString:movie.sinopsis attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
            
            textView.attributedText = textAttributedString;
            imageView.image = movie.imagen;
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addImages
{
    for (Pelicula *movie in _moviesArray) {
        NSInteger index = [self.moviesArray indexOfObject:movie];
        UIImageView *imageView = (UIImageView *) [imageViewsArray objectAtIndex:index];
        imageView.image = movie.imagen;
    }
}


@end
















