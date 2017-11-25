<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.attendance.AttendanceAddViewModel>" %>
<%@ Import Namespace="ioschools.Data.Attendance" %>
<h1 class="icon_user">
    <%= Model.student_name %></h1>
<form id="attendanceForm" action="/attendance/save" method="post">
    <div class="fl">
        <div class="form_entry">
    <div class="form_label">
        Attendance Status</div>
    <select id="status" name="status" class="w200px">
        <option value="late">Late</option>
        <option value="absent">Absent</option>
        <option value="excused">Excused</option>
    </select>
</div>
        <div class="form_entry">
    <div class="form_label">
        Type</div>
    <input type="radio" id="type_class" checked="checked" name="type_group" value="schoolclass" /><label for="type_class">Class</label>
    <input type="radio" id="type_eca" name="type_group" value="eca" /><label for="type_eca">ECA</label>
</div>
<div id="class_entry">
    <div class="form_entry">
        <div class="form_label">
            Class</div>
        <%= Model.class_name %>
    </div>
</div>
<div id="eca_entry" class="hidden">
    <div class="form_entry">
        <div class="form_label">
            ECA</div>
        <%= Html.DropDownList("eca", Model.ecaList) %>
    </div>
</div>


    </div>
    <div class="fr mr40">
        <div class="form_entry">
    <div class="form_label">
        Affected Day(s)</div>
        <ul>
            <li><input type="radio" id="single_day" name="datetype" value="<%= AttendanceDateType.SINGLEDAY %>" checked="checked" onclick="handleAttendanceDays();" />
            <label for="single_day">Single Day</label>
            <div class="ml20"><%= Html.TextBox("date", Model.date)%></div>
            </li>
            <li><input type="radio" id="range_day" name="datetype" value="<%= AttendanceDateType.RANGE %>" onclick="handleAttendanceDays();"/>
            <label for="single_day">Multiple Days</label>
            <div class="form_entry ml20">
        <div class="form_label">
            Start Date</div>
        <%= Html.TextBox("dateFrom", Model.dateFrom) %>
    </div>
    <div class="form_entry ml20">
        <div class="form_label">
            End Date (include)</div>
        <%= Html.TextBox("dateTo", Model.dateTo)%>
    </div>
            </li>
        </ul>
</div>
    </div>
    <div class="clear"></div>
    <div class="form_entry">
    <div class="form_label">
        Details / Reason</div>
    <%= Html.TextArea("reason", new Dictionary<string, object>(){{"class","w500px"}}) %>
</div>
<div class="mt10">
    <button id="buttonSave" type="button" class="medium ajax">
        <img class="am" src="/Content/img/icons/save.png" /> save</button>
    <a href="#" onclick="dialogBox_close();return false;">cancel</a>
</div>
<%= Html.Hidden("studentid", Model.studentid) %>
</form>
<script type="text/javascript">
    function handleAttendanceDays() {
        if($('#single_day', '#attendanceForm').is(':checked')) {
            $('#date', '#attendanceForm').attr('disabled', false);
            $('#dateTo,#dateFrom', '#attendanceForm').attr('disabled', true);
        } else {
            $('#date', '#attendanceForm').attr('disabled', true);
            $('#dateTo,#dateFrom', '#attendanceForm').attr('disabled', false);
        }

        // bind dates
        $("#date,#dateTo,#dateFrom", '#attendanceForm').datepicker(
            {
                dateFormat: 'D, d M yy'
            });

        $("#date,#dateTo,#dateFrom", '#attendanceForm').attr('readonly', 'readonly');
    }

    $(document).ready(function () {
        init_inputSelectors('#attendanceForm');
        init_autogrow('#attendanceForm');
        $('#reason', '#attendanceForm').limit(500);
        handleAttendanceDays($('#single_day')[0]);


        $('#type_class', '#attendanceForm').click(function () {
            $('#eca_entry').slideUp('fast', function () {
                $('#class_entry').slideDown('fast');
            });
        });

        $('#type_eca', '#attendanceForm').click(function () {
            $('#class_entry').slideUp('fast', function () {
                $('#eca_entry').slideDown('fast');
            });
        });
    });

    $('#buttonSave', '#attendanceForm').click(function () {
        $('#attendanceForm').trigger('submit');
    });

    $('#attendanceForm').submit(function () {
        var serialized = $(this).serialize();
        var action = $(this).attr("action");

        var ok = $('#attendanceForm').validate({
            invalidHandler: function (form, validator) {
                $(validator.invalidElements()[0]).focus();
            },
            focusInvalid: false,
            rules: {
                date: {
                    required: false
                }
            }
        }).form();
        if (!ok) {
            return false;
        }

        // post form
        $('#buttonSave', '#attendanceForm').post(action, serialized, function (json_result) {
            if (json_result.success) {
                // need to reload 2 locations
                if (typeof reloadUsersGrid == "function") {
                    reloadUsersGrid();
                }
                
                // trigger year change to force reload of 
                $('#attendance_year_select').trigger('change');

                dialogBox_close();
            }
            $.jGrowl(json_result.message);
        }, 'json');
        return false;
    });
</script>
