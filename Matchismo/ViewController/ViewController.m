//
//  ViewController.m
//  Matchismo
//
//  Created by Shira Ozeri on 28/10/2019.
//  Copyright © 2019 Shira Ozeri. All rights reserved.
//

#import "ViewController.h"
#import "CardGame.h"
#import "Deck.h"
#import "Grid.h"
#import "MatchingViewCard.h"
#import "PlayingCardDeck.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UIView *superView;
@property (strong, nonatomic) NSMutableArray *cardsOnBoard;
@property (weak, nonatomic) IBOutlet UIButton *addMoreCard;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) UIView *pile;
@property (weak, nonatomic) IBOutlet UIButton *startNewGAme;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                               name:UIDeviceOrientationDidChangeNotification
                                             object:[UIDevice currentDevice]];
  [self.superView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(pinch:)]];
  [self.superView addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(pan:)]];
  [self newGame];
}

- (Grid *)createGrid {
  Grid *grid = [[Grid alloc]init];
  grid.size = self.superView.bounds.size;
  grid.cellAspectRatio = 0.666;
  grid.minimumNumberOfCells = [self initWithNumberOfCard];
  return grid;
}

- (ViewCard *)createViewCard:(Card *)card atRect:(CGRect )rect {
  return nil;
}

//override
- (NSUInteger) initWithNumberOfCard {
  return 0;
}

- (Deck *)createDeck {
  return nil;
}

- (CardGame *)createGame:(Deck *)deck count:(NSInteger) count {
  return nil;
}

- (NSInteger) numOfMoreCards {
  return 0;
}

- (IBAction)presentMoreCards:(id)sender {
  if ([self.deck countCard] == 0) {
    [self.addMoreCard setTitle:@"No more cards" forState:UIControlStateNormal];
    [self.addMoreCard setEnabled:NO];
    return;
  }
  NSMutableArray *cards = [[NSMutableArray alloc] initWithCapacity:[self numOfMoreCards]];
  for (int i = 0; i < [self numOfMoreCards]; i++) {
    Card *card = [self.game addCard];
    if (card) {
      [cards addObject:card];
    } else {
      [self updateGridWitNewCards:cards];
      [self.addMoreCard setTitle:@"No more cards" forState:UIControlStateNormal];
      [self.addMoreCard setEnabled:NO];
      return;
    }
  }
  [self updateGridWitNewCards:cards];
}

- (void)updateUI:(ViewCard *)cardView {
  for (ViewCard *boardCard in self.cardsOnBoard) {
    Card *card = boardCard.card;
    if (card.chosen) {
      boardCard.faceUp = YES;
    } else {
      boardCard.faceUp = NO;
    }
  }
}

- (void)addCardToExistGrid:(NSArray<Card *> *)cardsToAdd {
  int i = (int)((self.cardsOnBoard.count-1) / self.grid.columnCount);
  int j = (int)((self.cardsOnBoard.count-1) % self.grid.columnCount);
  if (j == self.grid.columnCount-1){
    i++;
    j=0;
  } else {
    j++;
  }
  for (Card *card in cardsToAdd) {
    ViewCard * viewCard = [self CreateNewViewCard:card atI:i j:j];
    [self.cardsOnBoard addObject:viewCard];
    if (j == self.grid.columnCount-1) {
      i++;
      j = 0;
    } else{
      j++;
    }
  }
}

- (void)updateGridWitNewCards:(NSArray<Card *> *)cardsToAdd {
  if(self.cardsOnBoard.count+cardsToAdd.count < self.grid.columnCount*self.grid.rowCount) {
    [self addCardToExistGrid:cardsToAdd];
  } else {
    [self resizeGrid:cardsToAdd];
  }
}

- (void)resizeGrid:(NSArray<Card *> *)cardsToAdd {
  self.grid.minimumNumberOfCells = cardsToAdd.count+self.cardsOnBoard.count;
  int i=0;
  int j=0;
  for (UIView *viewCard in self.cardsOnBoard) {
    viewCard.frame = [self.grid frameOfCellAtRow:i inColumn:j];
    if (j==self.grid.columnCount-1) {
      i++;
      j = 0;
    }else{
      j++;
    }
  }
  for (Card *card in cardsToAdd) {
    ViewCard *viewCard = [self CreateNewViewCard:card atI:i j:j];
    [self.cardsOnBoard addObject:viewCard];
    [self animateBeginFromCurrentState:viewCard
                             fromPoint:self.superView.frame.origin toPoint:viewCard.center];
    if (j == self.grid.columnCount-1){
      i++;
      j = 0;
    } else{
      j++;
    }
  }
}

- (void)animateBeginFromCurrentState:(ViewCard *)cardView
                           fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint {
  CGPoint cardCenter = endPoint;
  cardView.center = startPoint;
  [UIView animateWithDuration:0.5
                        delay:0
                      options:UIViewAnimationOptionOverrideInheritedDuration
                   animations:^{ cardView.center = cardCenter; }
                   completion:nil];
}

- (ViewCard *)CreateNewViewCard:(Card *)card atI:(int)i j:(int)j {
  CGRect cardRect = [self.grid frameOfCellAtRow:i inColumn:j];
  ViewCard *viewCard = [self createViewCard:card atRect:cardRect];
  viewCard.inBoard = YES;
  UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(tapCard:)];
  [viewCard addGestureRecognizer:singleFingerTap];
  [self.superView addSubview:viewCard];
  [self animateBeginFromCurrentState:viewCard fromPoint:self.superView.frame.origin toPoint:viewCard.center];
  viewCard.faceUp=NO;
  return viewCard;
}

