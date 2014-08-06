//
//  LadoOscuroTableViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 02/07/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LadoOscuroTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *puntuacionesUsuariosArray;
@property (nonatomic, strong) NSString *movieID;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end
