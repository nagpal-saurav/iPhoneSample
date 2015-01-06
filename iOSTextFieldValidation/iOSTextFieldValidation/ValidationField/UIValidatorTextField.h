//
//  UIValidatorTextField.h
//  iOSTextFieldValidation
//
//  Created by Saurav Nagpal on 05/01/15.
//  Copyright (c) 2015 Saurav Nagpal. All rights reserved.
//

typedef enum text_field_validation_type_enum{
    field_validation_email,
    field_validation_url,
}field_validation_type;


#import <UIKit/UIKit.h>

@interface UIValidatorTextField : UITextField

@end
