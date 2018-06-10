//
//  UITableViewCell+PDFCell.m
//  PDFSorter
//
//  Created by Anna Leskova on 5/30/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import "PDFCell.h"
#import "PDF.h"

@interface PDFCell ()

@end

@implementation PDFCell

- (void) setupViews {
    [self addSubview:self.thumbnail];
    [self addSubview:self.name];
    [self addSubview:self.date];
    [self addSubview:self.size];
    
    [self.thumbnail.leftAnchor constraintEqualToAnchor:self.leftAnchor constant : 5].active = YES;
    [self.thumbnail.widthAnchor constraintEqualToConstant:40].active = YES;
    [self.thumbnail.topAnchor constraintEqualToAnchor:self.topAnchor constant : 5].active = YES;
    [self.thumbnail.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant : -5].active = YES;
    
    [self.name.leftAnchor constraintEqualToAnchor:self.thumbnail.rightAnchor constant : 5].active = YES;
    [self.name.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [self.name.topAnchor constraintEqualToAnchor:self.topAnchor constant : 5].active = YES;
    [self.name.bottomAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    [self.date.leftAnchor constraintEqualToAnchor:self.thumbnail.rightAnchor constant : 5].active = YES;
    [self.date.rightAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.date.topAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [self.date.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant : -5].active = YES;
    
    [self.size.leftAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.size.rightAnchor constraintEqualToAnchor:self.rightAnchor constant : -24].active = YES;
    [self.size.topAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [self.size.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant : -5].active = YES;
}

- (void) fillLabels : (PDF *) pdf {
    self.thumbnail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"acrobat.png"]];
    self.name.text = [pdf getName];
    self.date.text = [pdf getDateString];
    self.size.text = [pdf getSizeString];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //setup thumbnail
        self.thumbnail = [[UIView alloc] init];
        self.thumbnail.translatesAutoresizingMaskIntoConstraints = NO;
        
        //set up name label
        self.name = UILabel.new;
        self.name.translatesAutoresizingMaskIntoConstraints = NO;
        self.name.textColor = UIColor.blackColor;
        [self.name setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
        
         //set up date label
        self.date = UILabel.new;
        self.date.translatesAutoresizingMaskIntoConstraints = NO;
        self.date.textColor = UIColor.grayColor;
        [self.date setFont:[UIFont fontWithName:@"Arial" size:14]];
        
         //set up size label
        self.size = UILabel.new;
        self.size.translatesAutoresizingMaskIntoConstraints = NO;
        self.size.textColor = UIColor.grayColor;
        [self.size setFont:[UIFont fontWithName:@"Arial" size:14]];
        self.size.textAlignment = NSTextAlignmentRight;

        
        [self setupViews];
    }
    return self;
}

@end
