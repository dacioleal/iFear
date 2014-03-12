//
//  PageContentViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "PageContentViewController.h"
#import "Pelicula.h"


@interface PageContentViewController () {
    
    NSArray *tableViewsArray;
    NSArray *imageViewsArray;
}
@property (nonatomic, strong) NSMutableAttributedString *attributedString;

- (IBAction)topImageTap:(UITapGestureRecognizer *)sender;
- (IBAction)midImageTap:(UITapGestureRecognizer *)sender;
- (IBAction)bottomImageTap:(UITapGestureRecognizer *)sender;


@end



@implementation PageContentViewController

- (NSMutableAttributedString *) attributedString
{
    if (!_attributedString) {
        _attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    }
    return _attributedString;
}

- (IBAction)topImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:0];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:movie, @"movie", nil];
    [defaultCenter postNotificationName:@"goToMovieDetail" object:self userInfo:userInfo];
   
}

- (IBAction)midImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:1];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:movie, @"movie", nil];
    [defaultCenter postNotificationName:@"goToMovieDetail" object:self userInfo:userInfo];
    
}

- (IBAction)bottomImageTap:(UITapGestureRecognizer *)sender
{
    Pelicula * movie = (Pelicula *)[_moviesArray objectAtIndex:2];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:movie, @"movie", nil];
    [defaultCenter postNotificationName:@"goToMovieDetail" object:self userInfo:userInfo];
    
}



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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImages) name:@"imagesSetFinished" object:nil];
    
    _topMovieTableView.dataSource = self;
    _topMovieTableView.delegate = self;
    
    _midMovieTableView.dataSource = self;
    _midMovieTableView.delegate = self;
    
    _bottomMovieTableView.dataSource = self;
    _bottomMovieTableView.delegate = self;
    
    tableViewsArray = @[_topMovieTableView, _midMovieTableView, _bottomMovieTableView];
    imageViewsArray = @[_topImageView, _midImageView, _bottomImageView];
    
    
    
    if (_moviesArray)
    {
        for (int i = 0; i < _moviesArray.count ; i++) {
            
            MovieTableView *movieTableView = [tableViewsArray objectAtIndex:i];
            
            movieTableView.movie = (Pelicula *) [_moviesArray objectAtIndex:i];  //Asignamos a cada TableView una película del array
            
            UIImageView *imageView = (UIImageView *) [imageViewsArray objectAtIndex:i];
            
            if ( movieTableView.movie.imagen )
            imageView.image = movieTableView.movie.imagen;  // Asignamos la imagen de la película a su ImageView
            
        }
        
    }
    
    for (MovieTableView *movieTableView in tableViewsArray) {
        if (!movieTableView.movie) {                            // Si el TableView no tiene asignada una película no se muestra 
            
            movieTableView.hidden = YES;
            int index = [tableViewsArray indexOfObject:movieTableView];
            UIImageView *imageView = [imageViewsArray objectAtIndex:index];
            imageView.hidden = YES;                                // Y tampoco se muestra el ImageView de la película
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addImages
{
    for (Pelicula *movie in _moviesArray) {
        NSInteger index = [self.moviesArray indexOfObject:movie];
        UIImageView *imageView = (UIImageView *) [imageViewsArray objectAtIndex:index];
        imageView.image = movie.imagen;
    }
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
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
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
            
            NSMutableAttributedString *attributedTitleString, *attributedDescriptionString;
            NSString *titleString = [titlesArray objectAtIndex:indexPath.row];
            
            
            if ( indexPath.row == 0 ) {
                
                UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:26.0];
                UIColor *textColor = [UIColor colorWithRed:0.478   green:0.176 blue:0.153 alpha:1.0];
                string = [stringsArray objectAtIndex:0];
                _attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
                
            } else {
                
                UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
                attributedTitleString = [[NSMutableAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName: font}];
                [_attributedString appendAttributedString:attributedTitleString];
                
                NSString *descriptionString = [stringsArray objectAtIndex:indexPath.row];
                font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
                attributedDescriptionString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font}];
                [_attributedString appendAttributedString:attributedDescriptionString];
            }
            
            cell.textLabel.attributedText = _attributedString;
            _attributedString = [[NSMutableAttributedString alloc] init];
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
            NSArray *titlesArray = [movie titlesArrayToMakeTableView];
            
            NSMutableString *string = [[NSMutableString alloc] init];
            
            NSMutableAttributedString *attributedTitleString, *attributedDescriptionString;
            NSString *titleString = [titlesArray objectAtIndex:indexPath.row];
            
            
            
            if ( indexPath.row == 0 ) {
                
                UIFont *font = [UIFont fontWithName:@"Futura-Medium" size:26.0];
                UIColor *textColor = [UIColor brownColor];
                string = [stringsArray objectAtIndex:0];
                _attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
                
            } else {
                
                UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
                attributedTitleString = [[NSMutableAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName: font}];
                [_attributedString appendAttributedString:attributedTitleString];
                
                NSString *descriptionString = [stringsArray objectAtIndex:indexPath.row];
                font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
                attributedDescriptionString = [[NSMutableAttributedString alloc] initWithString:descriptionString attributes:@{NSFontAttributeName: font}];
                [_attributedString appendAttributedString:attributedDescriptionString];
            }

            CGRect rect = [_attributedString boundingRectWithSize:(CGSize){tableView.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            
            height = rect.size.height + 6;
            _attributedString = [[NSMutableAttributedString alloc] init];
        }
    }

    return height;
}



@end
















