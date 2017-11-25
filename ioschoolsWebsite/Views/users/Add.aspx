<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<ioschoolsWebsite.Models.user.UserViewModel>" MasterPageFile="~/Views/Shared/Internal.Master" %>
<%@ Import Namespace="ioschools.Data" %>
<%@ Import Namespace="ioschools.Data.User" %>
<%@ Import Namespace="ioschoolsWebsite.Library.Helpers" %>
<asp:Content runat="server" ID="Title" ContentPlaceHolderID="TitleContent">
<% if (!string.IsNullOrEmpty(Model.usr.id))
{%>	
<%= Model.usr.name %>
<%}else{ %>
  New User
<%} %>
</asp:Content>
<asp:Content runat="server" ID="ExtraHeader" ContentPlaceHolderID="ExtraHeader">
<%= Html.JavascriptInclude("/Scripts/ajaxUpload/fileuploader.js")%>
</asp:Content>
<asp:Content runat="server" ID="Main" ContentPlaceHolderID="MainContent">
<form id="addUserForm" action="/users/save" method="post" class="mt10 pb100" autocomplete="off">
  <div id="heading_add" class="hidden">
      <div class="breadcrumb"><a href="/dashboard">Users</a> > New User</div>
      <h2>New User</h2>
    <div class="info"><strong>Please use the <a href="/enrolment/add">online admission form</a> for enrolling new students and their parents</strong>.</div>
  </div>
<h2 id="heading_edit" class="hidden">
          <div class="breadcrumb"><a href="/dashboard">Users</a> > Update User Details</div>
    <%= Model.usr.name %>
</h2>
<div id="profile_image" class="images_column fr">
<div class="results">
    <%
    if (Model.usr.profilePhoto != null)
    {%>
    <div class='thumbnail' style="width:100%;">
        <img src='<%=Model.usr.profilePhoto.url%>' alt='<%=Model.usr.profilePhoto.id%>' />
        <div class='del' onclick="thm_delete(this,'<%=Model.usr.profilePhoto.id%>')">
            </div>
    </div>
    <%
    }
    else
    {%>
    <div class="nophoto">
        no profile photo has been uploaded yet</div>
    <%
    }%>
</div>
<%if (Model.usr.canModify){%>
<div id="swfu_profile" class="swfu_container">
    <div class="swfu_button">
    </div>
</div>
<%}%> 
</div>
<div class="fl w700px">
<% if (string.IsNullOrEmpty(Model.usr.id))
{%>	
<div class="fl mr10 form_entry">
<div class="form_label">User Group</div>
    <select name="ugroup" id="ugroup">
        <option value="" selected="selected">select user group</option>
        <option value="CLERK">Clerk</option>
        <option value="DIRECTOR">Director</option>
        <option value="FINANCE">Finance</option>
        <option value="HEAD">Headmaster/Headmistress</option>
        <option value="GUARDIAN">Parent/Guardian</option>
        <option value="ADMIN">System Administrator</option>
        <option value="TEACHER">Teacher</option>
        <option value="SUPPORT">Support Staff</option>
    </select>
</div>
<%}else{ %>
<%=Html.Hidden("ugroup", Model.usr.usergroup.ToString())%>
<%} %>
 
 <div id="school_selector" class="fl form_entry hidden">
<div class="form_label">School</div>
<%=Html.DropDownList("uschool", Model.usr.schoolsList)%>
</div>
<div class="clear"></div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Title</div>
        <%= Html.DropDownList("designation", Model.usr.designationList) %>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Name</div>
        <input type="text" id="name" name="name" value="<%= Model.usr.name %>" class="w450px" />
</div>
<div class="clear"></div>
<div class="form_entry">
<input id="gender_male" type="radio" name="gender" value="male" <%= Model.usr.gender == Gender.MALE?"checked='checked'":"" %> /><label for="gender_male">male</label>
<input id="gender_female" type="radio" name="gender" value="female" <%= Model.usr.gender == Gender.FEMALE?"checked='checked'":"" %> /><label for="gender_female">female</label>
</div>
<div class="form_entry">
    <div class="form_label">
        Email</div>
    <%= Html.TextBox("email", Model.usr.email, new Dictionary<string, object> { { "class", "w300px" } })%>
