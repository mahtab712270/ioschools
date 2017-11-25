<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<ioschoolsWebsite.Models.subject.SubjectTeacher>>" %>
<% foreach (var entry in Model)
   {%>
<tr>
    <td>
        <%= entry.subjectname %>
        <%= Html.Hidden("subjectid", entry.subjectid) %>
    </td>
    <td>
        <table class="table_brown">
            <tbody>
                <% foreach (var teacherEntry in entry.teachers)
               {%>
  <tr><td><%= teacherEntry.teachername %>
  <div>
       <%foreach (var klass in teacherEntry.AllocatedClasses)
{%>
  <span class="tag"><%= klass.name %></span>
<%} %>
  </div>
  </td>
  </tr>
              <% } %>
            </tbody>
        </table>
    </td>
    <td class="w100px">
        <span class="jqedit">edit</span>
    </td>
</tr>
<%   } %>
