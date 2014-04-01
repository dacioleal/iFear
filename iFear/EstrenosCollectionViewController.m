//
//  EstrenosCollectionViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 26/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "EstrenosCollectionViewController.h"
#import "MovieCell.h"
#import "CarteleraViewController.h"

@interface EstrenosCollectionViewController () {
    
    BOOL estrenosViewisHidden;
   
}


- (IBAction)titleTap:(UITapGestureRecognizer *)sender;

@end

@implementation EstrenosCollectionViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (IBAction)titleTap:(UITapGestureRecognizer *)sender {
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter postNotificationName:@"showEstrenosView" object:self];
    
    
}


#pragma mark - UICollectionViewDataSource methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarteleraViewController *carteleraViewController = (CarteleraViewController *) self.parentViewController;
    _moviesList = carteleraViewController.estrenosMoviesList;
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    
    Pelicula *movie = (Pelicula * ) [_moviesList objectAtIndex:(NSUInteger)indexPath];
    cell.movieCellImageView.image = movie.imagen;
    cell.movieCellTitleLabel.text = movie.titulo;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _moviesList.count;
}



#pragma mark - UICollectionViewDelegate methods






@end

























