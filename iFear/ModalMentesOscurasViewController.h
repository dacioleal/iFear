//
//  ModalMentesOscurasViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 23/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalMentesOscurasViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *popupView;

- (void) showProfile: (id) sender;
- (IBAction)pushReturnButton:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listLabelTitleTopHits;



@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *
listTitleTopHits;
@property (weak, nonatomic) IBOutlet UILabel *labelWorstMovieTerror;
@property (weak, nonatomic) IBOutlet UILabel *titleWorstMovieTerror;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listLabelUserData;
@end
