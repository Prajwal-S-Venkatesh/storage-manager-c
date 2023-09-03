# Set the compiler and compiler flags
CC = gcc
# -g adds debugging information to the executable file while -Wall enables all the warnings
CFLAGS  = -g -Wall

# The build target executable:
all: test

# To create the executable file
test: test_assign1_1.o storage_mgr.o dberror.o 
	$(CC) $(CFLAGS) -o test_assign1 test_assign1_1.o storage_mgr.o dberror.o -lm

# To create the object file
test_assign1_1.o: test_assign1_1.c dberror.h storage_mgr.h test_helper.h
	$(CC) $(CFLAGS) -c test_assign1_1.c -lm

# To create the object file
storage_mgr.o: storage_mgr.c storage_mgr.h 
	$(CC) $(CFLAGS) -c storage_mgr.c -lm

# To create the object file
dberror.o: dberror.c dberror.h 
	$(CC) $(CFLAGS) -c dberror.c

# To remove generated files
clean: 
	$(RM) test *.o *~ test_assign1 *.bin

# Run the test
run_test:
	./test_assign1