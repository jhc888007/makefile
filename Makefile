# 变量声明方式，会在需要展开时进行展开
# 貌似变量前面加空格是没关系的
OBJECTS=   main.o test1.o test3.o   
# 无论执行make或是make clean，打印出的TESTVAL值都是2
# 所以变量重新赋值会可能产生一些意想不到的问题
TESTVAL=1

.PHONY:out
# 第一个目标名为默认最终目标名
#out:main.o test1.o test3.o
# 等价语句
out1:$(OBJECTS)
	#gcc -o out main.o test1.o test3.o
	# 等价语句
	#gcc -o out $(OBJECTS)
	# 等价语句
	# $@代表所有输出
	gcc -o $@ $(OBJECTS)
	# 等价语句
	# $^代表所有输入
	#gcc -o $@ $^
	@# 在执行过程中会显示每一句话，如果不想显示则加@
	@echo $(TESTVAL)

main.o:main.c test1.h test3.h 
	gcc -c main.c

test1.o:test1.c test1.h test2.h
	gcc -c test1.c
	# 如果test1.c编译错误，即便有touch，test1.o和test3.o都不会出现，在gcc -c test1.c前面加“-”号才可以实现继续make
	#touch test1.o 

test3.o:test3.c test3.h test4.h
	gcc -c test3.c

# %.o代表所有在匹配的.o输出文件
# %.c代表.o相应名称的.c
# 如果除了main.o、test1.o、test2.o还有其他.o文件需要匹配，则使用此条规则
%.o:%.c
	gcc -c $^
	# 等价语句
	# $<代表第一个输入参数
	#gcc -c $<

# 无论执行make或是make clean，打印出的TESTVAL值都是2
# 所以变量重新赋值会可能产生一些意想不到的问题
TESTVAL=2

# wildcard代表通配符展开，如果“OBJS=*.o”就不对了
# 如果变量后面加注释如下，则变量后面多了一个空格，在某些场合会出错
# OBJS=$(wildcard *.o) #
# .PHONY:代表无视依赖性，每次都执行，用在clean上是为了防止有文件名称为clean
.PHONY:clean
clean:
	rm -f main.o test1.o test3.o out
	@echo $(TESTVAL)
	# 等价语句
	#rm -f $(OBJS) out
	# 等价语句
	# 此处要加“-”号，否则第一步没执行完第二步就不执行了
	#-rm -f main.o test1.o 
	#-rm -f test3.o out
	# 等价语句
	#rm -f *.o out
