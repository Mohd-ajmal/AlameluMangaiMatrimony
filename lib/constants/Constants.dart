// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Constants {
  static List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Select"), value: "Select"),
      const DropdownMenuItem(child: Text("18"), value: "18"),
      const DropdownMenuItem(child: Text("19"), value: "19"),
      const DropdownMenuItem(child: Text("20"), value: "20"),
      const DropdownMenuItem(child: Text("21"), value: "21"),
      const DropdownMenuItem(child: Text("22"), value: "22"),
      const DropdownMenuItem(child: Text("23"), value: "23"),
      const DropdownMenuItem(child: Text("24"), value: "24"),
      const DropdownMenuItem(child: Text("25"), value: "25"),
      const DropdownMenuItem(child: Text("26"), value: "26"),
      const DropdownMenuItem(child: Text("27"), value: "27"),
      const DropdownMenuItem(child: Text("28"), value: "28"),
      const DropdownMenuItem(child: Text("29"), value: "29"),
      const DropdownMenuItem(child: Text("30"), value: "30"),
      const DropdownMenuItem(child: Text("31"), value: "31"),
      const DropdownMenuItem(child: Text("32"), value: "32"),
      const DropdownMenuItem(child: Text("33"), value: "33"),
      const DropdownMenuItem(child: Text("34"), value: "34"),
      const DropdownMenuItem(child: Text("35"), value: "35"),
      const DropdownMenuItem(child: Text("36"), value: "36"),
      const DropdownMenuItem(child: Text("37"), value: "37"),
      const DropdownMenuItem(child: Text("38"), value: "38"),
      const DropdownMenuItem(child: Text("39"), value: "39"),
      const DropdownMenuItem(child: Text("40"), value: "40"),
      const DropdownMenuItem(child: Text("41"), value: "41"),
      const DropdownMenuItem(child: Text("42"), value: "42"),
      const DropdownMenuItem(child: Text("43"), value: "43"),
      const DropdownMenuItem(child: Text("44"), value: "44"),
      const DropdownMenuItem(child: Text("45"), value: "45"),
      const DropdownMenuItem(child: Text("46"), value: "46"),
      const DropdownMenuItem(child: Text("47"), value: "47"),
      const DropdownMenuItem(child: Text("48"), value: "48"),
      const DropdownMenuItem(child: Text("49"), value: "49"),
      const DropdownMenuItem(child: Text("50"), value: "50"),
      const DropdownMenuItem(child: Text("51"), value: "51"),
      const DropdownMenuItem(child: Text("52"), value: "52"),
      const DropdownMenuItem(child: Text("53"), value: "53"),
      const DropdownMenuItem(child: Text("54"), value: "54"),
      const DropdownMenuItem(child: Text("55"), value: "55"),
      const DropdownMenuItem(child: Text("56"), value: "56"),
      const DropdownMenuItem(child: Text("57"), value: "57"),
      const DropdownMenuItem(child: Text("58"), value: "58"),
      const DropdownMenuItem(child: Text("59"), value: "59"),
      const DropdownMenuItem(child: Text("60"), value: "60"),
      const DropdownMenuItem(child: Text("61"), value: "61"),
      const DropdownMenuItem(child: Text("62"), value: "62"),
      const DropdownMenuItem(child: Text("63"), value: "63"),
      const DropdownMenuItem(child: Text("64"), value: "64"),
    ];
    return menuItems;
  }

  static List<DropdownMenuItem<String>> get numbers {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("1"), value: "1"),
      const DropdownMenuItem(child: Text("2"), value: "2"),
      const DropdownMenuItem(child: Text("3"), value: "3"),
      const DropdownMenuItem(child: Text("4"), value: "4"),
      const DropdownMenuItem(child: Text("5"), value: "5"),
      const DropdownMenuItem(child: Text("6"), value: "6"),
      const DropdownMenuItem(child: Text("7"), value: "7"),
      const DropdownMenuItem(child: Text("8"), value: "8"),
      const DropdownMenuItem(child: Text("9"), value: "9"),
      const DropdownMenuItem(child: Text("0"), value: "0"),
    ];
    return menuItems;
  }

  static List<DropdownMenuItem<String>> get heightDropdown {
    List<DropdownMenuItem<String>> heightItems = [
      const DropdownMenuItem(child: Text("Select"), value: "Select"),
      const DropdownMenuItem(child: Text("5ft 1in"), value: "5ft 1in"),
      const DropdownMenuItem(child: Text("5ft 2in"), value: "5ft 2in"),
      const DropdownMenuItem(child: Text("5ft 3in"), value: "5ft 3in"),
      const DropdownMenuItem(child: Text("5ft 4in"), value: "5ft 4in"),
      const DropdownMenuItem(child: Text("5ft 5in"), value: "5ft 5in"),
      const DropdownMenuItem(child: Text("5ft 6in"), value: "5ft 6in"),
      const DropdownMenuItem(child: Text("5ft 7in"), value: "5ft 7in"),
      const DropdownMenuItem(child: Text("Above 6ft"), value: "Above 6ft"),
    ];
    return heightItems;
  }

  static List<DropdownMenuItem<String>> get maritalStatusDropdown {
    List<DropdownMenuItem<String>> maritalItems = [
      const DropdownMenuItem(child: Text("Single"), value: "Single"),
      const DropdownMenuItem(child: Text("Divorced"), value: "Divorced"),
    ];
    return maritalItems;
  }

  static List<DropdownMenuItem<String>> get disabilityDropdown {
    List<DropdownMenuItem<String>> maritalItems = [
      const DropdownMenuItem(child: Text("Yes"), value: "1"),
      const DropdownMenuItem(child: Text("No"), value: "0"),
    ];
    return maritalItems;
  }

  static List<DropdownMenuItem<String>> get countryDropdown {
    List<DropdownMenuItem<String>> countryItems = [
      const DropdownMenuItem(child: Text("Select"), value: "Select"),
      const DropdownMenuItem(child: Text("India"), value: "India"),
      const DropdownMenuItem(child: Text("France"), value: "France"),
      const DropdownMenuItem(child: Text("London"), value: "London"),
    ];
    return countryItems;
  }

  static List<DropdownMenuItem<String>> get stateCityDropdown {
    List<DropdownMenuItem<String>> stateCityItems = [
      const DropdownMenuItem(child: Text("Select"), value: "Select"),
      const DropdownMenuItem(child: Text("Puducherry"), value: "Puducherry"),
      const DropdownMenuItem(child: Text("TamilNadu"), value: "TamilNadu"),
      const DropdownMenuItem(child: Text("Kerala"), value: "Kerala"),
      const DropdownMenuItem(child: Text("Karnataka"), value: "Karnataka"),
    ];
    return stateCityItems;
  }

  static List<DropdownMenuItem<String>> get educationDropdown {
    List<DropdownMenuItem<String>> educationItems = [
      const DropdownMenuItem(child: Text("Select"), value: "Select"),
      const DropdownMenuItem(child: Text("Bca"), value: "Bca"),
      const DropdownMenuItem(child: Text("Mca"), value: "Mca"),
      const DropdownMenuItem(child: Text("Bba"), value: "Bba"),
      const DropdownMenuItem(child: Text("Mba"), value: "Mba"),
    ];
    return educationItems;
  }

  static List<DropdownMenuItem<String>> get genderDropdown {
    List<DropdownMenuItem<String>> educationItems = [
      const DropdownMenuItem(child: Text("Select"), value: "Select"),
      const DropdownMenuItem(child: Text("Male"), value: "Male"),
      const DropdownMenuItem(child: Text("Female"), value: "Female"),
    ];
    return educationItems;
  }

  static List<DropdownMenuItem<String>> get proffesionDropdown {
    List<DropdownMenuItem<String>> proffesionItems = [
      const DropdownMenuItem(child: Text("Select"), value: "Select"),
      const DropdownMenuItem(
          child: Text("Web Developer"), value: "Web Developer"),
      const DropdownMenuItem(
          child: Text("Mobile Developer"), value: "Mobile Developer"),
      const DropdownMenuItem(
          child: Text("Backend Developer"), value: "Backend Develope"),
      const DropdownMenuItem(child: Text("Full Stack"), value: "Full Stack"),
    ];
    return proffesionItems;
  }
}
