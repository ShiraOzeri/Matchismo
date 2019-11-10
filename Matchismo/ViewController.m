//
//  ViewController.m
//  Matchismo
//
//  Created by Shira Ozeri on 28/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
//#import "PlayingCardDeck.h"
#import "CardGame.h"
#import "History.h"


@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *score;
//@property (weak, nonatomic) IBOutlet UIButton *matchingNewGame;
@property (weak, nonatomic) IBOutlet UIButton *matchingNewGame;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (strong,nonatomic) NSMutableAttributedString *saveHistory;

@end

@implementation ViewController

//- (instancetype)initWithCoder:(NSCoder *)coder {
//    if ([super initWithCoder:coder]) {
//        //self.deck=[[PlayingCardDeck alloc]init];
//        // self.game=[[CardMatchingGame alloc] initWithCardCount:12 usingDeck:self.deck];
//    }
//
//    return self;
//}


//-(CardMatchingGame *)game{
//    if(!_game) _game=[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
//    return _game;
//
//}
//
//

-(Deck *)createDeck{
    return nil;
}

-(CardGame *)createGame:(Deck *)deck count:(NSInteger) count{
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self newGame];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"Show History"]){
        if([segue.destinationViewController isKindOfClass:[History class]]){
            History *changeHistory=(History *)segue.destinationViewController;
            changeHistory.presentHistory=self.saveHistory;
        }
    }
}



- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger index=[self.cardButtons indexOfObject:sender];
    //NSLog(@"button: %ld",self.gamePlayMode.selectedSegmentIndex);
    [self.game chooseCardAtIndex:index];
    Card *card = [self.game cardAtIndex:index];
    [self setImageBackgroundForButtonCardBack:sender withCard:card];
    sender.enabled=YES;
    
    [self updateUI];
}


- (void)updateHistory:(NSAttributedString *)stateString{
    
    [self.saveHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    [self.saveHistory appendAttributedString:stateString];

}

-(void)updateUI{
    //[setStringOfStatus:state];
    NSAttributedString *stateString = [self getStringState];
    [self updateHistory:stateString];
    [self.state setAttributedText:stateString];
    for (UIButton *button in self.cardButtons) {
        Card *card=[self.game cardAtIndex:[self.cardButtons indexOfObject:button]];
        if([self.game.status.chosenCards containsObject:card] || !self.game.status){
            if(card.chosen){
                [self setImageBackgroundForButtonCardFront:button withCard:card];
                if (card.matched) {
                    button.enabled = NO;
                }
            } else {
                [self setImageBackgroundForButtonCardBack:button withCard:card];
                button.enabled=YES;
            }
        }
    }
    self.score.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
}


- (NSAttributedString *)getStringState{
    
    return nil;
}

- (void)setImageBackgroundForButtonCardBack:(UIButton *)button withCard:(Card *)card{
    
}
- (void)setImageBackgroundForButtonCardFront:(UIButton *)button withCard:(Card *)card{
    
}

//- (IBAction)startNewGame:(id)sender {
//    self.game=nil;
//    self.deck=nil;
//
//}

- (void)newGame{
    self.deck=[self createDeck];
    self.game=[self createGame:self.deck count:self.cardButtons.count];
    self.saveHistory=[[NSMutableAttributedString alloc]init];

    [self updateUI];
}


- (IBAction)startNewGame:(id)sender {
    [self newGame];
    
    
}





@end

