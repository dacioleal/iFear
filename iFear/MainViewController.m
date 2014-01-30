//
//  MainViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 30/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
    
    NSArray *menuButtonsArray;
}

@end

@implementation MainViewController

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
    
    menuButtonsArray = @[self.homeButton, self.buscarButton, self.carteleraButton, self.actividadButton, self.mentesButton];
    [self selectIcon:self.homeButton];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuPushButton:(id)sender
{
    if ([self menuBarIsHidden]) {
        
        [self animateMenuIn];
        
    } else {
        
        [self animateMenuOut];
    }

}

- (IBAction)homePushButton:(id)sender
{
    UIView *homeView = [self.view viewWithTag:1];
    UIView *menuView = [self.view viewWithTag:10];
    
    [self selectIcon:self.homeButton];
    [self animateMenuOut];
    [self.view insertSubview:homeView belowSubview:menuView];
}

- (IBAction)buscarPushButton:(id)sender
{
    UIView *buscarView = [self.view viewWithTag:2];
    UIView *menuView = [self.view viewWithTag:10];
    
    [self selectIcon:self.buscarButton];
    [self animateMenuOut];
    [self.view insertSubview:buscarView belowSubview:menuView];
}

- (IBAction)carteleraPushButton:(id)sender
{
    UIView *carteleraView = [self.view viewWithTag:3];
    UIView *menuView = [self.view viewWithTag:10];
    
    [self selectIcon:self.carteleraButton];
    [self animateMenuOut];
    [self.view insertSubview:carteleraView belowSubview:menuView];
    
}

- (IBAction)actividadPushButton:(id)sender
{
    UIView *actividadView = [self.view viewWithTag:4];
    UIView *menuView = [self.view viewWithTag:10];
    
    [self selectIcon:self.actividadButton];
    [self animateMenuOut];
    [self.view insertSubview:actividadView belowSubview:menuView];
}

- (IBAction)mentesPushButton:(id)sender
{
    UIView *mentesView = [self.view viewWithTag:5];
    UIView *menuView = [self.view viewWithTag:10];
    
    [self selectIcon:self.mentesButton];
    [self animateMenuOut];
    [self.view insertSubview:mentesView belowSubview:menuView];
}

- (BOOL) menuBarIsHidden
{
    UIView *menuView = [self.view viewWithTag:10];
    CGPoint centerPointForMenuOut = CGPointMake(847, 55);
    
    if (menuView.center.x == centerPointForMenuOut.x) {
        return NO;
    } else {
        return YES;
    }
}

- (void) animateMenuIn
{
    UIView *menuView = [self.view viewWithTag:10];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^(void) {
        menuView.center = CGPointMake(menuView.center.x - 290,menuView.center.y);
    }completion:nil];
}

- (void) animateMenuOut
{
    UIView *menuView = [self.view viewWithTag:10];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^(void) {
        menuView.center = CGPointMake(menuView.center.x + 290, menuView.center.y);
    }completion:nil];
    
}

- (void) selectIcon: (UIButton *) button
{
    for (UIButton *buttonEnumerator in menuButtonsArray) {
        buttonEnumerator.layer.opacity = 1.0;
    }
    button.layer.opacity = 0.6;
    
}

@end
























