/**
 * 作为全局弹窗组件封装 内容完全由外部slot定义
 *
 */
@Builder function empty(){}
@CustomDialog
export default struct BuiCustomDialog {
  controller?:CustomDialogController
  @BuilderParam slot:()=>void =empty
  build(){
    this.slot()
  }
}