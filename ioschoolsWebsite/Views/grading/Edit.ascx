<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.school.json.GradingJSON>" %>
<tr alt="<%= Model.id %>" class="bg_edit">
    <td>
        <%= Html.TextBox("name", Model.name) %>
    </td>
    <td>
        <table id="methodruleTable" class="table_row">
            <thead>
                <tr class="bg_edit">
                    <td class="w200px">
                        Mark
                    </td>
                    <td>
                        Grade
                    </td>
                    <td>
                        Grade Point
                    </td>
                    <td class="ar w100px">
                        <button type="button" class="buttonAddRule">
                            <img class="am" src="/Content/img/icons/plus.png" />
                            new rule</button>
                    </td>
                </tr>
            </thead>
            <tbody>
                <% Html.RenderAction("EditRuleRows", new { id = Model.id }); %>
            </tbody>
        </table>
    </td>
    <td class="ar">
        <button id="buttonSave" type="button">
            <img class="am" src="/Content/img/icons/save.png" />
            save</button>
        <button id="buttonCancel" type="button">
            <img class="am" src="/Content/img/icons/cancel.png" />
            cancel
        </button>
    </td>
</tr>
