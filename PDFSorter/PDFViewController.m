//
//  ViewController+PDFViewController.m
//  PDFSorter
//
//  Created by Anna Leskova on 6/5/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import "PDFViewController.h"

@implementation PDFViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selctedPDF = PDFView.new;
        self.selctedPDF.backgroundColor = UIColor.grayColor;
        self.selctedPDF.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.selctedPDF];
        
        [self.selctedPDF.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [self.selctedPDF.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [self.selctedPDF.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
        [self.selctedPDF.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    }
    return self;
}

@end
