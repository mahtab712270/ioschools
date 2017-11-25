<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.notifications.LeaveNotification>" %>
<p>Dear <%= Model.receiver %>,</p>
<p>Your Leave Application #<%= Model.leavetakenID %> has been <%= Model.status %>.</p>
<% if (!string.IsNullOrEmpty(Model.reason)) {%>
  <p>Reason given was: </p>
  <div style="font-style: italic">
  <%= Model.reason %>
  </div>
 <%  } %>
<p>
Regards,
<br />
 School
</p>
