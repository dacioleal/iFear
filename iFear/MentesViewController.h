//
//  MentesViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 22/08/2014.
//  Copyright (c) 2014 José Alberto Martín Falcón. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MentesViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listUserName;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listPercent;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listAfin;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listUserData;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listMovieTitle;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listIntroText;

- (IBAction)pushProfileButton:(id)sender;



@end
