//
//  PuntuacionesMediasSearch.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 24/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuntuacionesMediasSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

- (NSDictionary *) searchWithParameters: (NSDictionary *) param;

@end
