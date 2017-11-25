<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Internal.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content runat="server" ID="Title" ContentPlaceHolderID="TitleContent">
    Create Exam Record</asp:Content>
<asp:Content runat="server" ID="Main" ContentPlaceHolderID="MainContent">
    <div class="mt10 pb100">
        <div class="breadcrumb"><a href="/exams">Exams</a> > Create Exam Record</div>
        <h2 class="icon_blog">
            Create Exam Record</h2>
            <p>An exam record can be used to store public exam results, school tests or exams. </p>

        <form id="addExamForm" action="/exams/save" method="post" class="pb100" autocomplete="off" >
            <div class="w400px fl">
                <div class="form_entry">
            <div class="form_label">
                <label>
                    Exam Date</label>
            </div>
            <input type="text" name="exam_date" id="exam_date" />
        </div>
        <div class="form_entry">
            <div class="form_label">
                <label>
                    Exam Name</label>
                    <div class="tip">For example: English Test, July 2011</div>
            </div>
            <input type="text" name="exam_name" id="exam_name" class="w300px" />
        </div>
        <div class="form_entry">
            <div class="form_label">
                <label>
                    School</label>
            </div>
            <select id="selector_school" name="selector_school">
                <option value=''>Select School</option>
                <option value="1"> Kindergarten</option>
                <option value="2"> Primary</option>
                <option value="3"> Secondary</option>
                <option value="4"> International</option>
            </select>
        </div>
        <div id="template_container" class="form_entry hidden">
            <div class="form_label">
                <label>
                    Exam Template</label>
                    <div class="tip w300px">Contains a list of predefined subjects. Select from the following or <a href="/exams/templates"> create a new template</a>.</div>
            </div>
            <select id="selector_template" name="selector_template" class="w300px">
                
            </select>
        </div>
            </div>
            <div class="w500px fl">
                <div class="relative" style="height: 300px">
                    <div id="templatedetails" class="absolute bottom left">
                    
                </div>
                </div>
                
            </div>
        <div class="clear"></div>
        <% Html.RenderAction("selector", "classes", new { Area = "" }); %>
        <div id="remarks_container" class="form_entry hidden">
            <div class="form_label">
                <label>
                    Remarks</label>
                    <div class="tip">Additional information you may want to include</div>
            </div>
            <%= Html.TextArea("exam_remarks", "", new Dictionary<string, object>(){{"class","w500px"}}) %>
        </div>
        <div class="mt40">
                <button type="button" id="buttonSave" class="ajax large">
                    <img class="am" src="/Content/img/icons/save.png" />
                    create exam record</button>
            </div>
        <%= Html.Hidden("classes") %>
        <%= Html.Hidden("subjects") %>
        </form>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            ioschools.util.setNavigation('#nexams', 'selected_link');
            $('#exam_name').limit(100);
            $('#exam_remarks').limit(500);
            
            init_inputSelectors();
            init_autogrow();

            $('#buttonSave').click(function () {
                $(this).trigger('submit');
            });

            $("#exam_date", '#addExamForm').datepicker(
                {
                    dateFormat: 'D, d M yy'
                });

            $("#exam_date", '#addExamForm').attr('readonly', 'readonly');
        });

        $('#selector_template').bind('change', function () {
            var selected = $(this).val();
            if (selected == '') {
                $('#templatedetails').html('');
                return;
            }

            $('#templatedetails').showLoadingBlock(true);
            $(this).post('/exams/templates/details/' + selected, function (json_result) {
                if (json_result.success) {
                    $('#templatedetails').html(json_result.data);
                } else {
                    $.jGrowl(json_result.message);
                }
            });
        });

        $('#selector_template').bind("keyup", function (e) {
            var key;
            if (window.event) {
                key = window.event.keyCode;     //IE
            }
            else {
                key = e.which;     //firefox
            }
            if (key == 38 || key == 40) {
                $(this).trigger('change');
            }
        });

        $('#selector_school').bind("change", function () {
            var school = $(this).val();
            if (school != '') {
                selector_class_populate(school);
                $(this).post('/exams/templates/school/' + school, null, function (json_result) {
                    if (json_result.success) {
                        $('#selector_template').append('<option value="">Select a template</option>');
                        $.each(json_result.data, function (i, val) {
                            var option = ['<option value="', this.id, '">', this.name, '</option>'];
                            $('#selector_template').append(option.join(''));
                        });
                        $('#template_container,#remarks_container').show();
                    }
                    else {
                        $.jGrowl(json_result.message);
                    }
                }, 'json');

            }
            return false;
        });

        $('#addExamForm').submit(function () {
            var ok = $('#addExamForm').validate({
                invalidHandler: function (form, validator) {
                    $(validator.invalidElements()[0]).focus();
                },
                focusInvalid: false,
                rules: {
                    exam_name: {
                        required: true
                    },
                    selector_school: {
                        required: true
                    },
                    selector_template: {
                        required: true
                    }
                }
            }).form();
            if (!ok) {
                return false;
            }

            $('#classes').val(selector_classes.join(','));

            var action = $(this).attr("action");
            var serialized = $(this).serialize();

            // post form
            $.ajax({
                type: "POST",
                url: action,
                data: serialized,
                context: $('#buttonSave'),
                dataType: 'json',
                success: function (json_data) {
                    if (json_data.success) {
                        $.jGrowl("Exam created. Sending you to the exam record page.");
                        window.location = '/exams/' + json_data.data;
                    } else {
                        $.jGrowl(json_data.message);
                    }
                    
                    return false;
                }
            });
            return false;
        });       // submit

    
    </script>
</asp:Content>
