#include "main.h"

void print_welcome_message(void) {
  printf("Welcome to the CI/CD Test Project!\n");
  printf("This project demonstrates automated building and testing.\n");
}

int add_numbers(int a, int b) { return a + b; }

int main(void) {
  print_welcome_message();

  int result = add_numbers(5, 3);
  printf("5 + 3 = %d\n", result);

  printf("Build successful! CI/CD pipeline working.\n");
  return 0;
}