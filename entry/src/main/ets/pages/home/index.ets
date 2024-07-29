import { AiApplicationBean,HomeGptRolesRecommend } from '../../data/bean/AiApplication'
import { GptRole } from '../../data/bean/GptRole';
import  {AiHomeStore} from "../../store/AiHomeStore"
import RouteManager from '../../views/RouteManager';

@Component
export struct HomeComponent {

  aiHomeStore: AiHomeStore = new AiHomeStore();

  aboutToAppear() {
    this._categoryAppList = this.aiHomeStore.defaultAppList
    this.aiHomeStore.init().then((value)=> {
      this._categoryAppList = value;
    });
  }

  /**
   * 1.顶部导航栏
   */
  @Builder
  _navTab() {
    Row() {
      Image($r("app.media.yunmoai_log"))
        .height(20)
      Row() {
        Text("PRO")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(0xFFFFFF)
          .padding({
            left: 10,
            right: 10,
            top: 5,
            bottom: 5
          })
          .backgroundColor($r("app.color.primary_blue"))
          .borderRadius(10)
          .margin({ right: 10 })
          .onClick((e) => {
          })

        Image($r("app.media.setting_white"))
          .margin({
            right: 12,
            bottom: 20,
            top: 20
          })
          .height(24)
      }
    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width("100%").padding({
      left: 12,
      right: 12,
      top: 20
    })
  }

  /**
   * 2.banner
   */
  private swiperController: SwiperController = new SwiperController()

  @Builder
  _banner() {
    Swiper(this.swiperController) {
      Image($r("app.media.banner_baidu_cn")).borderRadius(12)
      Image($r("app.media.banner_ai_draw")).borderRadius(12)
    }
    .height(160)
    .indicator(true)
    .vertical(false)
    .loop(true)
    .indicator(true)
    .padding({
      left: 12,
      right: 12,
    })
  }

  /**
   * 3.通知公告
   */
  @Builder
  _notice() {
    Swiper() {
      Row() {
        Image($r("app.media.announce")).height(20).margin({ right: 8 })
        Text("注册新账户立即赠送5Credits")
          .fontSize(14)
          .fontColor(0xFFFFFF)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }.alignItems(VerticalAlign.Center).width("100%")

      Row() {
        Image($r("app.media.announce")).height(20).margin({ right: 8 })
        Text("邀请好友一起玩转YunMo")
          .fontSize(14)
          .fontColor(0xFFFFFF)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }.alignItems(VerticalAlign.Center).width("100%")
    }
    .height(50)
    .indicator(true)
    .vertical(false)
    .loop(true)
    .indicator(false)
    .padding({
      left: 12,
      right: 12,
      top: 6
    })
  }

  /**
   * AI应用列表
   */
  _aiApplicationList: AiApplicationBean[] = [
    new AiApplicationBean("Chat聊天", "https://image.yunmonitor.com/yunmo-ai/chat_a_1.jpg"),
    new AiApplicationBean("AI创作", "https://image.yunmonitor.com/yunmo-ai/ff_1.png"),
    new AiApplicationBean("Ai角色", "https://image.yunmonitor.com/yunmo-ai/ff_2.png")
  ]

  @Builder
  _aiApplications() {
    Column() {
      Text("AI应用")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(0xFFFFFF)
        .margin({ left: 12, top: 16, bottom: 10 })
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)

    List() {
      ForEach(this._aiApplicationList, (item: AiApplicationBean) => {
        ListItem() {
          Row() {
            Image(item.logo)
              .width(160)
              .height(100)
              .margin(10)
              .borderRadius(15)
          }
          .justifyContent(FlexAlign.Start)
        }
      },)
    }
    .height(100)
    .listDirection(Axis.Horizontal)
  }



  /**
   * 学习 - 文案写作 - 工作效率
   */
  @State _categoryAppList: HomeGptRolesRecommend[] = []

  @Builder
  _categoryApplications(){
    Column(){
      ForEach(this._categoryAppList, (item: HomeGptRolesRecommend) => {
        Column() {
          Text(item.categoryName)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(0xFFFFFF)
            .margin({bottom: 12,top: 20})
          List() {
            ForEach(item.gptRoleRes, (item: GptRole) => {
              if (item.roleName == '-1') {
                ListItem() {
                  Column()
                    .backgroundColor($r("app.color.base_color"))
                    .height(100)
                    .width(160)
                    .borderRadius(15)
                    .justifyContent(FlexAlign.Start)
                    .margin({right: 10})
                }
              } else {
                ListItem() {
                  Column() {
                    RelativeContainer() {
                        Image(item.icon)
                          .width(30)
                          .height(30)
                          .borderRadius(15)
                    }
                    .backgroundColor($r("app.color.circle_color"))
                    .borderRadius(15)
                    .padding(6)
                    .width("auto")
                    .height("auto")
                    .padding(6)

                    Text(item.roleName)
                      .fontSize(15)
                      .fontColor(0xFFFFFF)
                      .fontWeight(FontWeight.Bold)
                      .margin({top: 10})
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Column() {
                      Text(item.summary)
                        .fontSize(13)
                        .fontColor(0xFF8490a1)
                        .maxLines(2)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .textAlign(TextAlign.Start)
                        .margin({top: 25})
                    }.layoutWeight(1).justifyContent(FlexAlign.Start)
                  }
                  .backgroundColor($r("app.color.base_color"))
                  .height(150)
                  .width(160)
                  .borderRadius(15)
                  .justifyContent(FlexAlign.Start)
                  .alignItems(HorizontalAlign.Start)
                  .margin({right: 10})
                  .padding({left: 10, right: 10, top: 12, bottom: 12})
                }
              }
            },)
          }
          .listDirection(Axis.Horizontal)
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      },)
    }
    .margin({ left: 12, top: 16, bottom: 10 })
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column(){
      this._navTab()
      Scroll() {
        Column() {
          this._banner()
          this._notice()
          this._aiApplications()
          this._categoryApplications()
        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
    }
    .margin({bottom: 100})
  }
}

