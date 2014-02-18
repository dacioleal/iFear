//
//  PageContentViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *midImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic) IBOutlet UITableView *topTableView;
@property (weak, nonatomic) IBOutlet UITableView *midTableView;
@property (weak, nonatomic) IBOutlet UITableView *bottomTableView;


@property (nonatomic) NSArray * moviesArray; // Array que contiene las tres peliculas a mostrar
@property (nonatomic) NSUInteger index;
@property (nonatomic) NSUInteger numberOfPages;

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;



@end
