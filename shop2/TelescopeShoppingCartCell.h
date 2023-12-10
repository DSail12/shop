//
//  TelescopeShoppingCartCell.h
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//

#import <UIKit/UIKit.h>
#import "TelescopeShoppingItem.h"

@interface TelescopeShoppingCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemNumber;
@property (weak, nonatomic) IBOutlet UIButton *itemSelect;
@property (nonatomic,weak) TelescopeShoppingItem *item;
@end
