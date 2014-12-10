//
//  TinderVC.h
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DraggableView.h"
#import "webService.h"

@interface TinderVC : UIViewController<DraggableViewDelegate>

@property NSMutableArray *idCards;
@property (weak, nonatomic) IBOutlet UILabel *titulo;

@property (retain,nonatomic)NSArray* allCards;

- (IBAction)botaoMenu:(id)sender;

//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;



@end
