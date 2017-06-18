out: main.o test1.o test3.o
	gcc -o out main.o test1.o test3.o
	echo 1

main.o: main.c test1.h test3.h
	gcc -c main.c

test1.o: test1.c test1.h test2.h
	gcc -c test1.c

test3.o: test3.c test3.h test4.h
	gcc -c test3.c

clean:
	rm main.o test1.o test3.o out
