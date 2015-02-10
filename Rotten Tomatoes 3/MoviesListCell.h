//
//  MoviesListCellTableViewCell.h
//  Rotten Tomatoes 3
//
//  Created by Yogi Sharma on 2/8/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
