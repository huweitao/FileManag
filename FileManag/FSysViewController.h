//
//  FSysViewController.h
//  FileManag
//
//  Created by huweitao on 14-9-19.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSysViewController : UIViewController
@property (weak,nonatomic) IBOutlet UILabel *label;

- (IBAction)readFile:(id)sender;
- (IBAction)deleteFile:(id)sender;
- (IBAction)appendToFile:(id)sender;
- (IBAction)unwindToThisPage:(UIStoryboardSegue *)segue;

@end
