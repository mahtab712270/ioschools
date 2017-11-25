<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<ioschoolsWebsite.Models.fees.SchoolFeeStudent>>" %>
<%@ Import Namespace="ioschoolsWebsite.Models.fees" %>
<% foreach (var fee in Model)
   {%>
<tr alt="<%= fee.id %>">
    <td class="">
        <%= fee.name %>
    </td>
    <td class="ar w150px">
        <%= fee.amount.ToString("n2")%>
    </td>
    <td class="ar w150px">
        <div class="bold">
            <%= fee.duedate.ToSmartDate()%>
        </div>
        <div>
            <a class="reminderDetails" href="#"><strong>
                <%= fee.warningsent %></strong>
                <%= fee.warningsent == 1?"reminder":"reminders" %>
            </a>
        </div>
    </td>
</tr>
<% } %>
