EXAMPLE = ./inp


compile:
	gcc -c main.c
	gcc -c findsq.s
	gcc -no-pie -o out main.o findsq.o
run:
	gcc -c main.c
	gcc -c findsq.s
	gcc -no-pie -o out main.o findsq.o
	./out

test:
	@echo "Input:"
	@cat ${EXAMPLE}
	@echo "\nOutput:"
	@cat  ${EXAMPLE}  | ./out
