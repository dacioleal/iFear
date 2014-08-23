//
//  MentesViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 22/08/2014.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import "MentesViewController.h"

@interface MentesViewController ()

@end

@implementation MentesViewController

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
    [self setStyleUserName];
    [self setStylePercent];
    [self setStyleAfin];
    [self setStyleLabelDataUser];
    [self setStyleIntroText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setFontAndColor:(id)sender withText: (NSString *) text andWithColor: (UIColor *) textColor andWithFont: (UIFont *) font
{
    NSAttributedString *atrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    UILabel *auxLabel =  (UILabel *) sender;
    auxLabel.attributedText = atrStr;
    auxLabel.shadowColor = [UIColor blackColor];
    auxLabel.shadowOffset = CGSizeMake(0, 2);
    [auxLabel sizeToFit];
}

- (void) setStyleInArray:(NSArray *) list andWithColor: (UIColor *) textColor andWithFont: (UIFont *) font
{
    for (UILabel * label in list) {
        [self setFontAndColor:label withText:label.text andWithColor:textColor andWithFont:font];
    }
}

- (void) setStyleUserName
{
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:20.0];
    
    [self setStyleInArray:self.listUserName andWithColor:textColor andWithFont:font];
}

- (void) setStylePercent
{
    UIColor *textColor = [UIColor colorWithRed:134.0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Impact" size:67.0];
    
    [self setStyleInArray:self.listPercent andWithColor:textColor andWithFont:font];
}

- (void) setStyleAfin
{
    UIColor *textColor = [UIColor colorWithRed:134.0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Impact" size:35.0];
    
    [self setStyleInArray:self.listAfin andWithColor:textColor andWithFont:font];
}

- (void) setStyleLabelDataUser
{
    UIColor *textColor = [UIColor colorWithRed:237.0/255.0 green:194.0/255.0 blue:0/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:16.0];
    
    [self setStyleInArray:self.listUserData andWithColor:textColor andWithFont:font];
}


- (void) setStyleIntroText
{
    UIColor *textColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Light" size:18.0];
    
    [self setStyleInArray:self.listIntroText andWithColor:textColor andWithFont:font];
}





@end
