<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<button id="ecaAdd" type="button"><img class="am" src="/Content/img/icons/plus.png" /> add eca entry</button>
<script type="text/javascript">
    $('#ecaAdd').click(function () {
        var studentid = $('#studentid').val();
        var year = $('#eca_year_select').val();
        $(this).post('/eca/editstudent', { studentid: studentid, year: year }, function (json_result) {
            if (json_result.success) {
                $('.norow', '#ecaTable').remove();
                $('#ecaTable').prepend(json_result.data);
                init_autogrow('#ecaTable');
                init_inputSelectors();
            } else {
                $.jGrowl(json_result.message);
            }
        });
    });

    $('.jqedit', '#ecaTable').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        $(this).post('/eca/editstudent/' + id, function (json_result) {
            if (json_result.success) {
                $(row).fadeOut('fast', function () {
                    $(row).after(json_result.data);
                    $(this).remove();
                });
            }
            else {
                $.jGrowl(json_result.message);
            }
        });
    });

    $('.jqdelete', '#ecaTable').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        if (id == '' || id == null) {
            $(row).fadeOut('fast', function () {
                $(this).remove();
            });
        }
        else {
            var ok = window.confirm('This will also delete any related student attendance records. Are you sure?');
            if (!ok) {
                return false;
            }
            $(this).post('/eca/detach/' + id, function (json_result) {
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

    $('#buttonSave', '#ecaTable').die().live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        var studentid = $('#studentid').val();
        var post = $('#post', row).val();
        var school_eca = $('#school_eca', row).val();
        var year = $('#eca_year_select').val();
        var achievement = $('#achievement', row).val();
        var type = $('#type', row).val();
        var remarks = $('#remarks', row).val();

        if ($('#school', row).val() == '') {
            $.jGrowl('School not selected');
            return false;
        }
        
        if (type == '') {
            $.jGrowl('An entry type must be selected');
            return false;
        }

        if (school_eca == '' || school_eca == null) {
            $.jGrowl('Please select an ECA');
            return false;
        }

        $(this).post('/eca/savestudent/' + id, { studentid: studentid, post: post, school_eca: school_eca, year: year, achievement: achievement, type: type, remarks: remarks }, function (json_result) {
            if (json_result.success) {
                // reload the panel
                var div = $(row).parents("div[id^='ECA_']");
                $(div).load('/eca/showstudent/' + studentid + "?year=" + year);
            }
            $.jGrowl(json_result.message);
        }, 'json');
        return false;
    });

    $('#buttonCancel', '#ecaTable').die().live('click', function () {
        var row = $(this).parents('tr');
        var year = $('#eca_year_select').val();
        var div = $(row).parents("div[id^='ECA_']");
        var studentid = $('#studentid').val();
        $(div).load('/eca/showstudent/' + studentid + "?year=" + year);
        return false;
    });

    $('#school', '#ecaTable').die().live('change', function () {
        var row = $(this).parents('tr');
        var schoolid = $(this).val();
        if (schoolid != '') {
            $('#school_eca', row).html('');
            $(this).getx('/eca/list/' + schoolid, function (json_result) {
                if (json_result.success) {
                    $('#school_eca', row).html('<option value="">select eca</option>');
                    $.each(json_result.data, function () {
                        var option = ["<option value='", this.id, "'>", this.name, "</option>"];
                        $('#school_eca', row).append(option.join(''));
                    });
                }
                else {
                    $.jGrowl(json_result.message);
                }
            }, 'json');
        }
    });
</script>