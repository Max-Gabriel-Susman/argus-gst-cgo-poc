package main

/*
#include <stdio.h>

void sayHello() {
    printf("Hello from C!\n");
}
*/
import "C"

func main() {
	C.sayHello()
}
