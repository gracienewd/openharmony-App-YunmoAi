import {GptRole} from "./GptRole"

export  class AiApplicationBean {

  constructor(title:string,logo:string) {
    this.title = title
    this.logo = logo
  }

  public title: string;
  public logo: string;
}

export class CategoryApplication {

  constructor(categoryName:string,id:string, gptRoleRes?:GptRole[]) {
    this.categoryName = categoryName
    this.id = id
    this.gptRoleRes = gptRoleRes
  }

  public categoryName: string;
  public id: string;
  public gptRoleRes ?: GptRole[];
}

export class HomeGptRolesRecommend {
  constructor(categoryId:string,categoryName:string, gptRoleRes: GptRole[]) {
    this.categoryId = categoryId
    this.categoryName = categoryName
    this.gptRoleRes = gptRoleRes
  }

  public categoryId: string;
  public categoryName: string;
  public gptRoleRes: GptRole[];
}