</div>
<div class="fl form_entry">
<%= Html.CheckBox("bumi", Model.usr.bumi)%> <label for="bumi">Bumiputra</label>
</div>
<div class="clear"></div>
<div class="form_entry">
    <div class="form_label">
        Marital Status</div>
    <%= Html.DropDownList("marital_status", Model.usr.maritalStatusList)%>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Race</div>
    <%= Html.TextBox("race", Model.usr.race)%>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Dialect</div>
    <%= Html.TextBox("dialect", Model.usr.dialect)%>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Religion</div>
    <%= Html.TextBox("religion", Model.usr.religion)%>
</div>
<div class="clear"></div>
<div class="fl mr10">
<div class="form_entry">
    <div class="form_label">
        Date of Birth</div>
        <%= Html.DropDownList("dob_day", Model.usr.dayList) %>
    <%= Html.DropDownList("dob_month", Model.usr.monthList) %>
    <%= Html.TextBox("dob_year", Model.usr.dob.HasValue?Model.usr.dob.Value.Year.ToString():"")%>
</div>
</div>
<div class="clear"></div>
<div class="fl mr10">
<div class="form_entry">
    <div class="form_label">
        Place of Birth</div>
    <%= Html.TextBox("pob", Model.usr.pob)%>
</div>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Citizenship</div>
    <%= Html.TextBox("citizenship", Model.usr.citizenship)%>
</div>
<div class="clear"></div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        NRIC No.</div>
    <%= Html.TextBox("nric_new", Model.usr.nric_new)%>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Birth Certificate No.</div>
    <%= Html.TextBox("birthcertno", Model.usr.birthcertno)%>
</div>
<div class="fl form_entry">
    <div class="form_label">
        Passport No.</div>
    <%= Html.TextBox("passport", Model.usr.passport)%>
</div>
<div class="clear"></div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Home Phone</div>
    <%= Html.TextBox("homephone", Model.usr.homephone)%>
</div>
<div class="fl form_entry">
    <div class="form_label">
        Cell Phone</div>
    <%= Html.TextBox("cellphone", Model.usr.cellphone)%>
</div>
<div class="clear"></div>
<div class="form_entry">
    <div class="form_label">
        Home Address</div>
    <%= Html.TextArea("address", Model.usr.address, new Dictionary<string, object> { { "class", "w99p" } })%>
</div>
</div>
<div class="clear"></div>

<div id="parents_section" class="usergroup_sections">
<div class="section_header">Parent/Guardian Details</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Occupation</div>
    <%= Html.TextBox("occupation", Model.usr.occupation)%>
</div>
<div class="fl form_entry">
    <div class="form_label">
        Office Phone</div>
    <%= Html.TextBox("officephone", Model.usr.officephone)%>
</div>
<div class="clear"></div>
<div class="form_entry">
    <div class="form_label">
        Name/Address of Employer</div>
        <%= Html.TextArea("employer", Model.usr.employer, new Dictionary<string, object> { { "class", "w99p" } })%>
</div>
<div class="section_header">
Children <a class="fr icon_add" href="#" onclick="dialogBox_open('/users/children','Add Children',622);return false;">add children</a>
</div>
<div>
<table id="children" class="table_brown">
<thead>
<tr><td>Child Name</td><td></td></tr>
</thead>
<tbody>
<% foreach(var child in Model.usr.children)
   {%>
   <tr alt="<%= child.id %>"><td><%= child.name %></td><td alt="<%= child.linkid %>" class="ar"><a href="#" class="assign_del">delete</a></td></tr>
   <%}%>
