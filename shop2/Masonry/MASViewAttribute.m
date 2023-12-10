//
//  MASAttribute.m
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//

#import "MASViewAttribute.h"

@implementation MASViewAttribute

- (id)initWithView:(MAS_VIEW *)view layoutAttribute:(NSLayoutAttribute)layoutAttribute {
    self = [super init];
    if (!self) return nil;
    
    _view = view;
    _layoutAttribute = layoutAttribute;
    
    return self;
}

- (BOOL)isSizeAttribute {
    return self.layoutAttribute == NSLayoutAttributeWidth
        || self.layoutAttribute == NSLayoutAttributeHeight;
}

- (BOOL)isEqual:(MASViewAttribute *)viewAttribute {
    if ([viewAttribute isKindOfClass:self.class]) {
        return self.view == viewAttribute.view
            && self.layoutAttribute == viewAttribute.layoutAttribute;
    }
    return [super isEqual:viewAttribute];
}
(NSUInteger)hash {
   return MAS_NSUINTROTATE([self.view hash], MAS_NSUINT_BIT / 2) ^ self.layoutAttribute;
}

@end
