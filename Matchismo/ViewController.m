//
//  ViewController.m
//  Matchismo
//
//  Created by Shira Ozeri on 28/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *score;
//@property (weak, nonatomic) IBOutlet UIButton *matchingNewGame;
@property (weak, nonatomic) IBOutlet UIButton *matchingNewGame;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayMode;
@property (weak, nonatomic) IBOutlet UITextField *state;


@end

@implementation ViewController

#define START_GAMPE_PLAY_MODE 2;

- (instancetype)initWithCoder:(NSCoder *)coder {
    if ([super initWithCoder:coder]) {
        self.deck=[[PlayingCardDeck alloc]init];
        // self.game=[[CardMatchingGame alloc] initWithCardCount:12 usingDeck:self.deck];
    }
    
    return self;
}


//-(CardMatchingGame *)game{
//    if(!_game) _game=[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
//    return _game;
//
//}
//
//
//-(Deck *)deck{
//    if(!_deck) _deck=[[PlayingCardDeck alloc]init];
//
//    return _deck;
//}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.game=[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
    self.game.gamePlayMode=START_GAMPE_PLAY_MODE;

    // Do any additional setup after loading the view.
}




- (IBAction)touchCardButton:(UIButton *)sender {
    
    if(self.gamePlayMode.isEnabled) (self.gamePlayMode.userInteractionEnabled=NO);
    
    
    NSUInteger index=[self.cardButtons indexOfObject:sender];
    //NSLog(@"button: %ld",self.gamePlayMode.selectedSegmentIndex);
    [self.game chooseCardAtIndex:index];
    [self updateUI];
    
    
    
}

-(void)updateUI{
    [self.state setText:self.game.state];
    for (UIButton *button in self.cardButtons) {
        Card *card=[self.game cardAtIndex:[self.cardButtons indexOfObject:button]];
        if(card.chosen){
            [button setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:(UIControlStateNormal)];
            [button setTitle:[card contents] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            if(card.matched) button.enabled=NO;
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:(UIControlStateNormal)];
            [button setTitle:@"" forState:UIControlStateNormal];
            button.enabled=YES;

        }
        
        
    }
    self.score.text=[NSString stringWithFormat:@"Score: %ld",self.game.score];
}

//- (IBAction)startNewGame:(id)sender {
//    self.game=nil;
//    self.deck=nil;
//
//}
- (IBAction)startNewGame:(id)sender {
    //self.game=nil;
    //self.deck=nil;
    self.deck=[[PlayingCardDeck alloc]init];
    self.game=[[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:self.deck];
    self.gamePlayMode.userInteractionEnabled=YES;
    self.game.gamePlayMode=self.gamePlayMode.selectedSegmentIndex+2;
    //[self.game.state setText:@"State: New Game"];
    self.game.state=@"State: New Game";
    [self updateUI];
    
    
}


- (IBAction)changeGamePlayMode:(id)sender {
    self.game.gamePlayMode=self.gamePlayMode.selectedSegmentIndex+2;
}



@end

