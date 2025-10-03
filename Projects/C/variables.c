#include <stdio.h> // stdio is a library for in and output
#include <stdbool.h> // for working with boolions

int main() {
    
    char grade = 'C';
    char symbol = '?';
    char currency = '$';

    char name[] = "Henry Brewer"; // this is an array, in c there are no strings
    char food[] = "pizza";
    char email[] = "Brewer123@Teleram.com";
    
    bool awake = true; // a boolion is either true or false

    printf("My grade is %c \n", grade);
    printf("Have you had a nice evening%c \n", symbol);
    printf("In the USA, they use %c \n", currency);

    printf("Hello dear %s \n", name);
    printf("Your favourite food is %s \n", food);
    printf("Your email addres is %s, right? \n", email);

    printf("%d \n", awake);

    if(awake){
        printf("You are awake");
    }
    else {
        printf("Your are asleep");
    };

    //Numbers for here on
    
    int age = 14; //integure for numbers without decimals
    int year = 2025;
    int quantity = 5;

    float gpa = 2.8; //float for decimal numbers
    float price = 29.99;
    float temp = 25.75;

    double pi = 3.14159265358979; //double can store 15 to 16 digits after the dicimal
    double e = 2.7182818284590;

    printf("I am %d years old \n", age); //%d for using a intagure variable
    printf("And the current year is %d \n", year);
    printf("I have baught %d x items \n", quantity);
    
    printf("And my current years gpa is %.1f \n", gpa); // %f for a float variable
    printf("The price you payed was $%.2f \n", price); // %.xf for the number of decimals
    printf("The current tempature in your region is %.2f°C \n", temp );

    printf("Btw. did you know pi? here it is: %.14lf \n", pi);
    printf("Also, did you know e? here it is: %.13lf", e);
    
    return 0;
}