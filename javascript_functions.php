<SCRIPT TYPE="text/javascript" LANGUAGE="JavaScript">
    
	// Date Display Function
    function displayDate(){
      var this_month = new Array(12);
      this_month[0]  = "January";
      this_month[1]  = "February";
      this_month[2]  = "March";
      this_month[3]  = "April";
      this_month[4]  = "May";
      this_month[5]  = "June";
      this_month[6]  = "July";
      this_month[7]  = "August";
      this_month[8]  = "September";
      this_month[9]  = "October";
      this_month[10] = "November";
      this_month[11] = "December";
      var today = new Date();
      var day   = today.getDate();
      var month = today.getMonth();
      var year  = today.getYear();
      if (year < 1900){
         year += 1900;
      }
      return(day+" "+this_month[month]+" " +year);
    }


</SCRIPT> 


<?php

//function to validate entry in log-in



//function to validate entry in sign-up



//function for main-menu


?>