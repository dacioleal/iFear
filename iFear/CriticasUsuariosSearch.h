//
//  CriticasUsuariosSearch.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 11/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CriticasUsuariosSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

- (NSArray *) searchWithParameters: (NSDictionary *) param;

@end
