//
//  SensationsSearch.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 03/05/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusquedaViewController.h"

@interface SensationsSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

@property (strong,nonatomic) BusquedaViewController * associateVC;
- (NSArray *) searchBySensations: (NSMutableDictionary *) param;

@end
