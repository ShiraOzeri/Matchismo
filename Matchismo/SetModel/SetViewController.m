//
//  SetViewController.m
//  Matchismo
//
//  Created by Shira Ozeri on 07/11/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "SetViewController.h"
#import "PlayingSetDeck.h"
#import "SetPlayingCard.h"
#import "SetGame.h"

@interface SetViewController ()

@end

@implementation SetViewController

-(Deck *)createDeck {
    return [[PlayingSetDeck alloc] init];
    
}
-(CardGame *)createGame:(Deck *)deck count:(NSInteger) count{
    return [[SetGame alloc] initWithCardCount:count usingDeck:deck];
}


- (void)setImageBackgroundForButtonCardFront:(UIButton *)button withCard:(Card *)card{
    [button setBackgroundColor:[UIColor separatorColor]];
    [button setAttributedTitle:[self textAttributedForCard:(SetPlayingCard *)card] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
}
- (void)setImageBackgroundForButtonCardBack:(UIButton *)button withCard:(Card *)card{
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setAttributedTitle:[self textAttributedForCard:(SetPlayingCard *)card] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    
}

- (UIColor *)colorOfText:(SetPlayingCard *)card{
    if([card.color isEqualToString:@"RED"]) return [UIColor redColor];
    if([card.color isEqualToString:@"GREEN"]) return [UIColor greenColor];
    if([card.color isEqualToString:@"PURPLE"]) return [UIColor purpleColor];
    return [UIColor blackColor];
    
    
}





- (NSMutableAttributedString *)textAttributedForCard:(SetPlayingCard *)card{
    NSString *text;
    if(card.numberOfShape==1) {
        text=[NSString stringWithFormat:@"%@ ",card.shape];
    } else if(card.numberOfShape==2){
        text=[NSString stringWithFormat:@"%@%@ ",card.shape,card.shape];
    } else if(card.numberOfShape==3) {
        text=[NSString stringWithFormat:@"%@%@%@ ",card.shape,card.shape,card.shape];
    }
    
    UIColor *colorOfText=[self colorOfText:card] ;
    NSMutableAttributedString *title=[[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[colorOfText colorWithAlphaComponent:card.shading], NSFontAttributeName:[UIFont systemFontOfSize:12]}];// , NSStrokeWidthAttributeName:@3, NSStrokeColorAttributeName:colorOfText}];
    
    
    return title;
}

- (NSAttributedString *)getStringState{
    
    
    if(!self.game.status)
        return [[NSAttributedString alloc]initWithString:@"State: New Game"];
    NSMutableAttributedString *contextOfChosenCards=[self stringOfChosenCards:self.game.status.chosenCards];
    if(self.game.status.match){
        NSString *stringOfState=[NSString stringWithFormat:@" Matched! %ld points",self.game.status.points];
        NSMutableAttributedString *attributerOfState=[[NSMutableAttributedString alloc]initWithString:stringOfState];
        [contextOfChosenCards appendAttributedString:attributerOfState];
        return contextOfChosenCards;
    }
    if(!self.game.status.match){
        if(self.game.status.points==1){
            NSMutableAttributedString *attributerOfState=[[NSMutableAttributedString alloc]initWithString:@"one point penalty"];
            [contextOfChosenCards appendAttributedString:attributerOfState];
            return contextOfChosenCards;
            
        }if(self.game.status.points==0){
            NSMutableAttributedString *attributerOfState=[[NSMutableAttributedString alloc]initWithString:@"not chosen"];
            contextOfChosenCards=[self textAttributedForCard:(SetPlayingCard *)self.game.status.selectedCard];
            [contextOfChosenCards appendAttributedString:attributerOfState];
            
            return contextOfChosenCards;
        }if(self.game.status.chosenCards){
            NSString *stringOfState=[NSString stringWithFormat:@" don't match! %ld point penalty",self.game.status.points];
            NSMutableAttributedString *attributerOfState=[[NSMutableAttributedString alloc]initWithString:stringOfState];
            [contextOfChosenCards appendAttributedString:attributerOfState];
            return contextOfChosenCards;
            
        }
    }
    return [[NSAttributedString alloc]initWithString:@""];
    
    
}

-(NSMutableAttributedString *)stringOfChosenCards:(NSArray *)chosenCards{
    //NSString *stateChosenCards=@"";
    NSMutableAttributedString *contents=[[NSMutableAttributedString alloc]init];
    for (SetPlayingCard *otherCard in chosenCards) {
        [contents appendAttributedString:[self textAttributedForCard:otherCard]];
        
    }
    return contents;
}

@end