</tbody>
</table>
</div>
</div>
<% if (Model.usr.canModifyStaff)
   { %>
<div id="staff_section" class="usergroup_sections">
<div class="section_header">
    Staff Details</div>
<div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Income Tax</div>
    <%= Html.TextBox("staff_income_tax", Model.usr.staff.incomeTax)%>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        EPF number</div>
    <%= Html.TextBox("staff_epf", Model.usr.staff.epf)%>
</div>
<div class="clear"></div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Salary Grade</div>
    <%= Html.TextBox("staff_salary_grade", Model.usr.staff.salaryGrade) %>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        SOCSO</div>
    <%= Html.TextBox("staff_socso", Model.usr.staff.socso)%>
</div>
<div class="clear"></div>
</div>
<div class="section_header">
    Spouse Details</div>
<div>
<div class=" form_entry">
    <div class="form_label">
        Name</div>
    <%= Html.TextBox("staff_spouse_name", Model.usr.staff.spouseName, new Dictionary<string, object>(){{"class","w450px"}})%>
</div>
<div class=" form_entry">
    <div class="form_label">
        Employer</div>
    <%= Html.TextBox("staff_spouse_employer", Model.usr.staff.spouseEmployer, new Dictionary<string, object>() { { "class", "w450px" } })%>
</div>
<div class=" form_entry">
    <div class="form_label">
        Employer Address</div>
    <%= Html.TextArea("staff_spouse_employer_address", Model.usr.staff.spouseEmployerAddress, new Dictionary<string, object> { { "class", "w99p" } })%>
</div>

<div class="fl mr10 form_entry">
    <div class="form_label">
        Office Phone</div>
    <%= Html.TextBox("staff_spouse_phone_office", Model.usr.staff.spousePhoneWork)%>
</div>
<div class="fl mr10 form_entry">
    <div class="form_label">
        Cell Phone</div>
    <%= Html.TextBox("staff_spouse_phone_cell", Model.usr.staff.spousePhoneCell)%>
</div>
<div class="clear"></div>
</div>
<div class="section_header">
    Employment Details <a id="employment_add" class="icon_add fr" href="#" onclick="addAssignEmploymentRow();return false;">add entry</a></div>
<div class="mt10">
    <table id="employmentDetailsTable" class="table_brown">
        <thead>
            <tr>
                <td class="w200px">
                    Joining Date
                </td>
                <td class="w200px">
                    Leaving Date
                </td>
                <td>Remarks</td>
                <td class="w175px">
                    &nbsp;
                </td>
            </tr>
        </thead>
        <tbody>
            <% Html.RenderPartial("~/Views/staff/EmploymentRow.ascx", Model.usr.staff.employmentPeriods); %>
        </tbody>
    </table>
</div>
</div>
<% } %>
<% if (Model.usr.canModifyLeave && UserSuperGroups.STAFF.HasFlag(Model.usr.usergroup))
   { %>
   <div class="section_header">Leave Details<a class="icon_add fr" href="#" onclick="addStaffLeaveRow();return false;">add leave type</a></div>
<table id="staffLeaveTable" class="table_brown">
    <thead>
        <tr><td>Leave Type</td><td class="w150px ar">Annual Total</td><td class="w150px ar">Remaining</td><td class="w150px ar">Taken</td><td class="w175px"></td></tr>
    </thead>
    <tbody>
        <% foreach (var leave in Model.usr.staffLeaves)
            {%>
        <tr alt="<%= leave.id %>"><td><%= leave.name %></td><td class="ar"><%= leave.annualTotal %></td><td class="ar"><%= leave.remaining %></td><td class="ar"><%= leave.taken %></td><td class="ar"><span class="jqedit">edit</span><span class="jqdelete">delete</span></td></tr>
            <% } %>
    </tbody>
</table>
<% } %>
<div class="section_header">Notes</div>
<div class="mt10">
<p class="tip">Notes will be visible to anyone who can view this profile.</p>
<%= Html.TextArea("notes", Model.usr.notes, new Dictionary<string, object> { { "class", "w99p" } })%>
</div>
<div id="teachers_section" class="usergroup_sections">
<div class="section_header">
Classes <a class="icon_add fr" href="#" onclick="addAssignTeachersRow();return false;">add class</a>
</div>
<table id="assignedTeachersSubjectsTable" class="table_brown">
    <thead>
        <tr>
            <td>
                Year
            </td>
            <td>
                School
            </td>
            <td>
                Class
            </td>
            <td>
                Subject
            </td>
            <td>Day</td>
            <td>Start
            </td>
            <td>End
            </td>
            <td>
            </td>
        </tr>
    </thead>
    <tbody>
        <% foreach (var c in Model.usr.allocatedTeacherClasses)
           { %>
        <tr alt="<%= c.id %>">
            <td>
                <%= c.year %>
            </td>
            <td>
                <%= c.school %>
            </td>
            <td>
                <%= c.classname %>
            </td>
            <td>
                <%= c.subjectname %>
            </td>
            <td><%= c.day.ToString() %>
            </td>
            <td><%= c.time_start %>
            </td>
            <td><%= c.time_end %>
            </td>
            <td class="ar"><a href="#" class="assign_del">delete</a>
            </td>
        </tr>
        <%} %>
    </tbody>
