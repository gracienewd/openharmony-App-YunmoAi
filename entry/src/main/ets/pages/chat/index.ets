import AppColors from '../../common/AppColors'
import { ChatPlaceHolder } from './ChatPlaceHolder'

@Component
export struct ChatComponent {

  aboutToAppear() {

  }

  build() {
    Column(){
      this._navTab()
      Scroll() {
        Column() {
          this._chatPlaceHolder()
          Row()
            .height(180)
        }
      }
    }
    .padding(12)
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D= new CanvasRenderingContext2D(this.settings)

  /**
   * 1.顶部导航栏
   */
  @Builder
  _navTab() {
    Column(){
      Row() {
        Canvas(this.context)
          .onReady(() =>{
            let grad = this.context.createLinearGradient(0, 0, 120,60)
            grad.addColorStop(0.0, '#B99FFF')
            grad.addColorStop(0.4, '#A1F4FF')
            grad.addColorStop(0.9, '#FEFEFE')
            this.context.fillStyle = grad
            this.context.font = '80px sans-serif bold';
            this.context.fillText("AI对话", 0, 40);
          })
          .width(120)
          .height(60)
        Image($r("app.media.yunmoai_log"))
          .height(20)
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({top: 20,bottom: 12})

      Row() {
        Row() {
          Image($r("app.media.ai_application")).width(22).margin({right: 10})
          Text("新建对话")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(0xFFFFFF)
            .onClick((e) => {
            })
        }
        .linearGradient({
          direction: GradientDirection.Right,
          colors: AppColors.gradient
        })
        .padding({
          left: 12,
          right: 12,
          top: 10,
          bottom: 10
        })
        .borderRadius(25)
        .margin({ right: 5 })

        Image($r("app.media.explorer")).width(22)
      }
      .width("100%")
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding({bottom: 20})
  }

  /**
   * 2.默认
   */
  @Builder
  _chatPlaceHolder() {
    ChatPlaceHolder()
  }
}