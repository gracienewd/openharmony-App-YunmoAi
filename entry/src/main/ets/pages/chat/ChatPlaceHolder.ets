@Component
export struct ChatPlaceHolder {
  list: Array<[
    ResourceStr,
    string,
    string,
  ]> = [
    [$r("app.media.sun"), "请帮我查询今日前十热门话题", "如何写一段敬酒词"],
    [$r("app.media.cloud"), "写一篇感人的童年往事", "推荐一部爱情高分电影电影"],
    [$r("app.media.flash"), "帮我预测一下今日星运", "如何处理于上级的关系"],
  ];

  build() {
    Column() {
      Text("您好，在这可以")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(0xFFFFFF)
        .margin({ top: 10 })

      Text("询问任何感兴趣的话题")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(0xFFFFFF)
        .margin({ top: 5 })

      Text("开启您的AI之旅")
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(0xFF8F9193)
        .margin({ top: 5 })

      ForEach(this.list, (item: [
        ResourceStr,
        string,
        string,
      ]) => {
        Column() {
          Image(item[0]).width(30)
          Row() {
            Row()
              .width(10)
              .height(10)
              .borderRadius(10)
              .backgroundColor(0xFF9C5BD2)

            Text(item[1])
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(0xFFFFFF)
              .margin({ left: 5 })
          }
          .backgroundColor(0xFF1B1C1E)
          .borderRadius(25)
          .padding({left: 15,right: 15, top: 3, bottom: 3})
          .margin({top: 20})

          Row() {
            Row()
              .width(10)
              .height(10)
              .borderRadius(10)
              .backgroundColor(0xFF9C5BD2)

            Text(item[2])
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(0xFFFFFF)
              .margin({ left: 5 })
          }
          .backgroundColor(0xFF1B1C1E)
          .borderRadius(25)
          .padding({left: 15,right: 15, top: 3, bottom: 3})
          .margin({top: 20})
        }
        .margin({ top: 40 })
      })
    }
  }
}