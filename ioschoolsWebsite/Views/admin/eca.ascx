<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.eca.ECAViewModel>" %>
<div id="eca_container">
<h2 class="mt10">Extra Curricular Activity</h2>
<p>Manage predefined extra-curricular activities.</p>
<div class="content_filter">

<div class="filter mt20">
        <h4 class="acc">
            Filter by</h4>
            <%= Html.DropDownList("schoolList", Model.schools) %>
    </div>
</div>
<div class="main_columnright">
    <div class="mt10 mb10">
        <button id="ecaAdd" type="button"><img class="am" src="/Content/img/icons/plus.png" /> add ECA</button>
    </div>
<table id="ecaTable" class="table_grey">
<thead>
<tr><td class="w150px">School</td><td>Name</td><td></td></tr>
</thead>
<tbody id="eca_content">
<% Html.RenderPartial("ecaContent", Model.ecas);%>
</tbody>
</table>
</div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
    });

    $('#schoolList', '#eca_container').bind('change', function () {
        $(this).post('/admin/ecaContent/' + $(this).val(), function (result) {
            $('#eca_content').html(result);
        });
    });

    $('#ecaAdd').click(function () {
        $(this).getx('/eca/edit', function (result) {
            $('tbody', '#ecaTable').prepend(result);
            $('#name', '#ecaTable').limit(100);
            init_inputSelectors('#ecaTable');
        });
        return false;
    });

    $('.jqedit', '#eca_container').live('click', function () {
        var ok = window.confirm('Are you sure? This will ALSO change the ECA for ALL students.');
        if (!ok) {
            return false;
        }
        var row = $(this).parents('tr');
        var id = $(row).attr('alt');
        $(this).getx('/eca/edit/' + id, function (result) {
            $(row).fadeOut('fast', function () {
                $(row).after(result);
                $(this).remove();
            });
        });
        return false;
    });

    $('.jqdelete', '#eca_container').live('click', function () {
        var ok = window.confirm('Are you sure? This will ALSO delete this ECA from ALL students. There is NO UNDO.');
        if (!ok) {
            return false;
        }

        var row = $(this).parents('tr');
        var id = $(row).attr('alt');

        $(this).post('/eca/delete/' + id, function (json_result) {
            if (json_result.success) {
                $(row).fadeOut('fast', function () {
                    $(this).remove();
                });
            }
            $.jGrowl(json_result.message);
        }, 'json');

        return false;
    });

    $('#buttonSave', '#eca_container').die().live('click', function () {
        var row = $(this).parents('tr');
        var school = $('#schools', row).val();
        var name = $('#name', row).val();
        var id = $(row).attr('alt');
        $(this).post('/eca/save/' + id, { school: school, name: name }, function (json_result) {
            if (json_result.success) {
                $('#eca_content').showLoadingBlock(true);
                $.post('/admin/ecacontent', function (result) {
                    $('#eca_content').html(result);
                });
            }
            $.jGrowl(json_result.message);
        }, 'json');
        return false;
    });

    $('#buttonCancel', '#eca_container').die().live('click', function () {
        $('#eca_content').showLoadingBlock(true);
        $(this).post('/admin/ecacontent', function (result) {
            $('#eca_content').html(result);
        });
        return false;
    });

</script>
