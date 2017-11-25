﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Schools
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="nav_side mt20">
        <ul>
            <li><a href="/kindergarten"> Kindergarten</a></li>
            <li><a href="/primary"> Primary</a></li>
            <li><a href="/secondary"> Secondary</a></li>
            <li><a href="/international"> International</a></li>
            <li><a href="/schools/eca">Extra-curricular Activities</a></li>
        </ul>
    </div>
    <div class="col_2 ml20 mt10">
        <h1> Group of Schools</h1>
        <div class="breadcrumb">
<a href="/">Home</a> / Schools
    </div>

<div class="school">
        <h3 id="kindergarten">
            <a href="/kindergarten"> Kindergarten</a>
        </h3>
    </div>
    <div class="school">
        <h3 id="primary">
            <a href="/primary"> Primary</a>
        </h3>
    </div>
    <div class="school">
        <h3 id="secondary">
            <a href="/secondary"> Secondary</a>
        </h3>
    </div>
    <div class="school">
        <h3 id="international">
            <a href="/international"> International</a>
        </h3>
    </div>
</div>
    <script type="text/javascript">
        $('#kindergarten').die().live('click', function () {
            window.location = '/kindergarten';
        });
        $('#primary').die().live('click', function () {
            window.location = '/primary';
        });
        $('#secondary').die().live('click', function () {
            window.location = '/secondary';
        });
        $('#international').die().live('click', function () {
            window.location = '/international';
        });
    </script>
</asp:Content>
