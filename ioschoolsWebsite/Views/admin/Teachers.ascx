﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<SelectListItem>>" %>
<div id="teachers_container">
<h2 class="mt10">Subject Teachers</h2>
<p>Assign subject teachers to limit permissions to selected subject. The classes taught for that subject must also be specified.</p>
<div class="content_filter">
    <form action="/subjects/teachers" method="post" class="mt20">
<div class="filter mt20">
        <h4 class="acc">
            School</h4>
            <%= Html.DropDownList("schoolList", Model) %>
    </div>
    <div class="filter mt20">
        <h4 class="acc">
            Year</h4>
        <%= Html.TextBox("year", DateTime.UtcNow.Year) %>
    </div>
    <div class="mt10">
    <button id="buttonSearch" type="button" class="ajax">List Teachers</button>
    </div>
    </form>
</div>
<div class="main_columnright">
    <div class="mt10 mb10">
        <button id="teacherMigrate" type="button"><img class="am" src="/Content/img/icons/continue.png" /> copy to next year</button>
    </div>
<table id="teachersTable" class="table_grey">
<thead>
<tr><td class="w200px">Subject</td><td>Teacher</td><td class="w100px"></td></tr>
</thead>
<tbody id="teachers_content">

</tbody>
</table>
</div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#year', '#teachers_container').numeric();
    });

    $('#teacherMigrate', '#teachers_container').click(function () {
        $.jGrowl('Feature not available');
        $.post('/error/log/', { message: 'Teacher migrate clicked', loaded: ioschools.pageloaded });
    });

    $('#buttonSearch', '#teachers_container').bind('click', function () {
        var year = $('#year', '#teachers_container').val();
        if (year == '') {
            $.jGrowl('Please specify year');
            return;
        }
        var school = $('#schoolList', '#teachers_container').val();
        if (school == '') {
            $.jGrowl('Please specify school');
            return;
        }
        
        $(this).post('/admin/teachersContent', { year: year, school: school }, function (result) {
            $('#teachers_content').html(result);
        });
    });

    $('.jqedit', '#teachers_container').live('click', function () {
        var row = $(this).closest('tr');
        var id = $(row).attr('alt');
        var subjectid = $('#subjectid', row).val();
        var year = $('#year', '#teachers_container').val();
        if (year == '') {
            $.jGrowl('Please specify year');
            return false;
        }
        var school = $('#schoolList', '#teachers_container').val();
        if (school == '') {
            $.jGrowl('Please specify school');
            return false;
        }
        
        $(this).getx('/subjects/teachersedit', { id: id, subject: subjectid, year: year, school: school}, function (result) {
            $(row).fadeOut('fast', function () {
                $(row).after(result);
                $(this).remove();
            });
        });
        return false;
    });

    $('#buttonSave', '#teachers_container').live('click', function () {
        var year = $('#year', '#teachers_container').val();
        if (year == '') {
            $.jGrowl('Please specify year');
            return false;
        }

        var row = $(this).closest('tr');

        var datarows = $('#tsubject_editor > li', row);
        var subjectid = $('#subjectid', row).val();
        var data = {
            subjectid: subjectid,
            year: year
        };

        var teachers = [];
        var errorname = '';
        $.each(datarows, function () {
            var tid = $('#teacher', this).val();
            var classes = $('#sclass', this).map(function () {
                return $(this).val();
            }).toArray();

            if (classes.length == 0) {
                errorname = $("#teacher option:selected", this).text();
                return false;
            }

            var teacher = {
                id: tid,
                classes: classes
            };
            teachers.push(teacher);
        });

        if (errorname != '') {
            $.jGrowl('You need to allocate a class to ' + errorname);
            return false;
        }

        data.teachers = teachers;
        var school = $('#schoolList', '#teachers_container').val();
        if (school == '') {
            $.jGrowl('Please specify school');
            return false;
        }

        $.ajax({
            contentType: 'application/json',
            type: "POST",
            url: '/subjects/teacherssave',
            context: $('#buttonSave', '#teachers_container'),
            dataType: "json",
            data: JSON.stringify(data),
            success: function (json_result) {
                if (json_result.success) {
                    $('#teachers_content').showLoadingBlock(true);
                    $.post('/admin/teacherscontent', { year: year, school: school }, function (result) {
                        $('#teachers_content').html(result);
                    });
                }
                $.jGrowl(json_result.message);
            }
        });

        return false;
    });

    $('#buttonCancel', '#teachers_container').live('click', function () {
        $('#teachers_content').showLoadingBlock(true);
        var year = $('#year', '#teachers_container').val();
        if (year == '') {
            $.jGrowl('Please specify year');
            return false;
        }
        var school = $('#schoolList', '#teachers_container').val();
        if (school == '') {
            $.jGrowl('Please specify school');
            return false;
        }
        
        $(this).post('/admin/teacherscontent', { year: year, school: school }, function (result) {
            $('#teachers_content').html(result);
        });
        
        return false;
    });

    // when editing rows
    $('.class_add', '#teachers_container').live('click', function () {
        var cell = $(this).closest('div');
        var row = $(this).closest('li');
        var id = $('#schoolclass', cell).val();
        var name = $('#schoolclass option[value=' + id + ']', cell).text();

        if ($('.allocatedclasses #sclass[value=' + id + ']', row).length != 0) {
            $.jGrowl(name + ' has already been added');
            return false;
        }

        var tag = ['<span class="tag">', name, '<input type="hidden" name="sclass" id="sclass" value="', id ,'" /></span>'];
        $('.allocatedclasses', row).append(tag.join(''));
        
        return false;
    });

    $('.teacher_add', '#teachers_container').live('click', function () {
        var body = $(this).closest('td');

        var cloned = $('#tsubject_spare > li', body).clone().attr('id', '').removeClass('hidden');
        $('#tsubject_editor', body).append(cloned);

        return false;
    });

    $('.teacher_delete', '#teachers_container').live('click', function () {
        var row = $(this).closest('li');
        $(row).remove();
        return false;
    });

    $('.tag', '#tsubject_editor').live('click', function () {
        var ok = window.confirm('Remove this class?');
        if (!ok) {
            return false;
        }
        $(this).remove();
        return false;
    });
    
</script>

