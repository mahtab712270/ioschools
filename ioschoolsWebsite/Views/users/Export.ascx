﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<form id="exportUserForm" method="post" action="/users/export">
<h2 class="heading_add">Select attributes you would like to export</h2>
<table class="table_grey">
<thead>
<tr><td>General Attributes</td><td>Student/Teacher Attributes</td><td>Parent Attributes</td></tr>
</thead>
<tbody>
<tr><td>
<ul>
<li><%= Html.CheckBox("name", true) %><label for="name">Name</label></li>
<li><%= Html.CheckBox("ugroup") %><label for="ugroup">Usergroup</label></li>
<li><%= Html.CheckBox("race") %><label for="race">Race</label></li>
<li><%= Html.CheckBox("gender") %><label for="gender">Gender</label></li>
<li><%= Html.CheckBox("dob") %><label for="dob">DOB</label></li>
<li><%= Html.CheckBox("citizenship") %><label for="citizenship">Citizenship</label></li>
<li><%= Html.CheckBox("email") %><label for="email">Email</label></li>
<li><%= Html.CheckBox("contactnos") %><label for="contactnos">Contact Info</label></li>
<li><%= Html.CheckBox("icpassport") %><label for="icpassport">IC/Passport</label></li>
<li><%= Html.CheckBox("birthcert") %><label for="birthcert">Birth Cert.</label></li>
<li><%= Html.CheckBox("address") %><label for="address">Address</label></li>
</ul>
</td><td>
<ul>
<li><%= Html.CheckBox("school") %><label for="school">School</label></li>
<li><%= Html.CheckBox("sclass") %><label for="sclass">Class</label></li>
<li><%= Html.CheckBox("guardian") %><label for="guardian">Parent Info</label></li>
<li><%= Html.CheckBox("children") %><label for="children">Children Info</label></li>
<li><%= Html.CheckBox("rank") %><label for="rank">Rank</label></li>
</ul>
</td><td>
<ul>
<li><%= Html.CheckBox("occupation") %><label for="occupation">Occupation</label></li>
</ul>
</td></tr>
</tbody>
</table>

<div class="clear"></div>
<div class="mt10">
<button id="buttonExport" type="button" class="medium">
        export</button>
    <a href="#" onclick="dialogBox_close();return false;">close</a>
</div>
</form>
<script type="text/javascript">
    $('#buttonExport', '#exportUserForm').click(function () {
        $('#exportUserForm').trigger('submit');
    });
</script>
