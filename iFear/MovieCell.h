//
//  MovieCell.h
//  iFear
//
//  Created by Dacio Leal Rodriguez on 28/03/14.
//  Copyright (c) 2014 Dacio Leal Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *movieCellImageView;
@property (strong, nonatomic) IBOutlet UILabel *movieCellTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *movieCellDateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *movieCellSoporteLabel;


@end
