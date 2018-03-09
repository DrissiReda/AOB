EXEC=proj
FLAGS=-Wall 
OPTS=-O3 -ffast-math
CC=gcc
ex 1.3.5:
	$(CC) $(FLAGS) $(OPTS) ex1.c -o $(EXEC)

