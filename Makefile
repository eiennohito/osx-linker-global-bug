CC=gcc

%.o: %.c
	$(CC) -c -o $@ $<

lib0.a: lib_var.o
	ar crus $@ $^

lib1.a: lib_var.o lib_f0.o
	ar crus $@ $^

lib2.a: lib_var1.o lib_f1.o
	ar crus $@ $^

main0.bin: main0.o lib0.a
	$(CC) -o $@ $^

main1.bin: main1.o lib1.a
	$(CC) -o $@ $^

main2.bin: main2.o lib2.a
	$(CC) -o $@ $^

binaries: main0.bin main1.bin

all: binaries

clean:
	rm *.bin *.o *.a