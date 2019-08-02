#!/bin/sh
# Setup the environment required for Docket

PG_DOCKET_PASSWORD='changeme'

# Where are we? (This permits to execute the script from anywhere, but the
# script itself is to be in the Docket project directory
CWD="$(dirname $0)"
cd $CWD

# Check for the required dependencies
for CMD in rvm gem psql; do
  command -v $CMD > /dev/null
  if [ $? -eq 1 ]; then
    echo "Error: command $CMD not found"
    exit 1
  else
    echo "Command $CMD found"
  fi
done

# From now, abort on errors set -e

# Create a new rvm gemset for docket
echo 'Creating Docket gemset...'
rvm gemset create docket
rvm gemset use docket

# Install the required gems
echo 'Installing required gems -- This may take a while...'
gem install bundle
bundle

# Create a new postgresql role for the application
# Do not create a database for production as it is not needed
# Obviously, this may require your password, as it calls 'sudo'
echo 'Setting up database -- I need your password for Chinese hackers'
sleep 3
echo 'Just joking, I have to change user with sudo (changing to postgres, not root)'
sudo -su postgres << HEREDOC
psql <<- HDTWO
CREATE ROLE docket WITH LOGIN ENCRYPTED PASSWORD '$PG_DOCKET_PASSWORD';
CREATE DATABASE docket_development;
CREATE DATABASE docket_test;
CREATE DATABASE docket_production;
\\q
HDTWO
HEREDOC


# If you are using bash...
#echo $SHELL | grep bash || exit 0

# ...I can do something cool for you!
cat << HEREDOC
All done. I can also create for you a command 'lassi-project' which will setup
the shell environment, making sure you are using the right gemset, and descend
into the Docket directory, if you use bash.
Do you want me to do that? [Y/n] 
HEREDOC

read RES
case $RES in
  'Y'|'y'|'yes'|'Yes'|'YES')
    echo 'Creating new command "lassi-project"'
    cat >> $HOME/.bashrc << HEREDOC

# Prepare the environment for Docket development and use, and descend into the
# project directory
function lassi-project {
  clear
  echo 'Preparing environment for Docket'
  rvm gemset use docket
  echo 'Descending into $CWD'
  cd $CWD
  echo 'Enjoy with Docket!'
}
HEREDOC
    ;;
  *)
    echo 'Did not create new command. Bye!'
    ;;
esac

# We are happy now
exit 0
