//
//  PopoverSelectorBusquedaViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 02/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverSelectorBusquedaDelegate <NSObject>

@required
- (void) setSearchSelector: (NSString *) selector;
@end

@interface PopoverSelectorBusquedaViewController : UITableViewController

// Delegado
@property (nonatomic, weak) id<PopoverSelectorBusquedaDelegate> delegate;

@end
