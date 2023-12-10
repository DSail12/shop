//
//  MASCompositeConstraint.h
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//
 
#import "MASConstraint.h"
#import "MASUtilities.h"

/**
 *    A group of MASConstraint objects
 */
@interface MASCompositeConstraint : MASConstraint

/**
 *    Creates a composite with a predefined array of children
 *
 *    @param    children    child MASConstraints
 *
 *    @return    a composite constraint
 */
- (id)initWithChildren:(NSArray *)children;

@end
