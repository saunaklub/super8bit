// somethings to play around with
(
    (((t * 14) & (t >> 6)) |
    ((t * 5)  & (t >> [3, 7])) |
    ((t * 2)  & (t >> 2)) |
    ((t * 1)  & (t >> 8))
    - 1 & (2 ** 16 - 1))
    / 127-1 * 3
)

( t * 9 & (t >> [3, 5]) | ((t * 5) & (t >> x)) | ((t * 3) & (t >> 10)) ) & module

(t * rate.ceil).bitXor(t >> [bitshiftL, bitshiftR]) & bitMask;

(t * rate.ceil).bitXor(t >> [bitshiftL, bitshiftR]) & bitMask;
