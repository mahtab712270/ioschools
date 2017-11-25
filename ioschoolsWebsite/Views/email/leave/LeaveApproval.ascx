<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.notifications.LeaveNotification>" %>
<p>Dear <%= Model.receiver %>,</p>
<p><%= Model.applicant %>'s leave application requires your approval.</p>
<p>To review their leave application, please click on the link below.</p>

<p><a href="http://www.ioschools.edu.my/leave/<%= Model.applicantid %>">http://www.ioschools.edu.my/leave/<%= Model.applicantid %></a></p>
<p>
Regards,
<br />

</p>
