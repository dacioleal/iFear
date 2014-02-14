//
//  PageContentViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imagenUno;
@property (weak, nonatomic) IBOutlet UIImageView *imagenDos;
@property (weak, nonatomic) IBOutlet UIImageView *imagenTres;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicadorDeCargo;

@property (nonatomic) NSArray * peliculasArray; // Array que contiene las tres peliculas a mostrar
@property (nonatomic) NSUInteger index;
@property (nonatomic) NSUInteger numberOfPages;

@property (weak, nonatomic) IBOutlet UILabel *etiquetaLabel;

- (id) initWithPeliculas: (NSArray *) peliculas withIndex:(NSUInteger)index andNumberOfPages:(NSUInteger)numberOfPages;

@end
