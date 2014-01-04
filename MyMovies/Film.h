//
//  Film.h
//  JSClient
//
//  Created by Riccardo Faveto on 11/10/13.
//  Copyright (c) 2013 Riccardo Faveto. All rights reserved.
//


@interface Film: NSObject

@property (nonatomic, assign) int Id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *trama;
@property (nonatomic, assign) int year;
@property (nonatomic, assign) int durata;
@property (strong, nonatomic) NSString *cover;
@property (nonatomic, assign) int coverW;
@property (nonatomic, assign) int coverH;
@property (strong, nonatomic) NSDate * data;
@property (nonatomic, assign) int cat;
@property (strong, nonatomic) NSString *genere;
@end