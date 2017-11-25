<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<ioschoolsWebsite.Models.fees.LateFeeAlertSiblings>>" %>
<% foreach (var alert in Model.OrderBy(x => x.children.SelectMany(y => y.overdueFees).Max(z => z.duedate)))
   {%>
<table class="unpaidTable table_grey mt20 collapse_off">
    <thead>
        <tr>
            <td class="w300px">
            </td>
            <td>
                <div class="fl ml10">
                    Overdue Fees, RM</div>
                <div class="fr mr10">
                    Payment Due</div>
            </td>
        </tr>
    </thead>
    <tbody>
        <% foreach (var child in alert.children)
           {%>
        <tr class="childrow">
            <td>
                <a class="childname" target="_blank" href="/users/<%= child.studentid %>">
                    <%= child.studentname%></a>
                <%= Html.Hidden("studentid", child.studentid) %>
            </td>
            <td>
                <table id="overdueFeesTable" class="w100p">
                    <tbody>
                        <% Html.RenderPartial("FeesOverdue", child.overdueFees); %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3">
                                <a href="#" class="addAdditionalFee icon_add">add additional fee</a>
                            </td>
                        </tr>
                        <tr class="hidden bg_edit">
                            <td>
                                <%= Html.TextBox("other_name","", new Dictionary<string, object>(){{"class","w250px"}}) %>
                            </td>
                            <td class="ar w175px">
                                RM
                                <%= Html.TextBox("other_amount") %>
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
                    </tfoot>
                </table>
            </td>
        </tr>
        <% } %>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="3" class="ar">
                <button class="buttonReminder" type="button"><img src="/Content/img/icons/send.png" />
                    Send Reminder</button>
            </td>
        </tr>
    </tfoot>
</table>
<%  } %>
