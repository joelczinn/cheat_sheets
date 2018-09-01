################################################################
# setting variables
################################################################
# see http://www.cyberciti.biz/faq/unix-linux-difference-between-set-and-setenv-c-shell-variable/
# in c shell, apparently set only sets a variable in the current subshell, whereas setenv sets it for all other subshells, as well. that's why things in the ~/.tcshrc should be defined using setenv!

setenv EXAMPLE value

# but in addition, when using multiple paths, have to quote each one in double quotes and string them together with : like so
setenv LD_LIBRARY_PATH "/usr/current/cfitsio/lib:/home/ritchey/zinn.44/packages/geos/lib/":"$LD_LIBRARY_PATH"

