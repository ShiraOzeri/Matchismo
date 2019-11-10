//
//  PlaynigCardGameViewController.m
//  Matchismo
//
//  Created by Shira Ozeri on 05/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "PlaynigCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "Card.h"



@interface PlaynigCardGameViewController ()

@end

@implementation PlaynigCardGameViewController
static NSString * const kimageNamedFront = @"cardfront";
static NSString * const kimageNamedBack = @"cardback";


-(Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
    
}
-(CardGame *)createGame:(Deck *)deck count:(NSInteger) count{
    return [[CardMatchingGame alloc] initWithCardCount:count usingDeck:deck];
}

//- (NSString *)imageNamedFront{
//    return @"cardfront";
//}
//- (NSString *)imageNamedBack{
//
//    return @"cardback";
//}

- (void)setImageBackgroundForButtonCardFront:(UIButton *)button withCard:(Card *)card{
    [button setBackgroundImage:[UIImage imageNamed: kimageNamedFront] forState:(UIControlStateNormal)];
    [button setTitle:[card contents] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
}
- (void)setImageBackgroundForButtonCardBack:(UIButton *)button withCard:(Card *)card{
    [button setBackgroundImage:[UIImage imageNamed:kimageNamedBack] forState:(UIControlStateNormal)];
    [button setTitle:@"" forState:UIControlStateNormal];
    
}

- (NSAttributedString *)getStringState{
    
    
    if(!self.game.status)
        return [[NSAttributedString alloc]initWithString:@"State: New Game"];
    NSString *contextOfChosenCards=[self stringOfChosenCards:self.game.status.chosenCards];
    if(self.game.status.match){
        NSString *allState=[[NSString alloc] initWithFormat:@"Matched %@ for %ld points ",contextOfChosenCards,self.game.status.points];
        return [[NSAttributedString alloc]initWithString:allState];
    }
    if(!self.game.status.match){
        if(self.game.status.points==1){
            NSString *allState=[[NSString alloc] initWithFormat:@"%@ one point penalty",contextOfChosenCards];
            return [[NSAttributedString alloc]initWithString:allState];
        }if(self.game.status.points==0){
            NSString *allState=[[NSString alloc] initWithFormat:@"%@ not chosen",self.game.status.selectedCard.contents];
            return [[NSAttributedString alloc]initWithString:allState];
        }if(self.game.status.chosenCards){
            NSString *allState=[[NSString alloc] initWithFormat:@"%@ don't match! %ld point penalty ",contextOfChosenCards,self.game.status.points];
            return [[NSAttributedString alloc]initWithString:allState];
        }
    }
    return [[NSAttributedString alloc]initWithString:@""];
    
    
}

-(NSString *)stringOfChosenCards:(NSArray *)chosenCards{
    NSString *stateChosenCards=@"";
    for (Card *otherCard in chosenCards) {
        stateChosenCards=[stateChosenCards stringByAppendingString:(otherCard.contents)];
        
    }
    return stateChosenCards;
}

@end
