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
@property (weak, nonatomic) IBOutlet UIProgressView *Progress;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *SyncButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *AllButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *OnButton;

- (IBAction)ClickSyncButton:(id)sender;
- (IBAction)ClickAllButton:(id)sender;
- (IBAction)ClickOnButton:(id)sender;



@end
