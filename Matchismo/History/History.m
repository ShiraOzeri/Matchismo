//
//  History.m
//  Matchismo
//
//  Created by Shira Ozeri on 11/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "History.h"

@interface History ()
@property (weak, nonatomic) IBOutlet UITextView *HistoryText;

@end

@implementation History

- (void) setPresentHistory:(NSAttributedString *)presentHistory{
    _presentHistory=presentHistory;
    if(self.view.window) [self updateUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI{
    [self.HistoryText setAttributedText:self.presentHistory];
    [self.HistoryText setFont:[UIFont systemFontOfSize:17]];
   // self.HistoryText=[[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[colorOfText colorWithAlphaComponent:card.shading], NSFontAttributeName:[UIFont systemFontOfSize:12]}];
}

@end
