//
//  DetailVC.h
//  TableViewTutorial
//
//  Created by dev27 on 6/17/13.
//  Copyright (c) 2013 Codigator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Film.h"

@interface DetailVC : UIViewController
//8
@property (nonatomic, strong) Film *film;
@property (weak, nonatomic) IBOutlet UIImageView *Locandina;
@property (weak, nonatomic) IBOutlet UILabel *titoloOutlet;
@property (weak, nonatomic) IBOutlet UITextView *tramaOutlet;
@property (weak, nonatomic) IBOutlet UILabel *annoOutlet;
@property (weak, nonatomic) IBOutlet UILabel *catOutlet;
@property (weak, nonatomic) IBOutlet UILabel *durataOutlet;
@end
