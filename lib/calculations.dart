double calculateBMI(String height, String weight, int multiplier)  {


  if (height.isNotEmpty && weight.isNotEmpty ) {
    return
      double.parse(weight)/ double.parse(height) / double.parse(height) * multiplier;
  } else {
    return double.parse(weight) / double.parse(height)  * 0.1;
  }
}
