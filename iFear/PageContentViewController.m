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
    
    
    _topMovieTableView.dataSource = self;
    _topMovieTableView.delegate = self;
    
    _midMovieTableView.dataSource = self;
    _midMovieTableView.delegate = self;
    
    _bottomMovieTableView.dataSource = self;
    _bottomMovieTableView.delegate = self;
    
    _topMovieTableView.layer.cornerRadius = 10;
    _midMovieTableView.layer.cornerRadius = 10;
    _bottomMovieTableView.layer.cornerRadius = 10;
    
    
    NSArray *tableViewsArray = @[_topMovieTableView, _midMovieTableView, _bottomMovieTableView];
    
    
    if (_moviesArray)
    {
        for (int i = 0; i < _moviesArray.count ; i++) {
            
            MovieTableView *movieTableView = [tableViewsArray objectAtIndex:i];
            
            movieTableView.movie = (Pelicula *) [_moviesArray objectAtIndex:i];  //Asignamos a cada TableView una película del array
           
        }
        
    }
    
    for (MovieTableView *movieTableView in tableViewsArray) {
        if (!movieTableView.movie) {                            // Si el TableView no tiene asignada una película no se muestra 
            
            movieTableView.hidden = YES;
            
            
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 11;
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    
   
    Pelicula *movie;
    
    if ([tableView isKindOfClass:[MovieTableView class]])
    {
        if (((MovieTableView *) tableView).movie)
        {
            movie = ((MovieTableView *) tableView).movie;
            
            NSArray *stringsArray = [movie stringsArrayToMakeTableView];
            NSArray *titlesArray = [movie titlesArrayToMakeTableView];
            
            NSMutableString *string = [[NSMutableString alloc] init];
            NSMutableAttributedString *attributedString;
            
            
            [string appendString:[titlesArray objectAtIndex:indexPath.row]];
            [string appendString:[stringsArray objectAtIndex:indexPath.row]];
            
            if ( indexPath.row == 0 ) {
                UIFont *font = [UIFont fontWithName:@"Helvetica" size:22.0];
                attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
                
            } else {
                UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
                attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
                
            }
            
            cell.textLabel.attributedText = attributedString;
            
            

        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate methods

// Método para calcular el alto de la celda en función del contenido

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = 0;
    
    Pelicula *movie;
    
    if ([tableView isKindOfClass:[MovieTableView class]])
    {
        if (((MovieTableView *) tableView).movie)
        {
            movie = ((MovieTableView *) tableView).movie;
            
            NSArray *stringsArray = [movie stringsArrayToMakeTableView];
            NSString *string = (NSString *)[stringsArray objectAtIndex:indexPath.row];
            
            UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
            NSAttributedString *attributes = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font}];
            CGRect rect = [attributes boundingRectWithSize:(CGSize){tableView.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            
            height = rect.size.height + 6;
            
            
        }
    }

    return height;
}



@end
















