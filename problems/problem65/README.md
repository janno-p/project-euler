# Problem 65 #

The square root of 2 can be written as an infinite continued fraction.

<div style="margin-left: 20px;">
<math><mrow><msqrt><mrow><mn>2</mn></mrow></msqrt><mo>=</mo>
<mn>1</mn><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn><mo>+</mo>
<mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn><mo>+</mo><mfrac><mrow><mn>1</mn>
</mrow><mrow><mn>2</mn><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn>
<mo>+</mo><mn>...</mn></mrow></mfrac></mrow></mfrac></mrow></mfrac></mrow>
</mfrac></mrow></math>
</div>

The infinite continued fraction can be written, &radic;2 = [1;(2)], (2)
indicates that 2 repeats *ad infinitum*. In a similar way,
&radic;23 = [4;(1,3,1,8)].

It turns out that the sequence of partial values of continued fractions for
square roots provide the best rational approximations. Let us consider the
convergents for &radic;2.

<div style="margin-left: 20px;">
<math><mrow><mn>1</mn><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn>
</mrow></mfrac><mo>=</mo><mfrac><mrow><mn>3</mn></mrow><mrow><mn>2</mn></mrow>
</mfrac></mrow></math>
<br />
<math><mrow><mn>1</mn><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn>
<mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn></mrow></mfrac></mrow>
</mfrac><mo>=</mo><mfrac><mrow><mn>7</mn></mrow><mrow><mn>5</mn></mrow></mfrac>
</mrow></math>
<br />
<math><mrow><mn>1</mn><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn>
<mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn><mo>+</mo><mfrac><mrow>
<mn>1</mn></mrow><mrow><mn>2</mn></mrow></mfrac></mrow></mfrac></mrow></mfrac>
<mo>=</mo><mfrac><mrow><mn>17</mn></mrow><mrow><mn>12</mn></mrow></mfrac></mrow>
</math>
<br />
<math><mrow><mn>1</mn><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn>
<mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow><mn>2</mn><mo>+</mo><mfrac><mrow>
<mn>1</mn></mrow><mrow><mn>2</mn><mo>+</mo><mfrac><mrow><mn>1</mn></mrow><mrow>
<mn>2</mn></mrow></mfrac></mrow></mfrac></mrow></mfrac></mrow></mfrac></mrow>
</mfrac><mo>=</mo><mfrac><mrow><mn>41</mn></mrow><mrow><mn>29</mn></mrow>
</mfrac></mrow></math>
</div>

Hence the sequence of the first ten convergents for &radic;2 are:

    1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378, ...

What is most surprising is that the important mathematical constant,
*e* = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2*k*,1, ...].

The first ten terms in the sequence of convergents for *e* are:

    2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...

The sum of digits in the numerator of the 10<sup>th</sup> convergent is
1+4+5+7=17.

Find the sum of digits in the numerator of the 100<sup>th</sup> convergent of
the continued fraction for *e*.
