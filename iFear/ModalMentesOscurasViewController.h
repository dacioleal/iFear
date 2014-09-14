//
//  ModalMentesOscurasViewController.h
//  iFear
//
//  Created by José Alberto Martín Falcón on 23/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalMentesOscurasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *popupView;

- (IBAction)pushReturnButton:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listLabelTitleTopHits;



@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *
listTitleTopHits;
@property (weak, nonatomic) IBOutlet UILabel *labelWorstMovieTerror;
@property (weak, nonatomic) IBOutlet UILabel *titleWorstMovieTerror;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *listLabelUserData;

@property (weak, nonatomic) IBOutlet UIView *topHitsView;
@property (weak, nonatomic) IBOutlet UIView *opinionView;
@property (weak, nonatomic) IBOutlet UITableView *opinionTable;
- (IBAction)changeView:(id)sender;

@end
