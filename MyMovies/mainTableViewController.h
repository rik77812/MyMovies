//
//  mainTableViewController.h
//  JSClient
//
//  Created by Riccardo Faveto on 08/10/13.
//  Copyright (c) 2013 Riccardo Faveto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Film.h"
#import "DetailVC.h"
#import "AppDelegate.h"
#import "TableCell.h"

@interface mainTableViewController : UITableViewController
//@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *films;
@end
