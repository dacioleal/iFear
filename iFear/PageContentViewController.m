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
    NSArray *soporteImageViewsArray;
}
@property (nonatomic, strong) NSMutableAttributedString *attributedString;

- (IBAction)topImageTap:(UITapGestureRecognizer *)sender;
- (IBAction)midImageTap:(UITapGestureRecognizer *)sender;
- (IBAction)bottomImageTap:(UITapGestureRecognizer *)sender;

- (IBAction)topTitleTap:(UITapGestureRecognizer *)sender;
- (IBAction)midTitleTap:(UITapGestureRecognizer *)sender;
- (IBAction)bottomTitleTap:(UITapGestureRecognizer *)sender;

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
    [self goToMovieDetail:movie];
}

- (IBAction)midImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:1];
    [self goToMovieDetail:movie];
    
}

- (IBAction)bottomImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:2];
    [self goToMovieDetail:movie];
}

- (IBAction)topTitleTap:(UITapGestureRecognizer *)sender {
    
    [self topImageTap:sender];
}

- (IBAction)midTitleTap:(UITapGestureRecognizer *)sender {
    
    [self midImageTap:sender];
}

- (IBAction)bottomTitleTap:(UITapGestureRecognizer *)sender {
    
    [self bottomImageTap:sender];
}

- (void) goToMovieDetail: (Pelicula *) movie {
    
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
    soporteImageViewsArray = @[_topMovieSoporteImageView, _midMovieSoporteImageView, _bottomMovieSoporteImageView];
    
    
    
    if (_moviesArray)
    {
        for (int i = 0; i < _moviesArray.count ; i++) {
            
            Pelicula *movie = (Pelicula *) [_moviesArray objectAtIndex:i];
            UILabel *titleLabel = (UILabel *) [titleLabelsArray objectAtIndex:i];
            UITextView *textView = (UITextView *) [textViewsArray objectAtIndex:i];
            UIImageView *imageView = (UIImageView *) [imageViewsArray objectAtIndex:i];
            
            textView.layer.opacity = 0.9;
            UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:28.0];
            UIColor *textColor = [UIColor colorWithRed:0.57 green:0.18 blue:0.19 alpha:1.0];
            NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:movie.titulo attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
            
            titleLabel.attributedText = titleAttributedString;
            
            font = [UIFont fontWithName:@"Futura-Book" size:16.0];
            textColor = [UIColor whiteColor];
            NSAttributedString *textAttributedString = [[NSAttributedString alloc] initWithString:movie.sinopsis attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
            
            textView.attributedText = textAttributedString;
            imageView.image = movie.imagen;
            
        }
        
        switch (_moviesArray.count) {
            case 1:
                _midImageView.hidden = _midMovieTitleLabel.hidden = _midMovieTitleLabel.hidden = _midMovieBackgroundImageView.hidden = _midMovieSoporteImageView.hidden = _midMovieTextView.hidden = YES;
                _bottomImageView.hidden = _bottomMovieTitleLabel.hidden = _bottomMovieTitleLabel.hidden = _bottomMovieBackgroundImageView.hidden = _bottomMovieSoporteImageView.hidden = _bottomMovieTextView.hidden = YES;
                break;
            case 2:
                _bottomImageView.hidden = _bottomMovieTitleLabel.hidden = _bottomMovieTitleLabel.hidden = _bottomMovieBackgroundImageView.hidden = _bottomMovieSoporteImageView.hidden = _bottomMovieTextView.hidden = YES;
                break;
            default:
                break;
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
















