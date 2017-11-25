<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage" MasterPageFile="~/Views/Shared/Main.Master" %>

<asp:Content runat="server" ID="Title" ContentPlaceHolderID="TitleContent">
 Extra-curricular activities
</asp:Content>
<asp:Content runat="server" ID="ExtraHeader" ContentPlaceHolderID="ExtraHeader">
</asp:Content>
<asp:Content runat="server" ID="Main" ContentPlaceHolderID="MainContent">
    <div class="nav_side mt20">
        <ul>
            <li><a class="selected" href="/schools/eca">About</a></li>
            <li><a href="/primary/eca"> Primary ECA Schedule</a></li>
            <li><a href="/secondary/eca"> Secondary ECA Schedule</a></li>
            <li><a href="/international/eca"> International ECA Schedule</a></li>
        </ul>
    </div>
    <div class="col_2 ml20 mt10">
        <div class="breadcrumb">
            <a href="/">Home</a> / <a href="/Schools">Schools</a> / Extra-curricular activities
        </div>
        <h1>
            Extra-curricular Activities</h1>
        <div class="img_border w250px fl">
            <div class="slider" style="height: 288px; width: 250px;">
                <img src="/Content/img/schools/primary/facility1.jpg" alt="" />
                <img src="/Content/img/schools/primary/facility2.jpg" alt="" />
                <img src="/Content/img/schools/primary/facility3.jpg" alt="" />
                <img src="/Content/img/schools/primary/facility4.jpg" alt="" />
                <img src="/Content/img/schools/primary/facility5.jpg" alt="" />
            </div>
        </div>
        <div style="width: 430px;" class="fl ml10">
            <p>
                All students are required to take part in extra-curricular activities. They can
                choose to participate in clubs, games, sports and uniformed bodies.
            </p>
            <p>
                ECA is an integral part of the school curriculum where all students are challenged
                through the participation in the various ECA programmes to:
            </p>
            <ul>
                <li>a) cultivate the spirit of leadership, competition, cooperation, collaboration and
                    teamwork</li>
                <li>b) promote the school values of Good Character and Academic Excellence</li>
            </ul>
            <p class="mt20">ECA takes place after school from 4.00 pm to 5.00 pm. They choose to participate in 
            Clubs, Sports and Uniformed Bodies.</p>
        </div>
        <div class="clear mb10"></div>
        <table class="table_grey">
        <thead>
        <tr><td>List of Clubs</td><td>List of Uniformed Bodies</td><td>List of Sports</td></tr>
        </thead>
        <tbody>
        <tr><td>
        <ul>
        <li>Art Club</li>
        <li>English/Debating Club</li>
        <li>Gavel Club</li>
        <li>Mathematic Club</li>
        <li>Science Club</li>
        <li>Inventors Club</li>
        <li>Coral Speaking Club</li>
        <li>Bahasa Malaysia Club</li>
        <li>Cookery Club</li>
        <li>Needlework Club</li>
        <li>Modern Dance Club</li>
        <li>Photography Club</li>
        <li>Moral Club</li>
        <li>Choir</li>
        <li>Religious Club</li>
        <li>Indonesian/Japanese/Korean Club</li>
        </ul>
        </td><td>
        <ul>
        <li>Red Crescent</li>
        <li>St. John's Ambulance</li>
        <li>Scout</li>
        <li>Boy's/Girl Brigade</li>
        <li>International Award</li>
        </ul>
        </td><td>
        <ul>
        <li>Athletics</li>
        <li>Swimming</li>
        <li>Futsal</li>
        <li>Netball</li>
        <li>Table Tennis</li>
        <li>Tennis</li>
        <li>Bowling</li>
        <li>Wushu</li>
        <li>Taekwando</li>
        <li>Badminton</li>
        <li>Basketball</li>
        </ul>
        </td></tr>
        </tbody>
        </table>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.slider').nivoSlider({
                controlNav: false,
                directionNav: false,
                pauseTime: 5000,
                pauseOnHover: false
            });
        });
    </script>
</asp:Content>
