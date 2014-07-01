//
//  ParametersSearch.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 10/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParametersSearch :  NSObject <NSURLConnectionDataDelegate, NSURLSessionDelegate, UIAlertViewDelegate>

@property (strong,nonatomic) UIViewController * associateVC;
- (NSArray *) searchByParameters: (NSMutableDictionary *) param;

@end
