<html>
<head>
<title>OdysseyBox</title>
<link href="template.css" rel="stylesheet" type="text/css" />
<?php 
include("javascript_functions.php")
?>
</head>
<body class="mainframe">
<div class="head">
<h1 class="site-title">OdysseyBox <small>adventure diary site</small></h1>
<h3><SCRIPT TYPE="text/javascript" LANGUAGE="JavaScript">
		document.write (displayDate())
	</SCRIPT>
</h3>
</div>
<div class="sitemenu">
<table width="100%">
<colgroup>
<col width="100%"/>
</colgroup>
<tbody>
<tr>
<td style="text-align:center">
<form action="home_menu.php" method="post" id="home_menu">
<fieldset class="frm_style"><input type="button" class="button_mainmenu" id="home" value="HOME" onclick="window.location.href='home.php'"/> <input type="button" class="button_mainmenu" id="gallery" value="GALLERY" onclick="window.location.href='gallery.php'"/> <input type="button" class="button_mainmenu" id="members" value="MEMBERS" /> <input type="button" class="button_mainmenu" id="sign-up" value="SIGN-UP" onclick="window.location.href='sign_up.php'" /> <input type="button" class="button_mainmenu" id="links" value="LINKS" /> <input type="button" class="button_mainmenu" id="credits" value="CREDITS" onclick="window.location.href='credits.php'"/> <input type="button" class="button_mainmenu" id="about_us" value="ABOUT US" onclick="window.location.href='about_us.php'"/> <input type="button" class="button_mainmenu" id="contacts" value="CONTACTS" onclick="window.location.href='contacts.php'"/>
</fieldset>
</form>
</td>
</tr>
</tbody>
</table>
</div>
<div class="sitebody">

