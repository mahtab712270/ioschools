<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Internal.Master" Inherits="System.Web.Mvc.ViewPage<ioschoolsWebsite.Models.enrolment.EnrolmentListViewModel>" %>
<asp:Content runat="server" ID="Title" ContentPlaceHolderID="TitleContent">Enrolment</asp:Content>
<asp:Content runat="server" ID="Main" ContentPlaceHolderID="MainContent">
<div id="content_result">
<div class="mt10">
    <h2>Enrolment Records</h2>
    <p>Each row shows an enrolment entry. Some students may have more than 1 enrolment entry, ie. leaving and then coming back to school.</p>
<div class="content_filter">
<button id="addEnrolment" type="button"><img class="am" src="/Content/img/icons/plus.png" /> add enrolment</button>
<form id="exportForm" method="post" action="/enrolment/export">
    <div id="schoolList" class="filter mt10">
        <h4 class="acc">
            Schools</h4>
            <%= Html.DropDownList("school", Model.schools) %>
    </div>
    <div class="filter mt10">
        <h4 class="acc">
            Enrolling For Class</h4>
        <select id="classyear" name="classyear"></select>
    </div>
    <div class="filter mt10">
        <h4 class="acc">
            Enrolling For Year</h4>
        <%= Html.DropDownList("yearList", Model.yearlist) %>
    </div>
    <div id="statusList" class="filter">
        <h4 class="acc">
            Status</h4>
        <select name="status">
        <option value=''>All</option>
<option selected="selected" value='pending'>Pending</option>
<option value="rejected">Rejected</option>
<option value="accepted">Accepted</option>
</select>
    </div>
    <div class="mt10">
    <button id="buttonExport" type="submit" title="exports enrolment information to excel">export <img src="/Content/img/icons/continue.png" class="am" /></button>
    <button type="button" onclick="reloadEnrolGrid();">search <img src="/Content/img/icons/continue.png" class="am" /></button>
    </div>
    </form>
</div>
<div class="main_columnright">
    <div id="search_area">
        <span class="search"></span>
        <input type="text" id="searchbox" name="searchbox" />
    </div>
    <div class="clear_right mt20"></div>
    <div id="grid_content">
        <table id="enrolGridView" class="scroll">
        </table>
        <div id="enrolGridNavigation" class="scroll ac">
        </div>
    </div>
</div>
</div>
<script type="text/javascript" src="/js/jqgrid.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        ioschools.util.setNavigation('#nenrolment', 'selected');
        pageInit();
        enrolBindToGrid();

        $('#buttonExport').click(function () {
            var ok = window.confirm('Export selected enrolment data?');
            if (!ok) {
                return false;
            }
            $(this).trigger('submit');
        });

        $('#searchbox').keyup(function (e) {
            if (!isEnterKey(e)) {
                return;
            }
            reloadEnrolGrid();
        }).bind('focus', function () {
            $(this).siblings().addClass('searchfocused');
        }).bind('blur', function () {
            $(this).siblings().removeClass('searchfocused');
        });
    });

    function pageInit() {
        $('#addEnrolment').click(function () {
            window.location = '/enrolment/add';
        });

        // bind side filter click events
        $('select', '.content_filter').bind("change", function () {
            if ($(this).parents('#schoolList').length != 0) {
                $('#classyear').html('');
                var id = $(this).val();
                if (id == '') {
                    return false;
                }
                $(this).post('/schools/years/' + id, null, function (json_result) {
                    if (json_result.success) {
                        $('#classyear').html('<option value="">select year</option>');
                        $.each(json_result.data, function () {
                            var option = ["<option value='", this.id, "'>", this.name, "</option>"];
                            $('#classyear').append(option.join(''));
                        });
                    }
                    else {
                        $.jGrowl(json_result.message);
                    }
                }, 'json');
            }
        });
    };
</script>
</div>
</asp:Content>
