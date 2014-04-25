//
//  DetalleViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 12/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "DetalleViewController.h"
#import "Pelicula.h"
#import <AVFoundation/AVFoundation.h>

@interface DetalleViewController ()
{
    NSArray *leftPanelButtons;
}




- (IBAction)imageTap:(UITapGestureRecognizer *)sender;

@end

@implementation DetalleViewController


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
	// Do any additional setup after loading the view.
    
    leftPanelButtons = @[_descriptionButton, _trailersButton, _reviewsButton, _darkSideButton];
    
    _movieImageView.image = _movie.imagen;
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.94 green:0.78 blue:0.19 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:46.0];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:_movie.titulo attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _titleLabel.attributedText = title;
    _titleLabel.shadowColor = [UIColor blackColor];
    _titleLabel.shadowOffset = CGSizeMake(0, 2);
    
    [_descriptionButton setSelected:YES];
    
    textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Ficha Técnica" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;
    
    
    
    
    
    CGSize size = CGSizeMake(540, 912);
    _trailersScrollView.contentSize = size;
    
    CGRect rect = CGRectMake(0, 0, 540, 304);
    UIWebView *youtubeWebView = [[UIWebView alloc] initWithFrame:rect];
    youtubeWebView.backgroundColor = [UIColor clearColor];
    youtubeWebView.scrollView.scrollEnabled = NO;;
    youtubeWebView.allowsInlineMediaPlayback = YES;
    [youtubeWebView loadHTMLString:@"<html><head><title>.</title><style>body,html,iframe{margin:0;padding:0;}</style></head><body><iframe width=\"1280\" height=\"720\" src=\"//www.youtube.com/embed/O0F2wOlJIRM\" frameborder=\"0\" allowfullscreen></iframe></body></html>" baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
    youtubeWebView.scalesPageToFit = YES;
    [_trailersScrollView addSubview:youtubeWebView];
    
    rect = CGRectMake(0, 304, 540, 304);
    UIWebView *youtubeWebView2 = [[UIWebView alloc] initWithFrame:rect];
    youtubeWebView2.backgroundColor = [UIColor clearColor];
    youtubeWebView2.scrollView.scrollEnabled = NO;;
    youtubeWebView2.allowsInlineMediaPlayback = YES;
    youtubeWebView2.scalesPageToFit = YES;
    [youtubeWebView2 loadHTMLString:@"<html><head><title>.</title><style>body,html,iframe{margin:0;padding:0;}</style></head><body><iframe width=\"1280\" height=\"720\" src=\"//www.youtube.com/embed/_ZiuxGNpCSA\" frameborder=\"0\" allowfullscreen></iframe></body></html>" baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
    [_trailersScrollView addSubview:youtubeWebView2];
    
    rect = CGRectMake(0, 608, 540, 304);
    UIWebView *youtubeWebView3 = [[UIWebView alloc] initWithFrame:rect];
    youtubeWebView3.backgroundColor = [UIColor clearColor];
    youtubeWebView3.scrollView.scrollEnabled = NO;
    youtubeWebView3.allowsInlineMediaPlayback = YES;
    youtubeWebView3.scalesPageToFit = YES;
    NSString *HTMLString = [self createHTMLStringForVideoID:@"vldt9rhcr58"];
   
    [youtubeWebView3 loadHTMLString:HTMLString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
    [_trailersScrollView addSubview:youtubeWebView3];
    
    [self configureDescriptionTextView];
    [self configureLeftPanelButtons];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backPushButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)descriptionPushButton:(UIButton *)sender {
    
    [_contentView bringSubviewToFront:_descriptionTextView];
    [self deselectLeftPanelButtons];
    [_descriptionButton setSelected:YES];
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Ficha Técnica" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;
}

- (IBAction)trailersPushButton:(UIButton *)sender {
    
    [_contentView bringSubviewToFront:_trailersScrollView];
    [self deselectLeftPanelButtons];
    [_trailersButton setSelected:YES];
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Trailers" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;
    
}

- (IBAction)reviewsPushButton:(UIButton *)sender {
    
    //[_contentView bringSubviewToFront:_trailersScrollView];
    [self deselectLeftPanelButtons];
    [_reviewsButton setSelected:YES];
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.25 green:0.06 blue:0.04 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:32.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Críticas" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    _contentTitleLabel.attributedText = attributedString;

}

- (IBAction)darkSidePushButton:(UIButton *)sender {
    
    //[_contentView bringSubviewToFront:_trailersScrollView];
    [self deselectLeftPanelButtons];
    [_darkSideButton setSelected:YES];
}

- (IBAction)rateMoviePushButton:(UIButton *)sender {
}


- (IBAction)imageTap:(UITapGestureRecognizer *)sender {
    
        CGRect initialBounds = CGRectMake(0, 0, 180, 258);
        CGRect finalBounds = CGRectMake(0, 0, 396,  516);
    
        CGPoint initialCenter = CGPointMake(121, 187);
        CGPoint finalCenter = CGPointMake(512, 384);
    
    if ((_movieImageView.center.x == initialCenter.x) && (_movieImageView.center.y == initialCenter.y)) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _movieImageView.center = finalCenter;
            _movieImageView.bounds = finalBounds;
            
        }];
    } else if ((_movieImageView.center.x == finalCenter.x) && (_movieImageView.center.y == finalCenter.y)) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _movieImageView.center = initialCenter;
            _movieImageView.bounds = initialBounds;
        }];
        
    }
    
}

