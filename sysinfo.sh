#!/bin/bash

# sysinfo_page - A script to produce a system information HTML file
# source: http://linuxcommand.org/

##### Constants

TITLE="Info $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updatat la $RIGHT_NOW de $USER"

##### Functions

system_info()
{
    # Find any release files in /etc

    if ls /etc/*release 1>/dev/null 2>&1; then
        echo "<h2>System release info</h2>"
        echo "<pre>"
        for i in /etc/*release; do

            # Since we can't be sure of the
            # length of the file, only
            # display the first line.

            head -n 1 $i
        done
        uname -orp
        echo "</pre>"
    fi

}   # end of system_info


acces_tara()
{

   #vezi ultimele 5 logari Ip de la tara

   echo "<h2>Acces IP tara</h2>"
   echo "<pre>"
   cat /var/log/auth.log | grep xx.xx.xx.xx | tail -5
   echo "</pre>"

} # end of acces_tara

show_uptime()
{
    echo "<h2>System uptime</h2>"
    echo "<pre>"
    uptime
    echo "</pre>"

}   # end of show_uptime


drive_space()
{
    echo "<h2>Filesystem space</h2>"
    echo "<pre>"
    df
    echo "</pre>"

}   # end of drive_space


home_space()
{
    echo "<h2>Home directory space by user</h2>"
    echo "<pre>"
    format="%8s%10s%10s   %-s\n"
    printf "$format" "Dirs" "Files" "Blocks" "Directory"
    printf "$format" "----" "-----" "------" "---------"
    if [ $(id -u) = "0" ]; then
        dir_list="/home/*"
    else
        dir_list=$HOME
    fi
    for home_dir in $dir_list; do
        total_dirs=$(find $home_dir -type d | wc -l)
        total_files=$(find $home_dir -type f | wc -l)
        total_blocks=$(du -s $home_dir)
        printf "$format" $total_dirs $total_files $total_blocks
    done
    echo "</pre>"

}   # end of home_space

data()
{
   echo "2013-"$(date +%Y)
}

write_page()
{
    cat <<- _EOF_
<!DOCTYPE html>

<html lang="ro">
  <head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Portal proiecte">
    <meta name="author" content="site.com">
    <link rel="shortcut icon" href="//site.com/favicon.ico" type="image/x-icon"/>

    <title>$TITLE</title>
    
    <!-- Bootstrap core CSS -->
    <link href="../CSS/bootstrap.min.css" rel="stylesheet" media="screen">
    
    <!-- Custom styles for this template -->
    <link href="../CSS/offcanvas.css" rel="stylesheet">
    
  </head>
 
  <body>
	  <div class="container">
		  <div class="navbar navbar-default navbar-fixed-top" role="navigation">
       
          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Meniu</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="//site.com/index.html">Proiecte</a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="//site.com/index.html"><span class="glyphicon glyphicon-asterisk"></span> Acasa</a></li>
              <li><a href="site.com"><span class="glyphicon glyphicon-asterisk"></span>site.com</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-asterisk"></span> Senzori<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#" target="_blank">raport apache</a></li>
		  <li><a href="#">smokeping</a></li>
                  <li><a href="#">temperatura</a></li>
                </ul>
              </li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-asterisk"></span> Utile<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#">owncloud</a></li>
                  <li><a href="#">transmission</a></li>
                  <li><a href="#">etherpad?</a></li>
		              <li><a href="#">wordpress?</a></li>
		              <li><a href="#">photo_gallery?</a></li>
		              <li><a href="#">bittorrentsync?</a></li>
		              <li><a href="#">plex?</a></li>
                </ul>
              </li>
              </ul>
             <ul class="nav navbar-nav navbar-right">
              <li><a href="#"><span class="glyphicon glyphicon-asterisk"></span> Owncloud</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-asterisk"></span> La tara<b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#">Camera web</a></li>
                  <li><a href="#">Temperatura</a></li>
                </ul>
              </li>
            </ul>
            </div>
           </div><!-- /.navbar-collapse -->
	</div><!-- /.container-collapse -->
	
       
        <div class="jumbotron" style="background: none repeat scroll 0% 0% rgb(0, 136, 204);">
         <div class="container text-center">       
	        <h1>site.com</h1>
            <p>*</p>
             <div class="panel panel-default">
              <div class="panel-body"><p>$TIME_STAMP</p></div>
             </div>
	 </div>
       </div>
       
       <div class="container">
          <div class="row">
            <div class="col-md-6">
			  <img class="img-responsive img-rounded" src="images/feat1.jpg">
              <h3 class="text-center">Sys info</h3>
             <div class="panel panel-default">
              <div class="panel-body">             
			  <p>$(system_info)</p>     
                          <p>$(show_uptime)</p>
			  <p>$(acces_tara)</p>		  
             </div>             
			 </div>
             </div>

            <div class="col-md-6">
                        <img class="img-responsive img-rounded" src="images/feat2.jpg">
              <h3 class="text-center">Spatiu disk</h3>
              <div class="panel panel-default">
               <div class="panel-body">  
			  <p>$(drive_space)</p>
			  <p>$(home_space)</p>
			  </div>             
			 </div>
            </div>
          </div>
        </div><!-- /.container-collapse -->
        <br>
        <br>
        <br>
		<div class="navbar navbar-default navbar-fixed-bottom">
        <footer>
		<p>&copy; $(data) site.com</p>
        </footer>
		</div>
 	<script src="//code.jquery.com/jquery.js"></script>
  	<script src="../JS/bootstrap.min.js"></script>
  </body>
</html>

_EOF_

}



usage()
{
    echo "usage: sysinfo_page [[[-f file ] [-i]] | [-h]]"
}


##### Main

interactive=
filename=/var/www/.../index.html

while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           shift
                                filename=$1
                                ;;
        -i | --interactive )    interactive=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done



if [ "$interactive" = "1" ]; then

    response=

    echo -n "Enter name of output file [$filename] > "
    read response
    if [ -n "$response" ]; then
        filename=$response
    fi

    if [ -f $filename ]; then
        echo -n "Output file exists. Overwrite? (y/n) > "
        read response
        if [ "$response" != "y" ]; then
            echo "Exiting program."
            exit 1
        fi
    fi
fi


# Test code to verify command line processing

#if [ "$interactive" = "1" ]; then
#	echo "interactive is on"
#else
#	echo "interactive is off"
#fi
#echo "output file = $filename"


# Write page (comment out until testing is complete)
write_page > $filename