- (void)tapCard:(UITapGestureRecognizer *)recognizer {
  if (self.pile) {
    [self cardsFromPileToPlace];
  }else{
    if ([recognizer.view isKindOfClass:[ViewCard class]]) {
      ViewCard *viewCard = (ViewCard *)recognizer.view;
      viewCard.faceUp=!viewCard.faceUp;
      [self flipAnimate:viewCard];
      BOOL match=[self.game chooseCard:viewCard.card];
      if (match) {
        [self removeFromBoard ];
      } else {
        [self updateUI:viewCard];
      }
    }
    self.score.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
  }
}

- (void)cardsFromPileToPlace {
  int i=0;
  int j=0;
  for (UIView *viewCard in self.cardsOnBoard) {
    [viewCard removeFromSuperview];
    [self.superView addSubview:viewCard];
    viewCard.frame = self.pile.frame;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{viewCard.frame=[self.grid frameOfCellAtRow:i inColumn:j];}
                     completion:^(BOOL finished) {}];
    if (j == self.grid.columnCount-1) {
      i++;
      j = 0;
    }else{
      j++;
    }
  }
  [self.pile removeFromSuperview];
  self.pile=nil;
  self.addMoreCard.enabled=YES;
  self.startNewGAme.enabled=YES;
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
  CGPoint gesturePoint = [sender locationInView:self.superView];
  self.pile.frame = CGRectMake(gesturePoint.x, gesturePoint.y, self.grid.cellSize.width,
                               self.grid.cellSize.height);
}

- (void)flipAnimate:(ViewCard *)cardView {
  [UIView transitionWithView:cardView
                    duration:0.8
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{cardView.faceUp=cardView.faceUp;}
                  completion:^(BOOL finished) { }];
  
}

- (void)removeFromBoard {
  NSMutableArray *deleteCards = [[NSMutableArray alloc] init];
  for (ViewCard *viewCard in self.cardsOnBoard) {
    if (viewCard.card.matched) {
      [deleteCards addObject:viewCard];
    }
  }
  for (ViewCard *deleteCard in deleteCards) {
    [UIView animateWithDuration:2.0
                     animations:^(){deleteCard.alpha = 0;}
                     completion:^(BOOL finished) {
      [deleteCard removeFromSuperview];
      [self.cardsOnBoard removeObject:deleteCard];
      deleteCard.inBoard = false;
      [self resizeGrid:[[NSArray alloc]init]];
    }];
  }
}

- (void)initCardsOnBoard {
  _cardsOnBoard = [[NSMutableArray alloc] init];
  int cardIndex = 0;
  for (int i = 0; i < self.grid.rowCount; i++) {
    for (int j = 0; j < self.grid.columnCount; j++) {
      if(cardIndex < [self initWithNumberOfCard] && cardIndex < self.deck.countCard) {
        Card *card = [self.game cardAtIndex:cardIndex];
        ViewCard * viewCard = [self CreateNewViewCard:card atI:i j:j];
        [self.cardsOnBoard addObject:viewCard];
        cardIndex++;
      }else{
        break;
      }
    }
  }
}

- (void)newGame {
  self.deck = [self createDeck];
  self.game = [self createGame:self.deck count: [self initWithNumberOfCard]];
  self.grid = [self createGrid];
  [[self.superView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  if ([self.grid inputsAreValid]) {
    [self initCardsOnBoard];
  }
  self.score.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
}

- (IBAction)startNewGame:(id)sender {
  [self newGame];
}

- (void)viewDidAppear:(BOOL)animated {
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter]
   addObserver:self selector:@selector(orientationChanged)
   name:UIDeviceOrientationDidChangeNotification
   object:[UIDevice currentDevice]];
  [self orientationChanged];
}

- (void)viewWillAppear:(BOOL)animated {
  [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
  [[NSNotificationCenter defaultCenter]
   addObserver:self selector:@selector(orientationChanged)
   name:UIDeviceOrientationDidChangeNotification
   object:[UIDevice currentDevice]];
  [self orientationChanged];
}

- (void)orientationChanged {
  self.grid.size = self.superView.bounds.size;
  if (!self.pile) {
    [self resizeGrid:[[NSArray alloc] init]];
  } else {
    CGRect pileRect = CGRectMake(self.superView.bounds.size.width/2-self.grid.cellSize.width/2,
                                 self.superView.bounds.size.height/2-self.grid.cellSize.height/2,
                                 self.grid.cellSize.width, self.grid.cellSize.height);
    self.pile.frame = pileRect;
  }
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
  if (!self.pile) {
    self.addMoreCard.enabled = NO;
    self.startNewGAme.enabled = NO;
    if (gesture.state == UIGestureRecognizerStateEnded) {
      CGRect pileRect = CGRectMake(self.superView.bounds.size.width/2-self.grid.cellSize.width/2,
                                   self.superView.bounds.size.height/2-self.grid.cellSize.height/2,
                                   self.grid.cellSize.width, self.grid.cellSize.height);
      self.pile = [[UIView alloc]initWithFrame:pileRect];
      [self.superView addSubview:self.pile];
      for (ViewCard *cardView in self.cardsOnBoard) {
        [cardView removeFromSuperview];
        [self.pile addSubview:cardView];
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{cardView.frame = self.pile.bounds;}
                         completion:^(BOOL finished) {
        }];
      }
    }
  }
}

@end

