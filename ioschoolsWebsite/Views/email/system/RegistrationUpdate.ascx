<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.email.EmailRegistrationUpdateViewModel>" %>
<p>Dear <%= Model.applicantName %>,</p>
<p>The following is a message with regards to your enrolment:</p>
<p><%= Model.message %></p>
<p>
 School Information System
</p>
