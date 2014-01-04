//
//  TableCell.h
//  DBStory
//
//  Created by Enrica on 25/10/13.
//  Copyright (c) 2013 Riccardo Faveto. All rights reserved.
//

#import <UIKit/UIKit.h>
//5
@protocol TableCellDelegate
@optional
@end

@interface TableCell : UITableViewCell
@property (nonatomic, strong) id  delegate;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellDescr;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@end
