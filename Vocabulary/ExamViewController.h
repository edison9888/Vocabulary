//
//  ExamViewController.h
//  Vocabulary
//
//  Created by 缪 和光 on 12-10-23.
//  Copyright (c) 2012年 缪和光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WordList.h"

@interface ExamViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) WordList *wordList;
@property (nonatomic, strong) NSArray *wordsArray;
@property (nonatomic, unsafe_unretained) int cursor1;
//@property (nonatomic, unsafe_unretained) int cursor2;
//@property (nonatomic, strong) NSMutableArray *examContentsQueueE2C;
//@property (nonatomic, strong) NSMutableArray *examContentsQueueS2E;
@property (nonatomic, strong) NSMutableArray *examContentsQueue;
@property (nonatomic, strong) NSMutableArray *examViewReuseQueue;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *rightButton;
@property (nonatomic, strong) IBOutlet UILabel *roundNotificatonLabel;
@property (nonatomic, strong) AVAudioPlayer *soundPlayer;

- (id)initWithWordList:(WordList *)wordList;
- (id)initWithWordArray:(NSMutableArray *)wordArray;

- (IBAction)rightButtonOnPress:(id)sender;
- (IBAction)wrongButtonOnPress:(id)sender;

- (void)calculateFamiliarityForEveryWords;

@end
