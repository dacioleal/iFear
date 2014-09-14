//
//  ModalMentesOscurasViewController.m
//  iFear
//
//  Created by José Alberto Martín Falcón on 23/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "ModalMentesOscurasViewController.h"

@interface ModalMentesOscurasViewController ()

@end

@implementation ModalMentesOscurasViewController

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
    
    // Se establece un color negro semi-transparene a la vista principal
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6f];
    
    // Animación
    UIInterpolatingMotionEffect* m1 =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    m1.maximumRelativeValue = @10.0;
    m1.minimumRelativeValue = @-10.0;
    UIInterpolatingMotionEffect* m2 =
    [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                    type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    m2.maximumRelativeValue = @10.0;
    m2.minimumRelativeValue = @-10.0;
    UIMotionEffectGroup* g = [UIMotionEffectGroup new];
    g.motionEffects = @[m1,m2];
    
    [self.popupView addMotionEffect:g];
    
    [self setStyleTopHits];
    [self setStyleUserData];
    [self setStyleUserName];
    [self setStyleWorstMovie];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





- (IBAction)pushReturnButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - Style Font config -

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

- (void) setStyleUserData
{
    UIColor *textColor = [UIColor colorWithRed:237/255.0 green:194/255.0 blue:0/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:21.0];
   
    [self setStyleInArray:self.listLabelUserData andWithColor:textColor andWithFont:font];
}

- (void) setStyleWorstMovie
{
    UIColor *textColor = [UIColor colorWithRed:166/255.0 green:164/255.0 blue:164/255.0 alpha:1];
    UIColor *textColorData = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
    
    [self setFontAndColor:self.labelWorstMovieTerror withText:self.labelWorstMovieTerror.text andWithColor:textColor andWithFont:font];
    [self setFontAndColor:self.titleWorstMovieTerror withText:self.titleWorstMovieTerror.text andWithColor:textColorData andWithFont:font];
}


- (void) setStyleTopHits
{
    UIColor *textColorLabel = [UIColor colorWithRed:237/255.0 green:194/255.0 blue:0/255.0 alpha:1];
    UIColor *textColorData = [UIColor colorWithRed:193/255.0 green:0/255.0 blue:31/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:18.0];
    
    [self setStyleInArray:self.listLabelTitleTopHits andWithColor:textColorLabel andWithFont:font];
    [self setStyleInArray:self.listTitleTopHits andWithColor:textColorData andWithFont:font];
}


- (void) setStyleUserName
{
    UIColor *textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    UIFont *font = [UIFont fontWithName:@"Futura-Book" size:28.0];
    
    [self setFontAndColor:self.labelUserName withText:self.labelUserName.text andWithColor:textColor andWithFont:font];
}

@end
