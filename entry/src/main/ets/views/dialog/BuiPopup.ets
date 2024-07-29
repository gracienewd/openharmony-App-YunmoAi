import BuiCustomDialog from './BuiCustomDialog';

@Builder
function empty() {
}

/**
 * 用于代理dialog的打开和关闭
 */
export interface BuiPopupController {
  open: () => void
  close: () => void
}

/**
 * 作为所有弹窗类的基础组件
 * 以此为拓展,可以 开发 选择城市 选择商户 选择商品 或者 confirm dialog 等  等弹窗
 */
@Component
export default struct BuiPopup {
  controller: BuiPopupController | null = null
  /**
   * 弹窗位置
   */
  alignment: DialogAlignment = DialogAlignment.Bottom;
  /**
   * 上下 偏移量 负数则往上
   */
  offsetY: number = 0
  /**
   * 点击遮罩层是否关闭弹窗
   */
  clickMaskClose: boolean = true
  maskColor: ResourceColor = "rgba(0,0,0,0.1)"
  /**
   * 最大高度
   */
  maxHeight: Length = 800
  @BuilderParam slot: () => void = empty
  private dialogController ?: CustomDialogController

  build() {

  }

  @Builder
  buildContent() {
    Column() {
      this.slot();
    }.width('100%').zIndex(1)
    .constraintSize({ maxHeight: this.getMaxHeight() })
  }

  aboutToAppear() {
    //修正,这里要在这里初始化,否则 this.clickMaskClose 不能响应外部变更
    this.dialogController = new CustomDialogController({
      builder: BuiCustomDialog({
        slot: () => {
          this.buildContent();
        }
      }),
      alignment: this.alignment,
      offset: { dx: 0, dy: this.offsetY },
      maskColor: this.maskColor,
      autoCancel: this.clickMaskClose,
      //完全依靠外部样式控制,否则会有宽度限制和默认圆角, 这里需要的就是要自己控制样式
      customStyle: true
    });
    if (this.controller) {
      this.controller.open = () => {
        this.dialogController?.open();
      }
      this.controller.close = () => {
        this.dialogController?.close();
      }

    }
  }

  getMaxHeight(): Length {
    return this.maxHeight || '100%';
  }
}