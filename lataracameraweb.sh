#!/bin/bash

# source: http://linuxcommand.org/

##### Constants

TITLE="Info $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updatat la $RIGHT_NOW de $USER"
# varianta veche FILES=($(ls -tr /var/www/Picture/ | tail -21))
FILES=($(find /var/www/Picture/$(date +%Y)/$(date +%h)/ -type f -printf "%p\n" | sort | tail -20 | grep -o -P 'Picture/.{0,50}'))

##### Functions

poze_tara()
{
    # Find last 20 files in /home/Picture/ and display them

    
        echo "<h2>Ultimele 20 poze de la tara</h2>"
        echo "<pre>"
          for f in "${FILES[@]}"; do echo -e "<img class="img-responsive img-rounded" src="//site.com/$f"> \n "; done
        echo "</pre>"
    

}   # end of poze_tara()

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
              <li><a href="//site.com"><span class="glyphicon glyphicon-asterisk"></span>site.com</a></li>
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
          
            <div class="col-md-12">
              <h3 class="text-center">Lista poze </h3>
          <div class="panel panel-default">
              <div class="panel-body">             
                          <p>$(poze_tara)</p>
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
filename=/var/www/lataracameraweb.html

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
