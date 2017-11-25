<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<ioschoolsWebsite.Models.school.json.GradingRuleJSON>>" %>
<% foreach (var rule in Model)
   {%>
<tr class="bg_edit" alt="<%= rule.id %>">
    <td>
        <%= Html.TextBox("mark", rule.mark, new Dictionary<string, object>(){{"class", "w100px"}}) %>
    </td>
    <td>
        <%= Html.TextBox("g", rule.grade, new Dictionary<string, object>(){{"class", "w50px"}}) %>
    </td>
    <td>
        <%= Html.TextBox("gp", rule.gradepoint, new Dictionary<string, object>(){{"class", "w50px"}}) %>
    </td>
    <td class="ar">
        <span class="jqdelete deleterule">delete</span>
    </td>
</tr>
<% } %>
