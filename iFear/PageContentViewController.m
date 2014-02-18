//
//  PageContentViewController.m
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import "PageContentViewController.h"
#import "Pelicula.h"
#import "MovieTableView.h"

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
    
   
    
    
    self.pageLabel.text = [NSString stringWithFormat:@"Página %d", _index + 1 ];
    
    self.topTableView.dataSource = self;
    self.topTableView.delegate = self;
    
    self.midTableView.dataSource = self;
    self.midTableView.delegate = self;
    
    self.bottomTableView.dataSource = self;
    self.bottomTableView.delegate = self;
    
    self.topTableView.layer.cornerRadius = 10;
    self.midTableView.layer.cornerRadius = 10;
    self.bottomTableView.layer.cornerRadius = 10;
    
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 10;
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.backgroundColor = [UIColor lightGrayColor];
    
    Pelicula *movie;
    
    if (tableView == self.topTableView && self.moviesArray.count > 0) {
        movie = [self.moviesArray objectAtIndex:0];
    }
    
    if (tableView == self.midTableView && self.moviesArray.count > 1) {
        movie = [self.moviesArray objectAtIndex:1];
    }
    
    if (tableView == self.bottomTableView && self.moviesArray.count > 2) {
        movie = [self.moviesArray objectAtIndex:2];
    }
    
       
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = movie.titulo;
            
            return cell;
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"Año: %d  País: %@", movie.anio, movie.pais];
            return cell;
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"Director: %@", movie.director];
            return cell;
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"Sinopsis: %@", movie.sinopsis];
            return cell;
            break;
        case 4:
            cell.textLabel.text = [NSString stringWithFormat:@"Reparto: %@", movie.reparto];
            return cell;
            break;
        case 5:
            cell.textLabel.text = [NSString stringWithFormat:@"Guión: %@", movie.guion];
            return cell;
            break;
        case 6:
            cell.textLabel.text = [NSString stringWithFormat:@"Música: %@", movie.musica];
            return cell;
            break;
        case 7:
            cell.textLabel.text = [NSString stringWithFormat:@"Fotografía: %@", movie.fotografia];
            return cell;
            break;
        case 8:
            cell.textLabel.text = [NSString stringWithFormat:@"Productora: %@", movie.productora];
            return cell;
            break;
        case 9:
            cell.textLabel.text = [NSString stringWithFormat:@"Web: %@", movie.web];
            return cell;
            break;
        default:
            cell.textLabel.text = @"";
            return cell;
            break;
    }
    
}

#pragma mark - UITableViewDelegate methods

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    CGFloat height = 0;
//
//    Noticias *noticia = [noticiasArray objectAtIndex:indexPath.row];
//
//    UIFont *font = [UIFont systemFontOfSize:17.0];
//    NSAttributedString *attributes = [[NSAttributedString alloc] initWithString:noticia.titulo attributes:@{NSFontAttributeName:font}];
//
//    CGRect rect = [attributes boundingRectWithSize:(CGSize){710, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//
//    height = rect.size.height + 48;
//
//
//
//    return height;
//}



@end
















