//
//  EstrenosCollectionViewController.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 26/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstrenosCollectionViewController : UICollectionViewController

- (IBAction)slideOnePushButton:(UIButton *)sender;
- (IBAction)slideTwoPushButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *slideButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *slideButtonTwo;

@end
