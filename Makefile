

cmpl-c: 
	gcc -c -o hello.o hello.c

create-lib:
	ar rcs libhello.a hello.o
