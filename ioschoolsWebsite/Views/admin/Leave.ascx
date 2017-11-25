﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<div id="leave_container">
<h2 class="mt10">Staff Leave</h2>
<p>Maintain predefined types of leaves. A leave with no default annual total means only the total taken is tracked, eg. Unpaid Leave.</p>
<p>The default annual total can be changed later when assigning the leave type to each staff.</p>
    <div class="mt10 mb10">
        <button id="leaveAdd" type="button"><img class="am" src="/Content/img/icons/plus.png" /> add leave</button>
        <button id="leaveMigrate" type="button"> yearly update</button>
    </div>
<table id="leaveTable" class="table_grey">
<thead>
<tr><td>Name</td><td class="w150px">Default Annual Total</td><td class="w175px"></td></tr>
</thead>
<tbody id="leave_content">
<% Html.RenderAction("LeaveContent");%>
</tbody>
</table>
</div>
<script type="text/javascript">
    $(document).ready(function () {
    });

    $('#leaveMigrate', '#leave_container').click(function () {
        $.jGrowl('Feature not available');
        $.post('/error/log/', { message: 'Leave migrate clicked', loaded: ioschools.pageloaded });
    });

    $('#leaveAdd').click(function () {
        $(this).getx('/leave/edit', function (result) {
            $('tbody', '#leaveTable').prepend(result);
            $('#name', '#leaveTable').limit(100);
            $('#total', '#leaveTable').numeric();
            init_inputSelectors('#leaveTable');
        });
        return false;
    });

    $('.jqedit', '#leave_container').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        $(this).getx('/leave/edit/' + id, function (result) {
            $(row).fadeOut('fast', function () {
                $(row).after(result);
                $('#name', '#leaveTable').limit(100);
                $('#total', '#leaveTable').numeric();
                $(this).remove();
            });
        });
        return false;
    });

    $('.jqdelete', '#leave_container').live('click', function () {
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');

        $(this).post('/leave/delete/' + id, function (json_result) {
            if (json_result.success) {
                $(row).fadeOut('fast', function () {
                    $(this).remove();
                });
            }
            $.jGrowl(json_result.message);
        }, 'json');

        return false;
    });

    $('#buttonSave', '#leave_container').die().live('click', function () {
        var row = $(this).parents('tr');
        var name = $('#name', row).val();
        var total = $('#total', row).val();
        var id = $(row).attr('alt');
        $(this).post('/leave/save/' + id, { name: name, total: total }, function (json_result) {
            if (json_result.success) {
                $('#leave_content').showLoadingBlock(true);
                $(this).post('/admin/leavecontent', function (result) {
                    $('#leave_content').html(result);
                });
            }
            $.jGrowl(json_result.message);
        }, 'json');
        return false;
    });

    $('#buttonCancel', '#leave_container').die().live('click', function () {
        $('#leave_content').showLoadingBlock(true);
        $(this).post('/admin/leavecontent', function (result) {
            $('#leave_content').html(result);
        });
        return false;
    });

</script>

