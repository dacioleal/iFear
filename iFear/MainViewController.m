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
    UIViewController * onScreenViewController;
    
    UIViewController *menuViewController;
    UIViewController *busquedaViewController;
    UIViewController *carteleraViewController;
    UIViewController *actividadViewController;
    UIViewController *mentesViewController;
    
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
   
    
    [self hideMenuBar];
    [self displayContentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"entradaViewController"]];
    menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];
    busquedaViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"busquedaViewController"];
    carteleraViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"carteleraViewController"];
    actividadViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"actividadViewController"];
    mentesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"mentesViewController"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Menu Buttons action methods

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
    if (![self menuBarIsHidden]) [self animateMenuOut];
    
    [self cycleFromViewController:onScreenViewController toViewController:menuViewController];
    [self selectIcon:self.homeButton];
}

- (IBAction)buscarPushButton:(id)sender
{
    if (![self menuBarIsHidden]) [self animateMenuOut];
    
    [self cycleFromViewController:onScreenViewController toViewController:busquedaViewController];
    [self selectIcon:self.buscarButton];
    
}

- (IBAction)carteleraPushButton:(id)sender
{
    
    if (![self menuBarIsHidden]) [self animateMenuOut];
    
    [self cycleFromViewController:onScreenViewController toViewController:carteleraViewController];
    [self selectIcon:self.carteleraButton];
    
}

- (IBAction)actividadPushButton:(id)sender
{
    
    if (![self menuBarIsHidden]) [self animateMenuOut];
    
    [self cycleFromViewController:onScreenViewController toViewController:actividadViewController];
    [self selectIcon:self.actividadButton];
    
}

- (IBAction)mentesPushButton:(id)sender
{
    
    if (![self menuBarIsHidden]) [self animateMenuOut];
    
    [self cycleFromViewController:onScreenViewController toViewController:mentesViewController];
    [self selectIcon:self.mentesButton];
    
}


#pragma mark - ViewController animated menu methods

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
    [self.menuButton setSelected:YES];
    
    UIView *menuView = [self.view viewWithTag:10];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^(void) {
        menuView.center = CGPointMake(menuView.center.x - 290,menuView.center.y);
    }completion:nil];
}

- (void) animateMenuOut
{
    [self.menuButton setSelected:NO];
    
    UIView *menuView = [self.view viewWithTag:10];    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^(void) {
        menuView.center = CGPointMake(menuView.center.x + 290, menuView.center.y);
    }completion:nil];
    
}

- (void) selectIcon: (UIButton *) button
{
    for (UIButton *buttonEnumerator in menuButtonsArray) {
        
        buttonEnumerator.enabled = YES;
    }
    button.enabled = NO;
}

- (void) hideMenuBar
{
    UIView *menuBarView = [self.view viewWithTag:10];
    menuBarView.alpha = 1.0;
    menuBarView.hidden = YES;
    [UIView animateWithDuration:1.0 animations:^{
        menuBarView.alpha = 0.0;
    }];
    
}

- (void) showMenuBar
{
    UIView *menuBarView = [self.view viewWithTag:10];
    menuBarView.alpha = 0;
    menuBarView.hidden = NO;
    [UIView animateWithDuration:1.0 animations:^{
        menuBarView.alpha = 1.0;
    }];
}

#pragma  mark - ViewController display methods

- (void) displayContentViewController: (UIViewController *) contentViewController
{
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = _contentView.frame;
    [_contentView addSubview:contentViewController.view];
    [contentViewController didMoveToParentViewController:self];
    
    onScreenViewController = contentViewController;
}

- (void) hideContentViewController: (UIViewController *) contentViewController
{
    [contentViewController willMoveToParentViewController:nil];
    [contentViewController.view removeFromSuperview];
    [contentViewController removeFromParentViewController];
}

- (void) cycleFromViewController: (UIViewController*) oldViewController toViewController: (UIViewController*) newViewController
{
    if (![self menuBarIsHidden]) [self animateMenuOut];
    
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    
    newViewController.view.frame = _contentView.frame;
    
    [self transitionFromViewController: oldViewController toViewController: newViewController duration: 0.25 options:0
                            animations:^{
                            
                            }
                            completion:^(BOOL finished) {
                                [oldViewController removeFromParentViewController];
                                [newViewController didMoveToParentViewController:self];
                            }];
    onScreenViewController = newViewController;
    
}

- (void) specialTransitionFromViewController: (UIViewController*) oldViewController toViewController: (UIViewController*) newViewController
{
    
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    
    newViewController.view.frame = _contentView.frame;
    newViewController.view.alpha = 0;
    
    [self transitionFromViewController: oldViewController toViewController: newViewController duration: 1.0 options:0
                            animations:^{
                                
                                newViewController.view.alpha = 1.0;
                                oldViewController.view.alpha = 0.5;
                                
                                CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

                                scaleAnimation.fromValue = [NSNumber numberWithFloat:0];
                                scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
                                scaleAnimation.duration = 0.7;
                                
                                [newViewController.view.layer addAnimation:scaleAnimation forKey:@"scale"];
                                
                                
                                
                            }
                            completion:^(BOOL finished) {
                                [oldViewController removeFromParentViewController];
                                [newViewController didMoveToParentViewController:self];
                            }];
    onScreenViewController = newViewController;
    
}




#pragma mark - Menu Buttons setter method

- (NSArray *) menuButtonsArray
{
    if (!menuButtonsArray) {
        menuButtonsArray = [[NSArray alloc] init];
    }
    return nil;
}

@end
























