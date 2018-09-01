################################################################
# hold part of a pattern
################################################################
REGEX1\(REGEX2\) will store REGEX2 part of the pattern in holding to be referenced by \1, \2, etc.

# e.g.:
>>> echo /home/ritchey/zinn.44/kochanek/test/fixed_cadence_p_tau/periodic/all/0.185_39.439 | sed 's/.*\(..[1-9]\{3\}\)\_.*/&\t\1/'
>>> /home/ritchey/zinn.44/kochanek/test/fixed_cadence_p_tau/periodic/all/0.185_39.439	0.185

################################################################
# escaping single quotes!!!!
# use \x27
# e.g.:
zams_name=$(sed -n "s|\(.*zams_name = *\x27\)\(.*\)\(\x27  *\)|\2|p" $init_file)

################################################################
# double quotes
################################################################
sed "s/blah/$var/"

################################################################
# $ and end-of-line character
################################################################
to use $ as end-of-line character, as well:
sed "s/blah\$/$var/"