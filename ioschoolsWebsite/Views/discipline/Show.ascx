<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.discipline.DisciplineViewModel>" %>
<div class="mt10">
<div class="fl" id="discipline_year_selector_<%= Model.studentid %>">
<% if(Model.years.Count() != 0)
   {%>
    <%=Html.DropDownList("discipline_year_select", Model.years)%>
    <%
   }%>
</div>
<div class="fr">
    <% Html.RenderAction("Add","Discipline"); %>
    </div>
    <div class="clear"></div>
    <div id="discipline_results_<%= Model.studentid %>">
    <%
        Html.RenderPartial("~/Views/discipline/ShowContent.ascx", Model);%>
</div>
    <a class="icon_info" id="discipline_details_button" href="#">Click here for more information</a>
    <table id="discipline_info" class="table_grey hidden">
        <thead>
            <tr>
                <td class="bg_green font_white">
                    Behaviour
                </td>
                <td class="w100px bg_green font_white">
                    Merit Points
                </td>
                <td class="bg_red font_white">
                    Behaviour
                </td>
                <td class="w100px bg_red font_white">
                    Demerit Points
                </td>
                <td class="bg_red font_white">
                    Behaviour
                </td>
                <td class="w100px bg_red font_white">
                    Demerit Points
                </td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    Honesty
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Littering
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Disrespect to staff/prefect
                </td>
                <td>
                    5-20
                </td>
            </tr>
            <tr>
                <td>
                    Initiative
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Spitting
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Fighting
                </td>
                <td>
                    5-20
                </td>
            </tr>
            <tr>
                <td>
                    Diligence/Completion/Neat-ness in school work
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Shabbiness
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Bullying
                </td>
                <td>
                    5-20
                </td>
            </tr>
            <tr>
                <td>
                    Tidiness/Neatness in appearance and classroom
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Rowdiness
                </td>
                <td>
                    2-5
                </td>
                <td>
                    In possession of prohibited items
                </td>
                <td>
                    5-20 (Items confiscated)
                </td>
            </tr>
            <tr>
                <td>
                    Kindness
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Coming to school/lessons late
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Leaving class/school without permission
                </td>
                <td>
                    5-20
                </td>
            </tr>
            <tr>
                <td>
                    Helpfulness
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Failure to complete/Hand in assignment
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Gambling/Betting
                </td>
                <td>
                    10-20
                </td>
            </tr>
            <tr>
                <td>
                    Reports misdeeds without fear/favour
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Eating in class/Running along corridor/Playing rough
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Seen in company of outsiders of suspicious character
                </td>
                <td>
                    10-20
                </td>
            </tr>
            <tr>
                <td>
                    Willing to take responsibilities
                </td>
                <td>
                    2-5
                </td>
                <td>
                    Uttering foul language
                </td>
                <td>
                    5-10
                </td>
                <td>
                    Inappropriate/Indecent behaviour
                </td>
                <td>
                    45
                </td>
            </tr>
            <tr>
                <td>
                    Courageous acts
                </td>
                <td>
                    2-10
                </td>
                <td>
                    Telling lies/Spreading rumours
                </td>
                <td>
                    5-10
                </td>
                <td>
                    Smoking
                </td>
                <td>
                    45
                </td>
            </tr>
            <tr>
                <td>
                    Other good deeds
                </td>
                <td>
                    2-10
                </td>
                <td>
                    Quarrelling
                </td>
                <td>
                    5-10
                </td>
                <td>
                    Cheating in School Test/Examination
                </td>
                <td>
                    50
                </td>
            </tr>
            <tr>
                <td>
                    Positive changes in attitude/behaviour/performance
                </td>
                <td class="at" rowspan="2">
                    Award to be based on demerit points accumulated
                </td>
                <td>
                    Vandalism
                </td>
                <td>
                    5-20
                </td>
                <td>
                    Drug abuse
                </td>
                <td>
                    50
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    Stealing
                </td>
                <td>
                    5-20
                </td>
                <td>
                    Any other inappropriate conduct/behaviour not covered above
                </td>
                <td>
                    To be determined by the School Discipline Board/HM/DHM
                </td>
            </tr>
        </tbody>
    </table>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('#discipline_details_button').bind('click', function () {
            $('#discipline_info').slideToggle();
            return false;
        });

        $('select', '#discipline_year_selector_<%= Model.studentid %>').bind('change', function () {
            var selected = $(this).val();
            $(this).post('/discipline/showcontent/<%= Model.studentid %>', { year: selected }, function (result) {
                $('#discipline_results_<%= Model.studentid %>').html(result);
            });
        });
    });
    
</script>

