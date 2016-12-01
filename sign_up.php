<?php 
include("site_head.php")
?>


<table width="100%">
<colgroup>
<col width="35%"/>
<col width="30%"/>
<col width="35%"/>
</colgroup>
<tbody>

<tr>


<td>&nbsp;</td>
<td>
<form action="POST" class="frmlogin" onSubmit="return validate_form(this)" >
<fieldset class="frm_style">
<table width="100%">
<colgroup>
<col width="50%"/>
<col width="50%"/>
</colgroup>
<tbody>
<tr>
<td colspan="2" class="form-login-text" style="text-align:center">Please fill-up the form:<br/>&nbsp;</td>
</tr>
<tr>
<td><span class="form-login-text">Firstname:</span></td>
<td><input type="text" maxlength="20" name="firstname" id="firstname" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Middle Initial:</span></td>
<td><input type="text" maxlength="2" name="middle_initial" id="middle_initial" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Lastname:</span></td>
<td><input type="text" maxlength="20" name="lastname" id="lastname" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Address:</span></td>
<td><input type="text" maxlength="50" name="address" id="address" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Gender:</span></td>
<td><select class="frmtextbox" name="select_gender">
<option>Male</option>
<option>Female</option>
</select>
</td>
</tr>
<tr>
<td><span class="form-login-text">Birthday:</span></td>
<td><input type="text" maxlength="10" name="birthday" id="birthday" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Age:</span></td>
<td><input type="text" maxlength="10" name="age" id="age" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Status:</span></td>
<td><input type="text" maxlength="10" name="status" id="gender" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">E-mail address:</span></td>
<td><input type="text" maxlength="30" name="email" id="email" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Password:</span></td>
<td><input type="password" maxlength="10" name="password" id="confirm_email" class="frmtextbox"/></td>
</tr>
<tr>
<td><span class="form-login-text">Confirm password:</span></td>
<td><input type="password" maxlength="10" name="confirm_password" id="confirm_password" class="frmtextbox"/></td>
</tr>
<tr>
<td style="text-align:center" colspan="2"><input type="button" name="cancel" id="cancel" title="cancel" value="Cancel"  class="button_login_mainmenu"/>
<input type="button" name="register" id="register" title="register" value="Register"  class="button_login_mainmenu"/></td>
</tr>

</tbody>
</table>
</fieldset>
</form>
</td>
<td>&nbsp;</td>


</tr>

</tbody>

</table>

<?php 
include("site_foot.php")
?>