</table>
</div>
<div id="students_section" class="usergroup_sections">
<div class="section_header">Classes<a class="icon_add fr" href="#" onclick="addAssignStudentsRow();return false;">add class</a></div>
<div class="">
<table id="assignedStudentsSubjectsTable" class="table_brown">
    <thead>
        <tr>
            <td>
                Year
            </td>
            <td>
                School
            </td>
            <td>
                Class
            </td>
            <td>
            </td>
        </tr>
    </thead>
    <tbody>
        <% foreach (var c in Model.usr.allocatedStudentClasses)
           { %>
        <tr alt="<%= c.id %>">
            <td>
                <%= c.year %>
            </td>
            <td>
                <%= c.school %>
            </td>
            <td>
                <%= c.classname %>
            </td>
            <td class="ar"><a href="#" class="assign_del">delete</a>
            </td>
        </tr>
        <%} %>
    </tbody>
</table>
</div>
<div class="section_header">
Parents / Guardians<a class="fr icon_add" href="#" onclick="dialogBox_open('/users/parents','Add Guardian/Parent',622);return false;">add parents / guardians</a>
</div>
<div class="">
<table id="parents" class="table_brown">
<thead>
<tr><td>Parent Name</td><td class="w200px">Relationship</td><td class="w100px"></td></tr>
</thead>
<tbody>
<% foreach(var parent in Model.usr.parents)
   {%>
   <tr alt="<%= parent.id %>"><td><%= parent.name %></td><td><%= parent.relationship %></td><td alt="<%= parent.linkid %>"><a href="#" class="assign_del">delete</a></td></tr>
   <%}%>
</tbody>
</table>
</div>
</div>
<div class="buttonRow_bottom">
    <span class="mr10">
        <button type="button" id="buttonCancel" class="ajax large">
           <img class="am" src="/Content/img/icons/cancel.png" /> cancel</button>
        <button type="button" id="buttonSave" class="ajax large">
           <img class="am" src="/Content/img/icons/save.png" /> save</button>
    </span>
