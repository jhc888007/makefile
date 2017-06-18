OBJ = main.o test1.o test3.o

out: $(OBJ) #main.o test1.o test3.o
	gcc -o out $(OBJ) #main.o test1.o test3.o
	echo 1

main.o: main.c test1.h test3.h
	gcc -c main.c

test1.o: test1.c test1.h test2.h
	gcc -c test1.c
	touch test1.o  #如果test1.c编译错误，test1.o和test3.o都不会出现，在gcc -c test1.c前面加“-”号才可以实现继续make

test3.o: test3.c test3.h test4.h
	gcc -c test3.c

clean:
	#rm $(OBJ)
	-rm main.o test1.o  #此处最好加“-”号，否则第一步没执行完第二部就不执行了
	-rm test3.o out
