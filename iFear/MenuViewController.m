//
//  MenuViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 10/01/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "MenuViewController.h"
#import "MainViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)carteleraPushButton:(UIButton *)sender {
    
    MainViewController *mainViewController = (MainViewController *)self.parentViewController;
    [mainViewController performSelector:@selector(carteleraPushButton:) withObject:mainViewController];

}

- (IBAction)buscarPushButton:(UIButton *)sender {
    
    MainViewController *mainViewController = (MainViewController *)self.parentViewController;
    [mainViewController performSelector:@selector(buscarPushButton:) withObject:mainViewController];
}

- (IBAction)mentesPushButton:(UIButton *)sender {
    
    MainViewController *mainViewController = (MainViewController *)self.parentViewController;
    [mainViewController performSelector:@selector(mentesPushButton:) withObject:mainViewController];
}

- (IBAction)queEsPushButton:(UIButton *)sender {
}

- (IBAction)opcionesPushButton:(UIButton *)sender {
}


- (IBAction)disparaPushButton:(UIButton *)sender {
    
    MainViewController *mainViewController = (MainViewController *)self.parentViewController;
    [mainViewController performSelector:@selector(actividadPushButton:) withObject:mainViewController];
}
@end
