<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.school.AdminSchoolClassesViewModel>" %>
<h2>
    <%= Model.schoolname %></h2>
<%= Html.Hidden("schoolid", Model.schoolid) %>
<table id="schoolyearTable" class="table_brown">
    <thead>
        <tr>
            <td colspan="2">
                <h3>
                    School Years</h3>
            </td>
            <td class="ar">
                <button type="button" id="buttonAdd">
                    <img class="am" src="/Content/img/icons/plus.png" />
                    new school year</button>
            </td>
        </tr>
        <tr>
            <td>
                Name
            </td>
            <td>
                Grading Method
            </td>
            <td class="w200px">
            </td>
        </tr>
    </thead>
    <tbody>
        <% Html.RenderPartial("~/Views/Schools/YearRows.ascx", Model.schoolYears); %>
    </tbody>
</table>
<table id="schoolclassesTable" class="table_brown">
    <thead>
        <tr>
            <td colspan="3">
                <h3>
                    School Classes</h3>
            </td>
            <td class="ar">
                <button type="button" id="buttonAdd">
                    <img class="am" src="/Content/img/icons/plus.png" />
                    new school class</button>
            </td>
        </tr>
        <tr>
            <td>
                Year
            </td>
            <td>
                Class Name
            </td>
            <td>
                Class Next Year
            </td>
            <td class="w200px">
            </td>
        </tr>
    </thead>
    <tbody>
        <% Html.RenderPartial("~/Views/classes/Rows.ascx", Model.classes); %>
    </tbody>
</table>
