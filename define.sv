#define log2(VALUE) \
   ((VALUE) <= 1        ?  0 : (VALUE) <= 2        ?  1 : (VALUE) <= 4        ?  2 : (VALUE) <= 8        ?  3 : (VALUE) <= 16        ?  4 : \
    (VALUE) <= 32       ?  5 : (VALUE) <= 64       ?  6 : (VALUE) <= 128      ?  7 : (VALUE) <= 256      ?  8 : (VALUE) <= 512       ?  9 : \
    (VALUE) <= 1024     ? 10 : (VALUE) <= 2048     ? 11 : (VALUE) <= 4096     ? 12 : (VALUE) <= 8192     ? 13 : (VALUE) <= 16384     ? 14 : \
    (VALUE) <= 32768    ? 15 : (VALUE) <= 65536    ? 16 : (VALUE) <= 131072   ? 17 : (VALUE) <= 262144   ? 18 : (VALUE) <= 524288    ? 19 : \
    (VALUE) <= 1048576  ? 20 : (VALUE) <= 2097152  ? 21 : (VALUE) <= 4194304  ? 22 : (VALUE) <= 8388608  ? 23 : (VALUE) <= 16777216  ? 24 : 25)
    