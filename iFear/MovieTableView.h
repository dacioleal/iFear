//
//  MovieTableView.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 18/02/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pelicula.h"

@interface MovieTableView : UITableView

@property (strong, nonatomic) Pelicula *movie;

@end
