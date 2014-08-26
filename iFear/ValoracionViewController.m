//
//  ValoracionViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 26/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ValoracionViewController.h"

@interface ValoracionViewController () 

@end

@implementation ValoracionViewController

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
    [self configureScoreLabels];
    
    NSLog(@"Movie: %@", _movie);
    NSLog(@"Puntuaciones: %@", _scores);
    _movieImageView.image = _movie.imagen;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backPushButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) configureScoreLabels
{
    if (_scores.count > 0) {
        
        NSString *terrorString = (NSString *) [_scores valueForKey:@"terror"];
        NSString *goreString = (NSString *) [_scores valueForKey:@"gore"];
        NSString *humorString = (NSString *) [_scores valueForKey:@"humor"];
        NSString *calidadString = (NSString *) [_scores valueForKey:@"calidad"];
        terrorString = [terrorString stringByAppendingString:@"\%"];
        goreString = [goreString stringByAppendingString:@"\%"];
        humorString = [humorString stringByAppendingString:@"\%"];
        calidadString = [calidadString stringByAppendingString:@"\%"];
        
        UIColor *textColor = [[UIColor alloc] initWithRed:234.0/255.0 green:185.0/255.0 blue:12.0/255.0 alpha:1.0];
        UIFont *font = [UIFont fontWithName:@"Impact" size:22.0];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:terrorString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        _terrorLabel.textAlignment = NSTextAlignmentCenter;
        _terrorLabel.attributedText = attrString;
        
        
        attrString = [[NSAttributedString alloc] initWithString:goreString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        _goreLabel.textAlignment = NSTextAlignmentCenter;
        _goreLabel.attributedText = attrString;
        
        
        attrString = [[NSAttributedString alloc] initWithString:humorString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        _humorLabel.textAlignment = NSTextAlignmentCenter;
        _humorLabel.attributedText = attrString;
        
        attrString = [[NSAttributedString alloc] initWithString:calidadString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        _calidadLabel.textAlignment = NSTextAlignmentCenter;
        _calidadLabel.attributedText = attrString;
        
        textColor = [[UIColor alloc] initWithRed:0.67 green:0.64 blue:0.64 alpha:1.0];
        font = [UIFont fontWithName:@"Futura-Medium" size:17.0];
        NSMutableAttributedString *mutAttrString = [[NSMutableAttributedString alloc] initWithString:@"Puntuación media\n de " attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        textColor = [[UIColor alloc] initWithRed:204.0/255.0 green:46.0/255.0 blue:46.0/255.0 alpha:1.0];
        NSString *numeroPuntuacionesString = (NSString *) [_scores valueForKey:@"numero_puntuaciones"];
        NSAttributedString *attrTwoString = [[NSAttributedString alloc] initWithString:numeroPuntuacionesString attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        [mutAttrString appendAttributedString:attrTwoString];
        
        textColor = [[UIColor alloc] initWithRed:0.67 green:0.64 blue:0.64 alpha:1.0];
        NSAttributedString *attrThreeString = [[NSAttributedString alloc] initWithString:@" usuarios" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
        
        [mutAttrString appendAttributedString:attrThreeString];
        _puntuacionMediaLabel.shadowColor = [UIColor blackColor];
        _puntuacionMediaLabel.shadowOffset = CGSizeMake(1, 1);
        _puntuacionMediaLabel.textAlignment = NSTextAlignmentCenter;
        _puntuacionMediaLabel.attributedText = mutAttrString;
    }
    
}
@end
