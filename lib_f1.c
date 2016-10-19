extern int var2;
int good();
int bad1() { return var2 + good(); }