

# Remove an icon from a quicklaunch bar in Unity

launcher_remove() {

  if [ "$DISTRIB_ID" == "Ubuntu" ]

  then

    if [ "$DISTRIB_RELEASE" == "16.04" ]

    then

      get_launcherctl

      ./launcherctl.py -r -f $1

    else

      # TODO find a way to modify quicklaunch in Ubuntu 18.04

      echo "Could not find a way to configure quicklaunch in a new Unity"

    fi

  else

    echo "Only Ubuntu is supported"

  fi

}



# Remove an icon from a quicklaunch bar in Unity

launcher_add() {

if [ "$DISTRIB_ID" == "Ubuntu" ]

  then

    if [ "$DISTRIB_RELEASE" == "16.04" ]

    then

      get_launcherctl

      ./launcherctl.py -a -f $1

    else

      # TODO find a way to modify quicklaunch in Ubuntu 18.04

      echo "Could not find a way to configure quicklaunch in a new Unity"

    fi

  else

    echo "Only Ubuntu is supported"

  fi

}



# For Unity 16.04 there is a launcherctl utility

get_launcherctl() {

  # Ubuntu Unity manipulations script

  if ! [ -f launcherctl.py ]

  then

    is_installed_git

    #git clone https://github.com/SergKolo/sergrep.git

    is_installed_curl

    curl -L -O https://raw.githubusercontent.com/SergKolo/sergrep/master/launcherctl.py

    chmod a+x launcherctl.py

  fi

}



add_repo_key() {

 if [ "$DISTRIB_ID" == "Ubuntu" ]

  then

    if [ "$DISTRIB_RELEASE" == "16.04" ]

    then

      is_installed_curl

      curl -fsSLk $1 | sudo apt-key add -

    else

      is_installed_wget

      wget -q --no-check-certificate $1 -O- | sudo apt-key add -

    fi

  else

    echo "Only Ubuntu is supported"

  fi

}



is_installed_curl() {

  if [ -z `which curl` ]

  then

    sudo apt-get install curl

  fi

}



is_installed_wget() {

  if [ -z `which wget` ]

  then

    sudo apt-get install wget

  fi

}



is_installed_git() {

  if [ -z `which git` ]

  then

    source ./setup_git.sh

  fi

}