</div>
<%= Html.Hidden("id", Model.usr.id) %>
<%= Html.Hidden("thumbnailid", Model.usr.thumbnailid) %>
</form>
<script type="text/javascript">
    $(document).ready(function () {
        ioschools.util.setNavigation('#nhome', 'selected_link');
        init_inputSelectors();
        init_autogrow('#addUserForm');

        $('#pob').limit(50);

        $(window).trackUnsavedChanges('#buttonSave');
        $('#dob_year,#enrol_year,#admission_year,#nric_new').numeric();
        $('#dialect').alphanumeric();
        $('#dob_year,#admission_year').watermark('year');
        // edit or add?
        if ($('#id', '#addUserForm').val() != '') {
            // edit
            $('#heading_edit').show();
            showUserGroupSection();
            showUserSchoolSelector();
        }
        else {
            // add
            $('#heading_add').show();
        }

        $("#dateleft", '#addUserForm').datepicker(
        {
            dateFormat: 'D, d M yy',
            onSelect: function () {
                $('#active').attr('checked', false);
            }
        });

        $('#ugroup', '#addUserForm').bind('change', function () {
            showUserGroupSection();
            showUserSchoolSelector();
        });

        $('#buttonSave', '#addUserForm').click(function () {
            $(this).trigger('submit');
        });

        initAjaxUpload();

    });
    
    function addAssignTeachersRow() {
        $.get('/classes/assigntoteachers', function (result) {
            $('tbody', '#assignedTeachersSubjectsTable').prepend(result);
        });
    }

    function addAssignStudentsRow() {
        $.get('/classes/assigntostudents', function (result) {
            $('tbody', '#assignedStudentsSubjectsTable').prepend(result);
        });
    }

    function addStaffLeaveRow() {
        $.get('/leave/newstaff', function (result) {
            $('tbody', '#staffLeaveTable').prepend(result);
            InitLeaveRow($('tbody > tr:first', '#staffLeaveTable'));
        });
    }

    function InitEmploymentPeriodRow(row) {
        $("#employment_start_date,#employment_end_date", row).datepicker(
            {
                dateFormat: 'd M yy'
            });
        // need to allow delete
        //$("#employment_start_date,#employment_end_date", row).attr('readonly', 'readonly');
        $("#employment_remarks", row).limit(500);
        init_inputSelectors(row);
        init_autogrow(row);
    }

    function InitLeaveRow(row) {
        $("#annualTotal,#left", row).numeric({allow:'.'});
        init_inputSelectors(row);
    }

    function addAssignEmploymentRow() {
        $.get('/staff/EmploymentEditRow', function (result) {
            $('tbody', '#employmentDetailsTable').prepend(result);
            var row = $('tbody tr:first', '#employmentDetailsTable');
            InitEmploymentPeriodRow(row);
        });
    }

    // students
    $('#enrol_school').bind('change', function () {
        $('#enrol_schoolyear').html('');
        var id = $(this).val();
        if (id == '') {
            return false;
        }
        return $(this).post('/schools/years/' + id, null, function (json_result) {
            if (json_result.success) {
                $('#enrol_schoolyear').html('<option value="">select year</option>');
                $.each(json_result.data, function () {
                    var option = ["<option value='", this.id, "'>", this.name, "</option>"];
                    $('#enrol_schoolyear').append(option.join(''));
                });
            }
            else {
                $.jGrowl(json_result.message);
            }
        });
    });

    // leaves
    $('#type', '#staffLeaveTable').live('change', function () {
        var row = $(this).closest('tr');
        var val = $(this).val();
        $(this).post('/leave/defaulttotal/' + val, function (json_result) {
            if (json_result.success) {
                $('#annualTotal', row).val(json_result.data);
            }
        });
    });

    $('.jqdelete', '#staffLeaveTable').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        var ok = window.confirm('Are you sure? This will ALSO DELETE ALL records of this leave type being applied by this user.');
        if (!ok) {
            return false;
        }
        return $(this).post('/leave/DeleteStaff/' + id, function (json_result) {
            if (json_result.success) {
                $(row).fadeOut('fast', function () {
                    $(this).remove();
                });
            }
            $.jGrowl(json_result.message);
        });
    });

    $('.jqedit', '#staffLeaveTable').live('click', function () {
        var row = $(this).closest('tr');
        var id = $(row).attr('alt');
        $(this).post('/leave/editstaff/' + id, function (result) {
            $(row).fadeOut('fast', function () {
                row.replaceWith($(result));
                InitLeaveRow(row);
            });
        });
    });

    $('#buttonSave', '#staffLeaveTable').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        var type = $('#type', row).val();
        var total = $('#annualTotal', row).val();
        var left = $('#left', row).val();
        var staffid = $('#id').val();

        $(this).post('/leave/saveStaff/' + id, { type: type, total: total, left: left, staffid: staffid }, function(json_result) {
            if (json_result.success) {
                $(row).fadeOut('fast', function() {
                    row.replaceWith($(json_result.data));
                });
            }
            $.jGrowl(json_result.message);
        });
    });
    
    $('#buttonCancel', '#staffLeaveTable').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        if (id == '') {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        } else {
            $(this).getx('/leave/singlestaff/' + id, function(result) {
                $(row).fadeOut('fast', function () {
                    row.replaceWith($(result));
                });
            });
        }
    });
    
    $('.assign_del', '#assignedStudentsSubjectsTable').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        if (id == '' || id == null) {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        }
        else {
            var ok = window.confirm('Are you sure?');
            if (!ok) {
                return false;
            }
            $(this).post('/classes/DetachStudentClass/' + id, function (json_result) {
                if (json_result.success) {
                    $(row).fadeOut('fast', function () {
                        $(this).remove();
                    });
                }
                $.jGrowl(json_result.message);
            }, 'json');
        }

        return false;
    });

    $('.assign_del', '#parents').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(this).parents('td').attr('alt');
        if (id == '' || id == null) {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        }
        else {
            var ok = window.confirm('Are you sure?');
            if (!ok) {
                return false;
            }
            $(this).post('/guardian/detach/' + id, function (json_result) {
                if (json_result.success) {
                    $(row).fadeOut('fast', function () {
                        $(this).remove();
                    });
                }
                $.jGrowl(json_result.message);
            }, 'json');
        }

        return false;
    });

    // parents
    $('.assign_del', '#children').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(this).parents('td').attr('alt');
        if (id == '' || id == null) {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        }
        else {
            var ok = window.confirm('Are you sure?');
            if (!ok) {
                return false;
            }
            $(this).post('/guardian/detach/' + id, function (json_result) {
                if (json_result.success) {
                    $(row).fadeOut('fast', function () {
                        $(this).remove();
                    });
                }
                $.jGrowl(json_result.message);
            }, 'json');
        }
        return false;
    });

    // staff
    $('.jqedit', '#employmentDetailsTable').live('click', function () {
        var row = $(this).closest('tr');
        var id = $(row).attr('alt');
        $(this).getx('/staff/EmploymentEditRow/' + id, function (result) {
            $(row).fadeOut('fast', function () {
                row.replaceWith($(result));
                var newrow = $('tr[alt=' + id + ']', '#employmentDetailsTable');
                InitEmploymentPeriodRow(newrow);
            });
        });
        return false;
    });
    
    $('.assign_del', '#employmentDetailsTable').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        if (id == '') {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        }
        else {
            var ok = window.confirm('Are you sure?');
            if (!ok) {
                return false;
            }
            $(this).post('/staff/DeleteEmploymentPeriod/' + id, function (json_result) {
                if (json_result.success) {
                    $(row).fadeOut('fast', function () {
                        $(this).remove();
                    });
                }
                $.jGrowl(json_result.message);
            }, 'json');
        }

        return false;
    });

    $('#buttonSave', '#employmentDetailsTable').live('click', function () {
        var row = $(this).closest('tr');
        var id = $(row).attr('alt');
        var start = $('#employment_start_date', row).val();
        var end = $('#employment_end_date', row).val();
        var remarks = $('#employment_remarks', row).val();
        var staffid = $('#id').val();
        
        $(this).post('/staff/EmploymentSave/' + id, { start: start, end: end, remarks: remarks, staffid: staffid }, function (json_result) {
            if (json_result.success) {
                $(row).fadeOut('fast', function () {
                    row.replaceWith($(json_result.data));
                });
            }
            $.jGrowl(json_result.message);
        });
    });

    $('#buttonCancel', '#employmentDetailsTable').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        if (id == '') {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        } else {
            $(this).getx('/staff/EmploymentRow/' + id, function (result) {
                $(row).fadeOut('fast', function () {
                    row.replaceWith($(result));
                });
            });
        }
    });
    
    // teachers
    $('.assign_del', '#assignedTeachersSubjectsTable').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        if (id == '' || id == null) {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        }
        else {
            var ok = window.confirm('Are you sure?');
            if (!ok) {
                return false;
            }
            $(this).post('/classes/DetachTeacherClass/' + id, function (json_result) {
                if (json_result.success) {
                    $(row).fadeOut('fast', function () {
                        $(this).remove();
                    });
                }
                $.jGrowl(json_result.message);
            }, 'json');
        }

        return false;
    });

    $('#school', '#addUserForm').live('change', function () {
        var row = $(this).parents('tr');
        var schoolid = $(this).val();
        if (schoolid != '') {
            $('#subject,#schoolclass', row).html('');
            $(this).getx('/schools/classes/' + schoolid, function (json_result) {
                if (json_result.success) {
                    $('#schoolclass', row).html('<option value="">select class</option>');
                    $.each(json_result.data, function () {
                        var option = ["<option value='", this.id, "'>", this.name, "</option>"];
                        $('#schoolclass', row).append(option.join(''));
                    });
                }
                else {
                    $.jGrowl(json_result.message);
                }
            }, 'json');

            $(this).post('/schools/subjects/' + schoolid, null, function (json_result) {
                if (json_result.success) {
                    $.each(json_result.data, function () {
                        var option = ["<option value='", this.id, "'>", this.name, "</option>"];
                        $('#subject', row).append(option.join(''));
                    });
                    if (json_result.data.length == 0) {
                        // need empty option to have something to submit
                        $('#subject', row).append("<option value=''>&nbsp;</option>");
                    }
                }
                else {
                    $.jGrowl(json_result.message);
                }
            }, 'json');
        } // if
    });

    function showUserGroupSection() {
        $('.usergroup_sections').hide();
        var usergroup = $('#ugroup', '#addUserForm').val();
        switch (usergroup) {
        case "GUARDIAN":
            $('#parents_section').show();
            break;
        case "TEACHER":
        case "HEAD":
            $('#teachers_section').show();
        case "DIRECTOR":
        case "CLERK":
        case "FINANCE":
        case "ADMIN":
        case "SUPPORT":
            if ($('#id', '#addUserForm').val() != '') {
                $('#staff_section').show();
            }
            break;
        case "STUDENT":
            $('#students_section').show();
            break;
        default:
            break;
        }
    }

    function showUserSchoolSelector() {
        $('#school_selector').hide();
        var usergroup = $('#ugroup', '#addUserForm').val();
        switch (usergroup) {
        case "GUARDIAN":
        //case "TEACHER":
        case "STUDENT":
                // don't show because we can tell from allocated classes
            break;
        default:
            $('#school_selector').show();
            break;
        }
    }


    $('#buttonCancel').click(function () {
        window.location = '/users/<%= Model.usr.id %>';
    });



    

    $('#addUserForm').submit(function () {
        var action = $(this).attr("action");
        var serialized = $(this).serialize();
        var ok = $('#addUserForm').validate({
            invalidHandler: function (form, validator) {
                $(validator.invalidElements()[0]).focus();
            },
            focusInvalid: false,
            rules: {
                ugroup: {
                    required: true
                },
                email: {
                    required: false,
                    email: true
                },
                name: {
                    required: true
                }
            }
        }).form();
        if (!ok) {
            return false;
        }
        // post form
        $.ajax({
            type: "POST",
            url: action,
            data: serialized,
            context: $('#buttonSave', '#addUserForm'),
            dataType: 'json',
            success: function (json_result) {
                $.jGrowl(json_result.message);
                if (json_result.success) {
                    window.location = '/users/' + json_result.data;
                }
                return false;
            }
        });
        return false;
    }); // submit


    function thm_delete(ele, imageid) {
        var confirm = window.confirm('Delete photo?');
        if (!confirm) {
            return;
        }
        $.post('/photo/delete/' + imageid, null, function (json_result) {
            $('#thumbnailid').val('');
            $(ele).parents(".thumbnail").fadeOut(500, function () {
                $(this).remove();
                if ($('.images_column').find('.thumbnail').length == 0) {
                    $('.images_column').find('.nophoto').show();
                }
            });
        }, 'json');
    }

    var initAjaxUpload = function () {
        // upload url
        var uploader = new qq.FileUploader({
            element: $('.swfu_button', '#addUserForm')[0],
            action: '/photo/upload/user/' + $('#id', '#addUserForm').val(),
            allowedExtensions: ['jpg', 'png', 'gif', 'jpeg'],
            onSubmit: function (id, filename) {
            },
            onComplete: function (id, filename, json_data) {
                // enable upload button
                if (json_data.success) {
                    var photo = json_data.data;
                    var thumbnail = "<div class='thumbnail' style='width:100%;'><img src='" +
                        photo.url + "' alt='" + photo.id + "' /><div class='del' onclick='thm_delete(this," +
                            photo.id + ")'></div></div>";
                    $('.results', '#profile_image').html(thumbnail);
                    $('#thumbnailid').val(photo.id);
                }
                else {
                    $.jGrowl(json_data.message);
                }
            }
        });
    };

</script>
</asp:Content>