
/*
 *  This file is part of 记词助手.
 *
 *	记词助手 is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License Version 2 as 
 *  published by the Free Software Foundation.
 *
 *	记词助手 is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with 记词助手.  If not, see <http://www.gnu.org/licenses/>.
 */

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
@property (nonatomic, weak) IBOutlet UIBarButtonItem *wrongButton;
@property (nonatomic, strong) IBOutlet UIView *roundNotificatonView;
//@property (nonatomic, strong) AVAudioPlayer *soundPlayer;
@property (nonatomic, strong) NSMutableSet *wrongWordsSet;

- (id)initWithWordList:(WordList *)wordList;
- (id)initWithWordArray:(NSMutableArray *)wordArray;

- (IBAction)rightButtonOnPress:(id)sender;
- (IBAction)wrongButtonOnPress:(id)sender;

- (void)calculateFamiliarityForEveryWords;

@end
