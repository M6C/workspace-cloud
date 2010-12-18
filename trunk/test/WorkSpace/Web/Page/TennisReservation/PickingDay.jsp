<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Picking Day</title>
<style type="text/css"> 
@import "/WorkSpace/Web/Page/TennisReservation/css/jquery.datepick.css";
@import "/WorkSpace/Web/Page/TennisReservation/css/PickingDay.css";
</style> 
<script type="text/javascript" src="/WorkSpace/Web/Page/TennisReservation/js/jquery-1.3.2.js"></script> 
<script type="text/javascript" src="/WorkSpace/Web/Page/TennisReservation/js/jquery.datepick.js"></script> 
<script type="text/javascript"> 
$(function() {
//	$.datepick.setDefaults({useThemeRoller: true});
	$('#popupDatepicker').datepick();
	$('#inlineDatepicker').datepick(
			{
				onSelect: showDate,
				minDate: '0D',
				maxDate: '+2W'
			}
		);
});
 
function showDate(date) {
	alert('The date chosen is ' + date);
}
</script> 
</head>
<body>
<table height="80%" width="80%" border="1">
<tr><td><div id="inlineDatepicker"></div></td></tr>
</table> 

<!--  Surcharge des styles du calendrier -->
<style type="text/css"> 
@CHARSET "ISO-8859-1";
.datepick {
	height: 100%;
	width: 100%;
}
.datepick-inline {
	height: 100%;
	width: 100%;
}
.datepick-one-month {
	height: 100%;
	width: 100%;
}
</style>
</body>
</html>