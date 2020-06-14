# Store and restore window positions

## Usage
/home/dosmanak/scripts/wmsavior.sh <save|restore>

## Configuration
You can fine tune the wmsavior for your desktop environment using the variables
`X_OFFSET` and `Y_OFFSET` in you .bashrc.
If variables are not set, the defaults set in the script itself are used.

You can fine tune the DE using the procedure redefining
the variables for the single run e.g.
```
X_OFFSET=-1 Y_OFFSET=26 ./wmsavior save && ./wmsavior restore
```
If your windows move, you must change the values and if the windows won't move
after restore, you can export them in ~/.bashrc using
```
export Y_OFFSET=26
export X_OFFSET=-1
```
