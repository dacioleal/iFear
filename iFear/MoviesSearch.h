//
//  MoviesSearch.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 28/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviesSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

- (NSArray *) searchWithParameters: (NSDictionary *) param;

@end
