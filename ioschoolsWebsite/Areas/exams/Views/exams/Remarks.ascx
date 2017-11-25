<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ioschoolsWebsite.Areas.exams.Models.remarks.StudentRemarksViewModel>" %>
<div class="mt10" id="remark_year_selector_<%= Model.studentid %>">
    <%=Html.DropDownList("remark_year_select", Model.years, new Dictionary<string, object>(){{"autocomplete", "off"}})%>
</div>
<div id="remark_results_<%= Model.studentid %>" class="mt10">
    <%
       Html.RenderAction("RemarksContent", "Exams", new {Area = "Exams", id = Model.studentid, year = Model.year});%>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('select', '#remark_year_selector_<%= Model.studentid %>').bind('change', function() {
            var selected = $(this).val();
            $('#remark_results_<%= Model.studentid %>').showLoadingBlock(true);
            $(this).post('/exams/remarkscontent/<%= Model.studentid %>', { year: selected }, function(result) {
                $('#remark_results_<%= Model.studentid %>').html(result);
                bind_remarks_editor();
            });
        });
        bind_remarks_editor();
    });
    
    function bind_remarks_editor() {
            <% if(Model.canEdit){ %>
            $('.editor_remark', '#remark_results_<%= Model.studentid %>').inlineEdit({
                    control: "textarea",
                    limit:1000,
                    save: function(e, data) {
                        var ok = window.confirm('Are you sure?');
                        var editor = this;
                        var oldvalue = $(editor).data('oldvalue.inlineedit');
                        if (!ok) {
                            return false;
                        }

                        var params = {
                            studentid: <%= Model.studentid %> ,
                            year: $('select', '#remark_year_selector_<%= Model.studentid %>').val(),
                            term: $(editor).parents('table').attr('term'),
                            remarks: data.value
                        };
                        return $.post('/exams/saveremark', params, function(json_result) {
                            $.jGrowl(json_result.message);
                            if (!json_result.success) {
                                $(editor).data('value.inlineedit', oldvalue);
                                $(editor).html(oldvalue);
                            }
                        });
                    }
                });

            $('.editor_conduct', '#remark_results_<%= Model.studentid %>').inlineEdit({
                    limit:1,
                    save: function(e, data) {
                        var ok = window.confirm('Are you sure?');
                        var editor = this;
                        var oldvalue = $(editor).data('oldvalue.inlineedit');
                        if (!ok) {
                            return false;
                        }

                        var params = {
                            studentid: <%= Model.studentid %>,
                            year: $('select', '#remark_year_selector_<%= Model.studentid %>').val(),
                            term: $(editor).parents('table').attr('term'),
                            conduct: data.value
                        };
                        return $.post('/exams/saveremark', params, function(json_result) {
                            $.jGrowl(json_result.message);
                            if (!json_result.success) {
                                $(editor).data('value.inlineedit', oldvalue);
                                $(editor).html(oldvalue);
                            }
                        });
                    }
            });
            <%} %>
        }
</script>