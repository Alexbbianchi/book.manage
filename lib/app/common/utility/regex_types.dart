
enum RegexType{ number }

extension RegexTypeValidator on RegexType{

  bool validate(String input){
    switch(this){
      case RegexType.number:
        return RegExp(r'^[0-9]+$').hasMatch(input);
      default: 
        return false;
    }
  }

}