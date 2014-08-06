//
//  PuntuacionesPeliculaSearch.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 06/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuntuacionesPeliculaSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

- (NSArray *) searchWithParameters: (NSDictionary *) param;
@end
