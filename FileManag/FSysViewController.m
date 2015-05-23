//
//  FSysViewController.m
//  FileManag
//
//  Created by huweitao on 14-9-19.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "FSysViewController.h"

@interface FSysViewController ()
{
    NSString *glFilePath;
    NSString *glFileDirec;
}

@end

@implementation FSysViewController

@synthesize label;

- (void)labelFromFileOp
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *urls = [fileManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    NSLog(@"urls:%@",urls);
    if ([urls count] > 0) {
        NSURL *cachesFolder = urls[0];
        NSLog(@"Cache Foler:%@",cachesFolder);
    }
    else
    {
        NSLog(@"Could not find Cache Folder");
    }
    // write
    NSString *someText = @"English:This message is from Filemanag.app.\nChinese:这是从Filemanag.app写入的信息";
    if ([urls count] > 0) {
        NSString *urlPath = [(NSURL *)urls[0] path];
        glFileDirec = urlPath;
        NSString *denstPath = [urlPath stringByAppendingPathComponent:@"MyText.text"];
        glFilePath = denstPath;
        NSError *error = nil;
        BOOL succeed = [someText writeToFile:denstPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (succeed && !error) {
            NSLog(@"Write Message Successfully:%@",someText);
        }
    }
    else
    {
        NSLog(@"Could not write in Cache Folder");
    }
}

- (IBAction)readFile:(id)sender
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:glFilePath]) {
        NSError *error;
        NSString *someText = [[NSString alloc]initWithContentsOfFile:glFilePath encoding:NSUTF8StringEncoding error:&error];
        // adjust to size of text
        
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        CGSize size = [someText sizeWithAttributes:@{NSFontAttributeName:font}];
        
        CGRect rect = [someText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil];
        [self.label setFrame:CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y, self.label.frame.size.width, rect.size.height)];
         
        //[self.label sizeToFit];
        self.label.text = someText;
        NSLog(@"read:%@",someText);
    }
    else
    {
        self.label.text = nil;
        NSLog(@"No File Path!");
    }
}

- (IBAction)deleteFile:(id)sender
{
    NSError *error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:glFilePath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:glFileDirec error:&error];
        if (!error) {
            NSError *err = nil;
            if ([contents count] > 0) {
                for (id filePath in contents) {
                    NSString *fullPath = [glFileDirec stringByAppendingPathComponent:(NSString *)filePath];
                    [fileManager removeItemAtPath:fullPath error:&err];
                    NSLog(@"Delete at file path:%@",(NSString *)filePath);
                }
            }
            else if ([contents count] == 0)
            {
                NSLog(@"Nothing at File Path ");
            }
            else
            {
                NSLog(@"handle error at File Path");
            }
        }
        else
        {
            NSLog(@"Could not Get File Path");
        }
    }
    else
    {
        NSLog(@"No File Path!:%@",error);
    }
}

- (IBAction)appendToFile:(id)sender
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:glFilePath]) {
        NSError *error = nil;
        NSString *readText = [[NSString alloc]initWithContentsOfFile:glFilePath encoding:NSUTF8StringEncoding error:&error];
        if (readText) {
            NSString *appendStr = @"\nThis message is to add something in Text!\n";
            readText = [readText stringByAppendingString:appendStr];
            if ([readText writeToFile:glFilePath atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
                NSLog(@"Add to file");
            }
            else
            {
                NSLog(@"Fail to add");
            }
        }
    }
    else
    {
        NSLog(@"No file path!");
    }
    
    /*
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:glFilePath];
    if (fileHandle) {
        NSString *appendStr = @"\nThis message is from FileHandle to update the Text!\n";
        NSData *data = [appendStr dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:data];
        NSLog(@"Add to file");
    }
    else
    {
        NSLog(@"file handle error");
    }
    [fileHandle closeFile];
     */
}

- (IBAction)unwindToThisPage:(UIStoryboardSegue *)segue
{
    NSLog(@"Wlecome Back!");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self labelFromFileOp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
