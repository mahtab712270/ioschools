<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.homework.Homework>" %>
<%@ Import Namespace="ioschoolsWebsite.Library" %>
<tr class="homework" alt="<%= Model.id %>">
    <td>
        <h2 class="fl"><%= Model.title %></h2>
        <span class="fr font_grey smaller"><%= Model.created %></span>
        <div class="clear"></div>
        <div class="font_grey mb10"><%= Model.subjectname %> - <%= string.Join(", ", Model.classes.Select(x => x.name).ToArray()) %></div>
        <p><%= Model.message.ToHtmlBreak() %></p>
        <% if(Model.files.Count() != 0)
       {%>
<div class="bold icon_pin mt20"> Homework Attachments</div>
    <%
       foreach (var file in Model.files)
       {%>
                <a class="icon_file" target="_blank" href="<%=file.url%>">
                    <%=file.name%></a>
                <%
       }
   }%>
   <div class="clear"></div>
    <div id="homework_answer_container" class="mt10">
    </div>
    </td>
    <td class="w150px">
        
        <div>
            <span class="jqedit">
                edit</span>
                <span class="jqdelete mr10">
                delete</span>
        </div>
            <div class="icon_disk mt10" title="disk usage">
                <%= Model.totalSize != 0
                                   ? (Model.totalSize / 1000000).ToString("f2") + "MB"
                                   : "0MB"%></div>
            
                <div><a class="viewanswer" href="#">show students</a></div>
    </td>
</tr>
