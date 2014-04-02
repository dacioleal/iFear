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
    Pelicula *movieForSegue;
   
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
    
   //self.collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"goToMovieDetailTwo"])
    {
        if ([segue.destinationViewController respondsToSelector:@selector(setMovie:)]) {
            [segue.destinationViewController performSelector:@selector(setMovie:) withObject:movieForSegue];
        }
    }
}





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
    
    Pelicula *movie = (Pelicula * ) [_moviesList objectAtIndex:indexPath.item];
    cell.movieCellImageView.image = movie.imagen;
    UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:20.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[movie.titulo uppercaseString] attributes:@{NSFontAttributeName: font}];
    cell.movieCellTitleLabel.attributedText = attributedString;
    cell.movieCellTitleLabel.shadowColor = [UIColor blackColor];
    cell.movieCellTitleLabel.shadowOffset = CGSizeMake(0, 2);
    
    UIColor *textColor = [UIColor colorWithRed:0.98 green:0.89 blue:0.51 alpha:1.0];
    attributedString = [[NSAttributedString alloc] initWithString:@"21 marzo 2014" attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
    cell.movieCellDateLabel.attributedText = attributedString;
    cell.movieCellDateLabel.shadowColor = [UIColor blackColor];
    cell.movieCellDateLabel.shadowOffset = CGSizeMake(0, 2);
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _moviesList.count;
}



#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    movieForSegue = (Pelicula *) [_moviesList objectAtIndex:indexPath.item];
    [self performSegueWithIdentifier:@"goToMovieDetailTwo" sender:self];
}




@end

























