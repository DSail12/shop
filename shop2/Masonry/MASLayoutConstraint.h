//
//  MASLayoutConstraint.h
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//

#import "MASUtilities.h"

/** 
 *    When you are debugging or printing the constraints attached to a view this subclass
 *  makes it easier to identify which constraints have been created via Masonry
 */
@interface MASLayoutConstraint : NSLayoutConstraint

/**
 *    a key to associate with this constraint
 */
@property (nonatomic, strong) id mas_key;

@end
