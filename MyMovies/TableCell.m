//
//  TableCell.m
//  DBStory
//
//  Created by Enrica on 25/10/13.
//  Copyright (c) 2013 Riccardo Faveto. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize cellTitle = _cellTitle;
@synthesize cellDescr = _cellDescr;
//@synthesize cellImage = _cellImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
