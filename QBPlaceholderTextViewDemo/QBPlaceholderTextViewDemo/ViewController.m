//
//  ViewController.m
//  QBPlaceholderTextViewDemo
//
//  Created by Tanaka Katsuma on 2013/12/12.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "ViewController.h"

// QBPlaceholderTextView
#import "QBPlaceholderTextView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet QBPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set placeholder
    self.textView.placeholder = @"Input text here.";
    
    // Register notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}


#pragma mark - Notifications

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomMargin.constant = self.view.frame.size.height - keyboardRect.origin.y;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}


#pragma mark - Actions

- (void)closeKeyboard
{
    [self.textView resignFirstResponder];
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeKeyboard)];
    [self.navigationItem setRightBarButtonItem:doneButton animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

@end
