<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<ioschoolsWebsite.Models.fees.FeeNotificationTemplate>>" %>
<% foreach (var row in Model)
   {%>
<tr alt="<%= row.id %>">
    <td>
        <%= row.title %>
    </td>
    <td class="ar">
        <span class="jqedit">edit</span><span class="jqdelete">delete</span>
    </td>
</tr>
<%} %>
