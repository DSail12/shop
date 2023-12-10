//
//  TelescopeShoppingCartCell.m
//  shop2
//
//  Created by Eugene Zvyagin on 10.12.2023.
//

#import "TelescopeShoppingCartCell.h"
#import "TelescopeShoppingCart.h"


@interface TelescopeShoppingCartCell ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *itemNumberText;
@property (weak, nonatomic) IBOutlet UIButton *itemAdd;
@property (weak, nonatomic) IBOutlet UIButton *itemRemove;

@end

@implementation TelescopeShoppingCartCell

- (void)awakeFromNib {
    // Код инициализации
    self.itemNumberText.delegate = self;
    // Добавть уведомление
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editting) name:@"editting" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitEditting) name:@"endEditting" object:nil];
    }

    /**
     * Войти в режим редактирования
     */
    - (void)editting
{
    NSLog(@"Войти в состояние редактирования");
    
    self.itemNumber.hidden = YES;
    
    self.itemAdd.hidden = NO;
    self.itemRemove.hidden = NO;
    self.itemNumberText.hidden = NO;
    
    self.itemNumberText.text = self.itemNumber.text;
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(50, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.itemSelect.transform = trans;
        self.itemTitle.transform = trans;
    }];
}

/**
 * Выйти из режима редактирования
 */
- (void)exitEditting
{
    NSLog(@"Выйти из статуса редактирования");
    
    self.itemNumber.hidden = NO;
    
    self.itemAdd.hidden = YES;
    self.itemRemove.hidden = YES;
    self.itemNumberText.hidden = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.itemSelect.transform = CGAffineTransformIdentity;
        self.itemTitle.transform = CGAffineTransformIdentity;
    }];
}

//Если редактирование завершиться и не введете никаких данных будет возвращено предыдущее количество

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        textField.text = self.itemNumber.text;
    }
}

- (void)setItem:(TelescopeShoppingItem *)item
{
    _item = item;
        self.itemNumber.text = [NSString stringWithFormat:@"%ld",item.number];
        self.itemTitle.text = item.itemName;
        //根据item初始化selected
        self.itemSelect.selected = self.item.canDelete;
    }

    #pragma mark - 按钮事件

    - (IBAction)selectBtnClick:(id)sender {
        
        self.itemSelect.selected = !self.itemSelect.selected;
        if (self.itemSelect.selected) {
            self.item.canDelete = YES;
        }else{
            self.item.canDelete = NO;
        }
        
    }

    /**
     * 增加商品数量
     */
- (IBAction)addItem:(id)sender {
    NSInteger num;
    if (self.itemNumberText.text.length!=0) {
           num = [self.itemNumberText.text integerValue];
       }else{
           num = self.itemNumber.text.integerValue;
       }
       num++;
       self.item.number++;
       self.itemNumberText.text = [NSString stringWithFormat:@"%ld",num];
       self.itemNumber.text = self.itemNumberText.text;
   }

   /**
    * 减少商品数量
    */
   - (IBAction)removeItem:(id)sender {
       NSInteger num;
       if (self.itemNumberText.text.length!=0) {
           num = [self.itemNumberText.text integerValue];
       }else{
           num = self.itemNumber.text.integerValue;
       }
       if (num<=0) {
           num = 0;
           self.item.number = 0;
       }else{
           num--;
           self.item.number--;
       }
       if (num == 0) {
           self.itemSelect.selected = YES;
           self.item.canDelete = YES;
       }
          self.itemNumberText.text = [NSString stringWithFormat:@"%ld",num];
          self.itemNumber.text = self.itemNumberText.text;
      }

      #pragma mark - dealloc
      - (void)dealloc
      {
          
          [[NSNotificationCenter defaultCenter] removeObserver:self];
      }

      @end
