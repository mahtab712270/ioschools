<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Models.IdName>" %>
<div id="variantsDialog">
<div  id="relationship" class="form_entry">
    <div class="form_label">
        Relationship</div>
        <select>
        <option value="">Select relationship</option>
        <option value="1">Father</option>
        <option value="2">Mother</option>
        <option value="4">Guardian</option>
        </select>
</div>
    <div id="search_area">
    <span class="search"></span>
                    <input type="text" id="searchbox" name="searchbox" />
    </div>
    <div class="clear mt20"></div>
<div class="fixedHeight scroll_y">

</div>
<div class="clear">
</div>
<div id="buttons" class="mt10">
<button type="button" onclick="dialogBox_close();">close</button>
</div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        // init height
        var height = $(window).height();
        var buttonHeight = $('#buttons', '#variantsDialog').height();
        var relationshipheight = $('#relationship', '#variantsDialog').height();
        var searchheight = $('#search_area', '#variantsDialog').height();
        var fixedHeight = height - buttonHeight - relationshipheight - searchheight - 210; // dialog padding
        $('.fixedHeight', '#variantsDialog').height(fixedHeight);
        $('#searchbox').watermark("Enter children's name");
    });

    var searchtimer;
    var searchterm = "";
    // login name availability check
    $('#searchbox').keyup(function () {
        searchterm = $('#searchbox').val();

        if (searchtimer !== undefined) {
            clearTimeout(searchtimer);
        }
        searchtimer = setTimeout(function () {
            $.post("/users/childrencontent", { term: searchterm }, function (result) {
                $('.fixedHeight', '#variantsDialog').html(result);
            });
        }, 500);
    }).bind('focus', function () {
        $(this).siblings().addClass('searchfocused');
    }).bind('blur', function () {
        $(this).siblings().removeClass('searchfocused');
    });

    $('.fixedHeight', '#variantsDialog').scroll(function () {
        var elem = $(this);
        if (elem[0].scrollHeight - elem.scrollTop() != elem.outerHeight()) {
            // We're not at bottom
            return false;
        }
        $(this).showLoadingBlock();

        // get highest productid
        var maxid = $('.blockSelectable:last', '#variantsDialog').attr('alt');
        $.post('/users/childrencontent', { term: searchterm, sinceid: maxid }, function (result) {
            $(elem).removeLoading();
            $('.fixedHeight', '#variantsDialog').append(result);
            return false;
        });
    });

    $('.blockSelectable', '#variantsDialog').die().live('click', function () {
        var relationship = $('#relationship select', '#variantsDialog').val();
        if (relationship == '') {
            $.jGrowl('Please select a relationship');
            $('#relationship select', '#variantsDialog').focus();
            return false;
        }

        var id = $(this).attr('alt');
        var name = $('p', this).text();

        var html = ["<tr>", "<td>", name, "<input type='hidden' name='child' value='", id, "' /><input type='hidden' name='childrel' value='", relationship, "' /> </td>",
                    "<td class='ar'><a class='assign_del' href='#'>delete</a></td>", "</tr>"];
        $('tbody', '#children').append(html.join(''));
        dialogBox_close();
    });
</script>