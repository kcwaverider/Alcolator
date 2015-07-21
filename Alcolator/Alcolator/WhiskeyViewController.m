//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Chad Clayton on 7/13/15.
//  Copyright (c) 2015 Chad Clayton. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = [self whiskeyEquivalent:numberOfBeers];
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains \nas much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %d", (int)self.beerCountSlider.value);
    // NSLog(@"%f", self.beerCountSlider.value);
    [self.beerPercentTextField resignFirstResponder];
    float numberOfShotsForEquivalentAlcoholAmount = [self whiskeyEquivalent:self.beerCountSlider.value];
    
    int whiskeyShotInteger;
    if (numberOfShotsForEquivalentAlcoholAmount - (int) numberOfShotsForEquivalentAlcoholAmount < .5) {
        whiskeyShotInteger = numberOfShotsForEquivalentAlcoholAmount;
    } else {
        whiskeyShotInteger = ceilf(numberOfShotsForEquivalentAlcoholAmount);
    }
    
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", whiskeyShotInteger]];
                                                     

}


- (float)whiskeyEquivalent: (int) numberOfBeers {
    
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;  // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    return numberOfWhiskeyGlassesForEquivalentAlcoholAmount;
}


@end
