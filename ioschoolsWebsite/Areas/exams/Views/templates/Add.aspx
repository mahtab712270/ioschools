<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<ioschoolsWebsite.Models.exam.templates.ExamTemplateViewModel>" MasterPageFile="~/Views/Shared/Internal.Master" %>
<asp:Content runat="server" ID="Title" ContentPlaceHolderID="TitleContent"><%= string.IsNullOrEmpty(Model.template.name)?"New Exam Template":"Edit Exam Template" %></asp:Content>
<asp:Content runat="server" ID="ExtraHeader" ContentPlaceHolderID="ExtraHeader"></asp:Content>
<asp:Content runat="server" ID="Main" ContentPlaceHolderID="MainContent">
<div class="mt10">
    <div class="breadcrumb"><a href="/exams">Exams</a> > <a href="/exams/templates">Exam Templates</a> > <%= string.IsNullOrEmpty(Model.template.name)?"New Exam Template":"Edit Exam Template" %></div>
<% if (string.IsNullOrEmpty(Model.template.name)) { %>
  <h2>New Exam Template</h2>
 <% }else{%>
 <div class="info">Modifying this template will <strong>not</strong> change any existing Exam Records previously created using this template.</div>
       <h2>Edit Exam Template</h2>
       
   <% } %>

<form id="addTemplateForm" action="/exams/templates/save" method="post" class="pb100">
    <div class="form_entry">
    <%= Html.CheckBox("isprivate", Model.template.isPrivate) %>
    <label for="private">template will only be visible to you (private)</label>
        </div>
<div class="form_entry">
    <div class="form_label">School</div>
    <%= Html.DropDownList("school", Model.schoolList) %>
        </div>
<div class="form_entry">
    <div class="form_label">
        Template Name <div class="tip">For example: Monthly English Test</div></div>
    <%= Html.TextBox("template_name", Model.template.name, new Dictionary<string, object>(){{"class","w500px"}})%>
</div>
<div class="form_entry">
    <div class="form_label">
        Description <div class="tip">Concise note about this template. E.g. when should  this template be used.</div></div>
    <%= Html.TextArea("description", Model.template.description, new Dictionary<string, object>() { { "class", "w700px" } })%>
</div>
<div class="form_entry">
    <div class="form_label">
        Maximum marks</div>
    <%= Html.TextBox("maxmark", Model.template.maxmark)%>
</div>
<div class="form_entry">
    <div class="form_label">
        Exam Subjects</div>
        <div class="tip">To sort subjects, click, hold and drag subjects to required position.</div>
        <table id="subject_table" class="table_grey">
        <thead>
        <tr><td>Exam Subject Name</td><td>Subject Code</td><td>Subject Name</td><td></td></tr>
        </thead>
        <tbody id="template_subjects">
        <% Html.RenderPartial("SubjectRows", Model.template.subjects); %>
        </tbody>
        <tfoot>
        <tr><td colspan="4"><a id="addRow" class="icon_add" href="#">add subject</a></td></tr>
        </tfoot>
        </table>
</div>
<div class="buttonRow_bottom">
    <span class="mr10">
        <button type="button" id="buttonSave" class="ajax large">
           <img class="am" src="/Content/img/icons/save.png" /> save</button>
    </span>
</div>
<%= Html.Hidden("id", Model.template.id) %>
</form>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        ioschools.util.setNavigation('#nexams', 'selected_link');
        init_inputSelectors();
        init_autogrow('#addTemplateForm');

        $('#description', '#addTemplateForm').limit(500);
        $('#maxmark', '#addTemplateForm').numeric();

        $('#buttonSave').click(function () {
            $(this).trigger('submit');
        });

        $('#addRow').click(function () {
            var schoolid = $('#school').val();
            if (schoolid == '') {
                $.jGrowl('Please specify a school');
                return false;
            }

            $(this).post('/exams/templates/editrow/', { schoolid: schoolid }, function (result) {
                $('#subject_table tbody').append(result);
                init_inputSelectors('#subject_table');
            });
            return false;
        });

        initsort();
    });
    
    // Return a helper with preserved width of cells
    var fixHelper = function(e, ui) {
        ui.children().each(function() {
            $(this).width($(this).width());
        });
        return ui;
    };
    
    function initsort() {
        var templateid = $('#id').val();
        if (templateid != '') {
            $("#subject_table tbody").sortable({
                helper: fixHelper,
                update: function () {
                    var order = $('#subject_table tbody').sortable('serialize');
                    $.post('/exams/templates/order', { id: templateid, ids: order }, function (json_result) {
                        $.jGrowl(json_result.message);
                    }, 'json');
                }
            });
        }
    };

    $('.jqdelete', '#subject_table').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        if (id == '' || id == undefined) {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        }
        else {
            var ok = window.confirm("Are you sure?");
            if (!ok) {
                return false;
            }
            $(this).post('/exams/templates/deletesubject/' + id, null, function (json_result) {
                if (json_result.success) {
                    $(row).fadeOut('fast', function () {
                        $(this).remove();
                    });
                }
                $.jGrowl(json_result.message);
            });
        }
        return false;
    });

    $('.jqedit', '#subject_table').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        var schoolid = $('#school').val();
        if (schoolid == '') {
            $.jGrowl('Please specify a school');
            return false;
        }
        
        $(this).post('/exams/templates/editrow/' + id,{ schoolid: schoolid}, function (result) {
            $(row).fadeOut('fast', function () {
                row.replaceWith($(result));
            });
        });
        return false;
    });

    $('#addTemplateForm').submit(function () {
        var ok = $('#addTemplateForm').validate({
            invalidHandler: function (form, validator) {
                $(validator.invalidElements()[0]).focus();
            },
            focusInvalid: false,
            rules: {
                template_name: {
                    required: true
                },
                description: {
                    required: true
                },
                maxmark: {
                    required: true
                },
                school: {
                    required: true
                }
            }
        }).form();
        if (!ok) {
            return false;
        }


        var action = $(this).attr("action");
        var serialized = $(this).serialize();

        // post form
        $.ajax({
            type: "POST",
            url: action,
            data: serialized,
            dataType: 'json',
            context: $('#buttonSave'),
            success: function (json_data) {
                if (json_data.success) {
                    window.location = '/exams/Templates/edit/' + json_data.data;
                }
                $.jGrowl(json_data.message);
            }
        });
        return false;
    });         // submit
</script>
</asp:Content>