#pragma mark - Personalized Methods

- (NSString *) createHTMLStringForVideoID: (NSString *) videoIDString
{
    NSString *string = [NSString stringWithFormat:@"<html><head><title>.</title><style>body,html,iframe{margin:0;padding:0;}</style></head><body><iframe width=\"1280\" height=\"720\" src=\"//www.youtube.com/embed/%@\" frameborder=\"0\" allowfullscreen></iframe></body></html>", videoIDString];
    
    return string;
}

- (void) configureTrailersView
{
    
}

- (void) configureDescriptionTextView
{
    NSArray *titlesArray = [_movie titlesArrayToMakeDescriptionSheet];
    NSArray *stringsArray = [_movie stringsArrayToMakeDescriptionSheet];
    
    NSString *titleString = [[NSString alloc] init];
    NSString *descriptionString = [[NSString alloc] init];
    NSMutableAttributedString *completedAttributedString = [[NSMutableAttributedString alloc] init];
    
    for (int i = 1 ; i < titlesArray.count; i++) {
        
        titleString = [titlesArray objectAtIndex:i];
        
        titleString = [titleString uppercaseString];
        
        UIColor *textColor = [[UIColor alloc] initWithRed:0.76 green:0 blue:0.122 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:20.0];
        NSAttributedString *titleAttributedString = [[NSAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        descriptionString = [stringsArray objectAtIndex:i];
        
        textColor = [[UIColor alloc] initWithRed:0.84 green:0.84 blue:0.84 alpha:1.0];
        font = [UIFont fontWithName:@"GillSans" size:18.0];
         NSAttributedString *descriptionAttributedString = [[NSAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
        [attributedString appendAttributedString:titleAttributedString];
        [attributedString appendAttributedString:descriptionAttributedString];
        [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        [completedAttributedString appendAttributedString:attributedString];
        
    }
    
    _descriptionTextView.attributedText = completedAttributedString;
}

- (void) configureLeftPanelButtons
{
    
    UIColor *textColor = [[UIColor alloc] initWithRed:0.94 green:0.68 blue:0.19 alpha:1.0];
    UIFont *font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:24.0];
    NSAttributedString *normalAttributedString = [[NSAttributedString alloc] initWithString:@"FICHA" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_descriptionButton setAttributedTitle:normalAttributedString forState:UIControlStateNormal];

    textColor = [[UIColor alloc] initWithRed:0.6 green:0.15 blue:0.1 alpha:1.0];
    NSAttributedString *selectedAttributedString = [[NSAttributedString alloc] initWithString:@"FICHA" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    [_descriptionButton setAttributedTitle:selectedAttributedString forState:UIControlStateSelected | UIControlStateHighlighted];
    
}

- (void) deselectLeftPanelButtons
{
    for (int i=0; i<leftPanelButtons.count; i++) {
        UIButton *button = (UIButton *) [leftPanelButtons objectAtIndex:i];
        [button setSelected:NO];
    }
}


@end

























