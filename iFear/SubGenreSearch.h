//
//  SubGenreSearch.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 17/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusquedaViewController.h"

@interface SubGenreSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

@property (strong,nonatomic) BusquedaViewController * associateVC;
- (NSArray *) searchBySubGenre: (NSData *) parameters;

@end
