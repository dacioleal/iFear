//
//  TrailersSearch.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 29/04/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrailersSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

- (NSArray *) searchWithParameters: (NSDictionary *) param;

@end
