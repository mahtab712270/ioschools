<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.eca.ECAStudentEditViewModel>" %>
<tr alt="<%= Model.eca.id %>" class="bg_edit">
    <td>
    <%= Html.DropDownList("school", Model.schools, new Dictionary<string, object>(){{"class","w125px"}}) %>
    <br />
        <%= Html.DropDownList("school_eca", Model.ecaList, new Dictionary<string, object>() { { "class", "w200px mt5" } })%>
        <br/>
        <%= Html.DropDownList("type", Model.typeList, new Dictionary<string, object>() { { "class", "w125px mt5" } })%>
    </td>
<td>
        <%= Html.TextBox("post", Model.eca.post) %>
    </td>
<td>
        <%= Html.TextArea("achievement", Model.eca.achievement, new Dictionary<string, object>(){{"class","w95p"}}) %>
    </td>
    <td class="al w100px">
        <button id="buttonSave" type="button"><img class="am" src="/Content/img/icons/save.png" /> save</button>
            <br />
            <button id="buttonCancel" type="button"><img class="am" src="/Content/img/icons/cancel.png" /> cancel</button>
    </td>
</tr>
<script type="text/javascript">
    $(document).ready(function () {
        $('#year', '#ecaTable').numeric();
        $('#achievement', '#ecaTable').limit(1000);
        $('#remarks', '#ecaTable').limit(500);
        init_inputSelectors('#ecaTable');
        init_autogrow();
    });
    
</script>