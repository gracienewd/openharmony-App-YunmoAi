export class StringUtils{
  static isEmpty(obj ?:string) {
    if (obj == null || obj == undefined || obj.length < 1) {
      return true;
    }
    return false;
  }
}