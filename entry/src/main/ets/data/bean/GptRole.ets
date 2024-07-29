export class GptRole {
  constructor(roleName:string,id:string, icon:string,roleDirect?:string,summary?: string,greetings?: string) {
    this.roleName = roleName
    this.id = id
    this.icon = icon
    this.roleDirect = roleDirect
    this.summary = summary
    this.greetings = greetings
  }
  public roleName: string;
  public id: string;
  public icon: string;
  public roleDirect?: string;
  public summary?: string;
  public greetings?: string;
}