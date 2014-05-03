#!/bin/bash

# source: http://linuxcommand.org/

##### Constants

TITLE="Info $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updatat la $RIGHT_NOW de $USER"
#Temp=($(cat /home/.../TempTara/temp.txt | awk '{print $7}' | grep -o '[-0-9]*'))
#Data=($(cat /home/.../TempTara/temp.txt | awk '{print $6$2$3" "$4}'))

#temp_tara()
#{
#  for f in "${Temp[@]}"; do echo "scale=3; $f/1000" | bc -lqs; done
#}   

#data_tara()
#{
#  for i in "${Data[@]}"; do echo $i; done
#}

##### Functions

lista_valori()
{
	awk '{ print "[\""$6$2$3"-"$4"\","" "$7"]," }' /var/www/Picture/temp.txt | tr -d 't='
}

temp_tara20()
{
    # Find last 20 values for temperature sensor in /home/TempTara/temp.txt and display them

    
        echo "<h2>Ultimele 20 temperaturi de la tara</h2>"
        echo "<pre>"
          cat /var/www/Picture/temp.txt | tail -20
        echo "</pre>"
    

}   # end of temp_tara()

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
    <script type="text/javascript" src="//www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load('visualization', '1', {packages: ['corechart']});
    </script>
    <script type="text/javascript">
      function drawVisualization() {
        // Create and populate the data table.
        var data = google.visualization.arrayToDataTable([
          ['Data', 'Temp'],
          $(lista_valori)
        ]);
      
        // Create and draw the visualization.
        new google.visualization.LineChart(document.getElementById('visualization')).
            draw(data, {curveType: "function",
                        width: 1000, height: 800,
                        vAxis: {maxValue: 40}}
                        //trebuie vazut cate valori am
                );
      }
      

      google.setOnLoadCallback(drawVisualization);
    </script>
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
            <h3 class="text-center">Lista temp</h3>
             <div class="panel panel-default">
              <div class="panel-body">             
			           <p>$(temp_tara20)</p>                      	  
              </div>             
	     </div>          
	 </div>

        </div><!-- /.container-collapse -->
        <br>
	<div class="container">
          <div class="col-md-12">
	   <div class="panel panel-default">
	    <div class="panel-body">	 
		<div id="visualization" style="width: 1000px; height: 800px;"></div>
	     </div>
	    </div>
	  </div> 	
	</div>
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
filename=/var/www/lataratemperatura.html

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
