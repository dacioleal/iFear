//
//  IfearAlertView.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 21/06/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IfearAlertView : UIViewController

// Método para establecer el mensaje en el AlertView y mostrarlo
- (void) showAlert: (id) sender withMessage: (NSString *) message;
@end