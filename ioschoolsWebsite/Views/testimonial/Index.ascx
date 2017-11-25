<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.user.student.Testimonial>" %>
<h1 class="icon_user">
    <%= Model.student_name %></h1>
<form id="testForm" action="/testimonial/save" method="post">
<table id="testimonial_table">
<thead><tr><td colspan="2" class="tip">A = Very Good, B  =  Good, C  =  Average, D  =  Below Average, E  =  Poor</td></tr></thead>
<tbody>
<tr><td>Academic Ability</td><td><%= Html.TextBox("test_academic", Model.test_academic) %></td>
<td>Honesty</td><td><%= Html.TextBox("test_honesty", Model.test_honesty) %></td></tr>
<tr><td>Conscientiousness & Diligence in Studies</td><td><%= Html.TextBox("test_diligence", Model.test_diligence) %></td>
<td>Self-reliance</td><td><%= Html.TextBox("test_reliance", Model.test_reliance) %></td></tr>
<tr><td>Attendance in School</td><td><%= Html.TextBox("test_attendance", Model.test_attendance) %></td>
<td>Ability to work with others</td><td><%= Html.TextBox("test_collaborate", Model.test_collaborate) %></td></tr>
<tr><td>Sense of Responsibility</td><td><%= Html.TextBox("test_responsible", Model.test_responsible) %></td>
<td>Dress & General Appearance</td><td><%= Html.TextBox("test_appearance", Model.test_appearance) %></td></tr>
<tr><td>Leadership & Initiative</td><td><%= Html.TextBox("test_initiative", Model.test_initiative) %></td>
<td>Command of Bahasa Malaysia</td><td><%= Html.TextBox("test_bm", Model.test_bm) %></td></tr>
<tr><td>Conduct</td><td><%= Html.TextBox("test_conduct", Model.test_conduct) %></td>
<td>Command of English</td><td><%= Html.TextBox("test_english", Model.test_english) %></td></tr>
</tbody>
</table>
<div class="form_entry">
    <div class="form_label">
        Remarks</div>
    <%= Html.TextArea("test_remarks", Model.test_remarks, new Dictionary<string, object>(){{"class","w500px"}}) %>
</div>
<div class="mt10">
    <button id="buttonSave" type="button" class="medium">
        <img class="am" src="/Content/img/icons/save.png" />
        save</button>
        <button id="buttonCreate" type="button" class="medium">
        <img class="am" src="/Content/img/icons/document.png" />
        export</button>
    <a href="#" onclick="dialogBox_close();return false;">close</a>
</div>
<%= Html.Hidden("studentid", Model.studentid) %>
</form>
<script type="text/javascript">
    $(document).ready(function () {
        init_inputSelectors('#testForm');
        init_autogrow('#testForm');
        $("input[type='text']", '#testForm').limit(1);
        $('#test_remarks', '#testForm').limit(1000);
        $('input', '#testimonial_table').width('15px');
    });

    $('#buttonCreate', '#testForm').click(function () {
        $('#testForm').attr('action', '/testimonial/export');
        $('#testForm').trigger('submit');
    });

    $('#buttonSave', '#testForm').click(function () {
        $('#testForm').attr('action', '/testimonial/save');
        var action = $('#testForm').attr("action");
        var serialized = $('#testForm').serialize();

        // post form
        $.ajax({
            type: "POST",
            url: action,
            data: serialized,
            context: this,
            dataType: 'json',
            success: function (json_data) {
                $.jGrowl(json_data.message);
                return false;
            }
        });
        return false;
    });
    
</script>
