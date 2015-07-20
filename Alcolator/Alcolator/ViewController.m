//
//  ViewController.m
//  Alcolator
//
//  Created by Chad Clayton on 7/9/15.
//  Copyright (c) 2015 Chad Clayton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (float)numberOfWineGlassesEquivalent:(int) numberOfBeers;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %d", (int)self.beerCountSlider.value);
   // NSLog(@"%f", self.beerCountSlider.value);
    [self.beerPercentTextField resignFirstResponder];
    float numberOfWineGlassesForEquivalentAlcoholAmount = [self numberOfWineGlassesEquivalent:self.beerCountSlider.value];
    int numberOfWineGlassesInteger;
    if (numberOfWineGlassesForEquivalentAlcoholAmount - (int) numberOfWineGlassesForEquivalentAlcoholAmount < .5) {
        numberOfWineGlassesInteger = numberOfWineGlassesForEquivalentAlcoholAmount;
    } else {
        numberOfWineGlassesInteger = ceilf(numberOfWineGlassesForEquivalentAlcoholAmount);
    }
    NSString *wineText;
    if(numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) numberOfWineGlassesForEquivalentAlcoholAmount]];
}

- (IBAction)buttonPressed:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    
    float numberOfWineGlassesForEquivalentAlcoholAmount = [self numberOfWineGlassesEquivalent:numberOfBeers];
    
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    if(numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // Generate the results and show them on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains \nas much alcohol as %.1f %@ of wine.",nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

- (float)numberOfWineGlassesEquivalent:(int) numberOfBeers {
    // Calculate the alcohol content of all your beers

    int ouncesInOneBeerGlass = 12;
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    //Calculate that alcohol content in wine
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    NSLog(@"Calculating Wine Glasses: %f", numberOfWineGlassesForEquivalentAlcoholAmount);
    
    return numberOfWineGlassesForEquivalentAlcoholAmount;

}

@end








































