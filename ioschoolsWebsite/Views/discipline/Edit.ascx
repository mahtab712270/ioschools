<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.discipline.Discipline>" %>
<%@ Import Namespace="ioschoolsWebsite.Models.discipline" %>
<tr alt="<%= Model.id %>" class="bg_edit">
    <td class="w300px">
    <%= Html.DropDownList("discipline_type", Model.types, new Dictionary<string, object>(){{"class","w250px"}} ) %>
    </td>
    <td>
        <%= Html.TextArea("discipline_reason", Model.reason) %>
    </td>
    <td id="discipline_points" class="at w100px" alt="<%= Model.points %>">
        <% if (Model.points.HasValue)
           {
               if (Model.isRanged)
               { %>
        <%= Html.DropDownList("points_selector", Model.ranges)%>
        <% }
               else
               { %>
        <%= Html.TextBox("points_selector", Model.points)%>
        <% }
           } %>
    </td>
    <td class="at w100px">
        <button id="discipline_save" type="button">
            <img class="am" src="/Content/img/icons/save.png" /> save</button>
            <button id="discipline_cancel" type="button"><img class="am" src="/Content/img/icons/cancel.png" /> cancel</button>
    </td>
</tr>
<script type="text/javascript">
    $(document).ready(function () {
        $('#discipline_points', '#disciplineTable').numeric({ allow: "-" });
        $('#discipline_reason').limit(1000);
    });
</script>
