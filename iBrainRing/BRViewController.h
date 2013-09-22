//
//  BRViewController.h
//  iBrainRing
//
//  Created by Sergey Dunets on 21.09.13.
//  Copyright (c) 2013 Sergey Dunets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)buttonPressed:(id)sender;

@end
