<?php 
include("javascript_functions.php")
?>
<form action="POST" class="frmlogin" onSubmit="return validate_form(this)">
<fieldset class="frm_style">
<table width="100%">
<colgroup>
<col width="50%"/>
<col width="50%"/>
</colgroup>
<tbody>
<tr>
<td><span class="form-login-text">Username :</span></td>
<td><input type="text" maxlength="20" name="UserName" id="UserName" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Password :</span></td>
<td><input type="password" maxlength="10" name="UserPassword" id="UserPassword" class="frmtextbox"/></td>
</tr>
<tr>
<td></td>
<td style="text-align:right"><input type="submit" name="Log-in" id="Log-in" title="Log-in" value="Log-in"  class="button_login_mainmenu"/></td>
</tr>
<tr><td colspan="2" style="text-align:center"><a href="sign_up.php"><small>Sign-up</small></a></tr>
</tbody>
</table>
</fieldset>
</form>
