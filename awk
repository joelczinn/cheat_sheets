################################################################
# do something for every line 
################################################################
BEGIN { count == 0 };
# actions to be performed on every line
{ ACTION }
{ ACTION }
END { ACTIONDONEATEND }
