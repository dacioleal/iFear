//
//  PageContentViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "PageContentViewController.h"
#import "Pelicula.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

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
    
    self.view.frame = CGRectMake(0, 0, 618, 874);
    
    self.pageControl.currentPage = self.index;
    self.pageControl.numberOfPages = self.numberOfPages;
    [self.view addSubview:self.pageControl];
    
    self.pageLabel.text = [NSString stringWithFormat:@"Página %d", _index + 1 ];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource methods




@end
