//
//  SubGenreSearch.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 17/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubGenreSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

- (NSArray *) searchBySubGenre: (NSData *) paramters;

@end
