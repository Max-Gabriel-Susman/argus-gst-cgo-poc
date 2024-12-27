

cmpl-c: 
	gcc -c -o pipeline.o pipeline.c

create-lib:
	ar rcs libpipeline.a pipeline.o

clean: 
	rm pipeline.o libpipeline.a