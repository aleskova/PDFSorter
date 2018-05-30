//
//  AppDelegate.h
//  PDFSorter
//
//  Created by Anna Leskova on 5/30/18.
//  Copyright © 2018 Anna Leskova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

