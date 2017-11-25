<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.subject.SubjectRow>" %>
<tr alt="<%= Model.subject.id %>" class="bg_edit">
    <td>
        <%= Html.DropDownList("schools", Model.schoolList) %>
    </td>
    <td>
        <%= Html.TextBox("name", Model.subject.subjectname, new Dictionary<string, object>(){{"class", "w400px"}}) %>
    </td>
    <td class="ar">
        <button id="buttonSave" type="button">
            <img class="am" src="/Content/img/icons/save.png" /> save</button>
            <button id="buttonCancel" type="button">
            <img class="am" src="/Content/img/icons/cancel.png" /> cancel
            </button>
    </td>
</tr>
