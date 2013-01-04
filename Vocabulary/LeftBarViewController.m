//
//  LeftBarViewController.m
//  Vocabulary
//
//  Created by Hikui on 13-1-3.
//  Copyright (c) 2013年 缪和光. All rights reserved.
//

#import "LeftBarViewController.h"
#import "IIViewDeckController.h"
#import "PlanningVIewController.h"
#import "WordListFromDiskViewController.h"
#import "ShowWordListViewController.h"
#import "ShowWordsViewController.h"
#import "ConfigViewController.h"
#import "CreateWordListViewController.h"

#import "AppDelegate.h"

@interface LeftBarViewController ()

@property (nonatomic, strong) NSArray *rows;

@end

@implementation LeftBarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.rows = @[@"今日学习安排",@"添加词汇列表",@"查看已有词汇",@"查看低熟悉度词汇",@"设置"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor darkGrayColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = self.rows[indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IIViewDeckController *viewDeckController = ((AppDelegate *)[UIApplication sharedApplication].delegate).viewDeckController;
    if (indexPath.row == 0) {
        if ([[((UINavigationController *)viewDeckController.centerController).viewControllers lastObject] isKindOfClass:[PlanningVIewController class]]) {
            [viewDeckController closeLeftView];
        }else{
            PlanningVIewController *pvc = [[PlanningVIewController alloc]initWithNibName:@"PlanningVIewController" bundle:nil];
            UINavigationController *npvc = [[UINavigationController alloc]initWithRootViewController:pvc];
            [viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                controller.centerController = npvc;
            }];
        }
    }else if (indexPath.row == 1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择导入方式"
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:@"批量输入",@"从iTunes上传", nil];
        [actionSheet showInView:self.view];
    }else if (indexPath.row == 2) {
        if ([[((UINavigationController *)viewDeckController.centerController).viewControllers lastObject] isKindOfClass:[ShowWordListViewController class]]) {
            [viewDeckController closeLeftView];
        }else{
            ShowWordListViewController *swlvc = [[ShowWordListViewController alloc]initWithNibName:@"ShowWordListViewController" bundle:nil];
            UINavigationController *nswlvc = [[UINavigationController alloc]initWithRootViewController:swlvc];
            [viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                controller.centerController = nswlvc;
            }];
        }
    }else if (indexPath.row == 3) {
        if ([[((UINavigationController *)viewDeckController.centerController).viewControllers lastObject] isKindOfClass:[ShowWordsViewController class]]) {
            [viewDeckController closeLeftView];
        }else{
            
            NSManagedObjectContext *ctx = [[CoreDataHelper sharedInstance] managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc]init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:ctx];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastVIewDate != nil AND ((familiarity <= 5) OR (familiarity <10 AND (NONE wordLists.effectiveCount<6))))"];
            [request setEntity:entity];
            [request setPredicate:predicate];
            NSArray *result = [ctx executeFetchRequest:request error:nil];
            NSMutableArray *mResult = [[NSMutableArray alloc]initWithArray:result];
            
            ShowWordsViewController *svc = [[ShowWordsViewController alloc]initWithNibName:@"ShowWordsViewController" bundle:nil];
            svc.wordsSet = mResult;
            
            UINavigationController *nsvc = [[UINavigationController alloc]initWithRootViewController:svc];
            [viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                controller.centerController = nsvc;
            }];
        }
    }else if (indexPath.row == 4) {
        if ([[((UINavigationController *)viewDeckController.centerController).viewControllers lastObject] isKindOfClass:[ConfigViewController class]]) {
            [viewDeckController closeLeftView];
        }else{
            ConfigViewController *cvc = [[ConfigViewController alloc]initWithStyle:UITableViewStylePlain];
            UINavigationController *ncvc = [[UINavigationController alloc]initWithRootViewController:cvc];
            [viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                controller.centerController = ncvc;
            }];
        }
    }
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"批量输入"]) {
        CreateWordListViewController *vc = [[CreateWordListViewController alloc]initWithNibName:@"CreateWordListViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
    }else if ([title isEqualToString:@"从iTunes上传"]){
        WordListFromDiskViewController *fdvc =[[WordListFromDiskViewController alloc]initWithNibName:@"WordListFromDiskViewController" bundle:nil];
        [self presentModalViewController:fdvc animated:YES];
    }
}

@end