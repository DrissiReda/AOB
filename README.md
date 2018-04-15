# AOB

School project for optimizing calculations, the example used is a fluid simulator.

## PREREQUESITES

You need
* openjdk-x-jdk switch the x with your version
* swing
* gcc with `openmp` support

## MAKING AND BUILDING

* If your `libgomp.so` is elsewhere you can find it with :

  ```
  find / \( -path /mnt -o -path /media -o -path /home -o -path /tmp -o -path /cache \) -prune -o -name "libgomp.so" 2>/dev/null
  ```


 No need to search for it in tmp mnt media home root unless you have a reason to think it's there (please don't)

* You can build the project with `make`
* then execute it with `make run`
* At runtime we added the `export LD_LIBRARY_PATH` to avoid having to do it each time you open a terminal

## TRYING OUT DIFFERENT OPTIS

Currently our targets are
  * `nopti` for the basic code with no optimizations
  * `pinc` for the pre increment optimization
  * `muldiv` for mul/div switching
  * `inl`  inlining `build_index` and `setBoundry`
  * `omp` openMP integration
  * `fin` all of the above
 You can execute this command in case of repetitive testing for fastest results
 ```
    make clean && make <target> && make run
 ```
Using make with no parameters is going to launch the highest level of optimization

## CURRENT IMPROVEMENTS
* Using openmp which is self explanatory
* Using inline functions because calling functions is more time consuming than copying them
* Using Ofast mostly for `-ftree-vectorize` and `-frename-registers` and `-ffast-math`
* Using `-mavx2` then changing the `c` constant to `1/c` so that we can change division into
multiplication <br>
  because division does not benefit from AVX

## USELESS IMPROVEMENTS
* using a variable to store the `build_index(i,j,grid_size)` then just adding subtracting the needed
  value in order to avoid computing the core value each time had no real performance improvement.
* In `setBoundry` getting the if statement that is independent of the iterations out of the core
  function had no real added value either.
* Dividing the long calculations to avoid mixing add and mul hassles.
* using pre increment instead of post increment (in case gcc doesn't handle that which it most
  probably does)
* unrolling loops even manually is useless because iterations are dependent 
## IMPROVEMENT IDEAS
* Using intel intrinsic fonctions in order to use sse registers (better result than `-mavx2` in theory)
* Verifying whether `build_index` and `setBoundry `functions have room for improvements.
