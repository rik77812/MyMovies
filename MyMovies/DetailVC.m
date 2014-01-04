//
//  DetailVC.m
//  TableViewTutorial
//
//  Created by dev27 on 6/17/13.
//  Copyright (c) 2013 Codigator. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@end

@implementation DetailVC
@synthesize film;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  //9
  [self.titoloOutlet setText:self.film.title];
    [self.annoOutlet setText:[@"Anno: " stringByAppendingString: [NSString stringWithFormat:@"%ld", self.film.year]]];
    [self.catOutlet setText:[@"Cat: " stringByAppendingString:[NSString stringWithFormat:@"%ld",self.film.cat]]];
    [self.tramaOutlet  setText:film.trama];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
