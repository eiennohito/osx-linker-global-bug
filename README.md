This is a repo that demonstrates Mac OS X `ld` bug.

It seems that `ld` uses only **text** (T, function) entries from static library symbol tables
when resolving what .o files. 
It ignores **common** (C, global variables) entries completely.

`make main0.bin` and `make main1.bin` should fail.

```
% make main0.bin                                                                                                (master✱)
gcc -c -o main0.o main0.c
ar crus lib0.a lib_var.o
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib: warning for library: lib0.a the table of contents is empty (no object file members in the library define global symbols)
gcc -o main0.bin main0.o lib0.a
Undefined symbols for architecture x86_64:
  "_var1", referenced from:
      _main in main0.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [main0.bin] Error 1
```

```
% make main1.bin                                                                                                (master✱)
gcc -o main1.bin main1.o lib1.a
Undefined symbols for architecture x86_64:
  "_var1", referenced from:
      _bad in lib1.a(lib_f0.o)
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [main1.bin] Error 1
```

`make main2.bin` should not fail.

```
% make main2.bin                                                                                                (master✱)
gcc -c -o main2.o main2.c
gcc -c -o lib_var1.o lib_var1.c
gcc -c -o lib_f1.o lib_f1.c
ar crus lib2.a lib_var1.o lib_f1.o
gcc -o main2.bin main2.o lib2.a
```