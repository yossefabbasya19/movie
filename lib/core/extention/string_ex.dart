extension StringEx on String{
  get descriptionIsEmpty{
    if(this.isEmpty){
      return "not founded";
    }
    return this;
  }
}