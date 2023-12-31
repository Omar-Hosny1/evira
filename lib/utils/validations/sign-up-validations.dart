String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return 'Age is required';
  }

  // Age should be a valid integer
  try {
    int age = int.parse(value);
    if (age <= 15 || age >= 100) {
      return 'Age should be in between 15 .. 100 Year';
    }
  } catch (e) {
    return 'Invalid age format, must be only nums';
  }

  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  }
  if(value.length > 14){
    return 'The Name Should not Exceed 14 Charachter Length';
  }
  return null;
}

String? validateWeight(String? value) {
  if (value == null || value.isEmpty) {
    return 'Weight is required';
  }

  // Weight should be a valid double
  try {
    double weight = double.parse(value);
    if (weight <= 40 || weight > 140) {
      return 'Weight should be a positive number and between 41..140';
    }
  } catch (e) {
    return 'Invalid weight format, must be only nums';
  }

  return null;
}

String? validateHeight(String? value) {
  if (value == null || value.isEmpty) {
    return 'Height is required';
  }

  // Height should be a valid double
  try {
    double height = double.parse(value);
    if (height <= 0 || height > 250) {
      return 'Height should be a positive number and has to be in between 1..250';
    }
  } catch (e) {
    return 'Invalid height format, must be only nums';
  }

  return null;
}
