﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<SelectListItem>>" %>
<div id="feeupdate_container" class="mt10">
<div class="content_filter">
<div class="filter">
        <h4 class="acc">
            School</h4>
        <%= Html.DropDownList("schoolList", Model, new Dictionary<string, object>(){{"autocomplete","off"}}) %>
    </div>
    <div class="filter">
        <h4 class="acc">
            School Year</h4>
        <select id="schoolyear" disabled="disabled">
            
        </select>
    </div>
    <div class="filter mt20">
        <h4 class="acc">
            Fee Type</h4>
        <select id="feetype" disabled="disabled">
            
        </select>
    </div>
    <div class="filter mt20">
        <h4 class="acc">
            Year</h4>
        <%= Html.TextBox("year", DateTime.Now.Year) %>
    </div>
    <div class="mt10">
    <button id="buttonSearch" type="button" class="ajax">Get Students</button>
    </div>
</div>
<div class="main_columnright">
<div id="fee_content" class="mb20">
</div>
</div>

</div>
<script type="text/javascript">
    
    $(document).ready(function () {
        
        $('#year', '#feeupdate_container').numeric();
    });

    $('#schoolList', '#feeupdate_container').change(function () {
        $('#schoolyear', '#feeupdate_container').html('');
        $('#feetype', '#feeupdate_container').html('');
        $('#schoolyear', '#feeupdate_container').attr('disabled', true);
        $('#feetype', '#feeupdate_container').attr('disabled', true);

        var id = $(this).val();
        if (id == '') {

            return;
        }

        // get years
        $(this).post('/schools/years/' + id, null, function (json_result) {
            if (json_result.success) {
                $.each(json_result.data, function () {
                    var option = ["<option value='", this.id, "'>", this.name, "</option>"];
                    $('#schoolyear', '#feeupdate_container').append(option.join(''));
                });
                if (json_result.data.length != 0) {
                    $('#schoolyear', '#feeupdate_container').attr('disabled', false);
                }
            }
        }, 'json');

        // get fee types
        $(this).post('/finance/fees/' + id, null, function (json_result) {
            if (json_result.success) {
                $.each(json_result.data, function () {
                    var option = ["<option value='", this.id, "'>", this.name, "</option>"];
                    $('#feetype', '#feeupdate_container').append(option.join(''));
                });
                if (json_result.data.length != 0) {
                    $('#feetype', '#feeupdate_container').attr('disabled', false);
                    $('#feetype', '#feeupdate_container').prepend("<option value=''></option>");
                }
            }
        }, 'json');
    });

    $('#schoolyear', '#feeupdate_container').change(function () {
        $('#feetype', '#feeupdate_container').val('');
    });

    $('#buttonSearch', '#feeupdate_container').bind('click', function () {
        var year = $('#year', '#feeupdate_container').val();
        if (year == '') {
            $.jGrowl('Please enter a year');
            return;
        }
        var school = $('#schoolList', '#feeupdate_container').val();
        if (school == '') {
            $.jGrowl('Please select School');
            return;
        }
        
        var schoolyear = $('#schoolyear', '#feeupdate_container').val();
        if (schoolyear == '' || schoolyear == null) {
            $.jGrowl('Please select School Year');
            return;
        }
        
        var feetype = $('#feetype', '#feeupdate_container').val();
        if (feetype == '' || feetype == null) {
            $.jGrowl('Please specify a fee');
            return;
        }

        $('#fee_content', '#feeupdate_container').showLoadingBlock(true);

        $(this).getx('/finance/bulkupdate',
            {
                year: year,
                schoolyear: schoolyear,
                feeid: feetype
            }, function (result) {
                $('#fee_content', '#feeupdate_container').html(result);
            }, 'html');
    });

    $('.jqedit', '.fee_row').live('click', function () {
        var row = $(this).closest('.fee_row');
        var id = $(row).attr('alt');
        $(this).getx('/schoolfees/edit/' + id, function (result) {
            $(row).fadeOut('fast', function () {
                row.replaceWith($(result));
            });
        });
        return false;
    });
    
</script>
