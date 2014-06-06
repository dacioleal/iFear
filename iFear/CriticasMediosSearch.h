//
//  CriticasMediosSearch.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 02/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CriticasMediosSearch : NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

- (NSArray *) searchWithParameters: (NSDictionary *) param;

@end
