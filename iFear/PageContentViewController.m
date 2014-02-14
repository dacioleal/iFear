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

- (id) initWithPeliculas: (NSArray *) peliculas withIndex:(NSUInteger)index andNumberOfPages:(NSUInteger)numberOfPages
{
    
    self = [super init];
    self.peliculasArray = peliculas;
    self.index = index;
    self.numberOfPages = numberOfPages;
    
    self.pageControl.currentPage = index;
    self.pageControl.numberOfPages = numberOfPages - 1;
    
    self.etiquetaLabel.text = [NSString stringWithFormat:@"Pagina %d", index ];
    
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


@end
