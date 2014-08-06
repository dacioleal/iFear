//
//  UserScoreCell.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 06/08/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserScoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *terrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *goreLabel;
@property (weak, nonatomic) IBOutlet UILabel *humorLabel;
@property (weak, nonatomic) IBOutlet UILabel *calidadLabel;
@end
