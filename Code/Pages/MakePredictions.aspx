<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/MasterPage.master" CodeFile="MakePredictions.aspx.cs" Inherits="Pages_MakePredictions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style type="text/css">
        table th,tr {
            text-align:center; 
            padding:10px;
        }
        table td {
            border-bottom:2px solid darkgreen;
            padding:10px;
        }
        .txtSearchTeam {
            border-radius:3px;
            margin-left:30%;
            color:grey;
            width:300px;
            height:30px;
            background-color:lightyellow;
            border-color:Orange;
        }
           .btnDisable
        {
            color: lightgrey;
            font-weight: bold;
            cursor: not-allowed !important;
            background-color: transparent;
            border: 1px solid lightgrey;
        }
        .btnEnable
        {
            color: Orange;
            font-weight: bold;
            cursor: pointer;
            background-color: transparent;
            border: 1px solid Orange;
        }
                .hide
        {
            display:none;
            }
</style>
 <script type="text/javascript">
     function ShowAll() {
         var count = 1;
         $('.clsGrid tr').each(function (i, row) {
             if (count != 1) {
                 $(this).show();
             }
             else {
                 $(this).hide();
                 count = count + 1;
             }

         });
         //return false;
     }
     $(document).ready(function () {
         $('.txtSearchTeam').val("");
         $('.txtSearchTeam').keyup(function () {
             if ($.trim($(this).val()) != '') {
                 $('.clssearch').prop('disabled', false);
                 $('.clssearch').removeClass("btnDisable");
                 $('.clssearch').addClass("btnEnable");
             }
             else {
                 $('.clssearch').prop('disabled', true);
                 $('.clssearch').removeClass("btnEnable");
                 $('.clssearch').addClass("btnDisable");
             }

         });



         $('.txtSearchTeam').autocomplete({
             source: ['Mumbai Indians(MI)', 'Chennai Super Kings (CSK)', 'Rajasthan Royals(RR)', 'Royal Challengers(RCB)', 'Delhi Daredevils(DD)', 'Sunrisers Hyderabad(SRH)', 'Kings Punjab(KXIP)', 'Kolkata Knight Riders(KKR)']
         });
         $('.clssearch').click(function () {
             var team = $(this).prev().val().toString().toUpperCase();
             team = team.substring(team.indexOf('(') + 1, team.indexOf(')'));
             var count = 1;
             if (team.trim() == '') {
                 $('.clsGrid tr').each(function (i, row) {
                     if (count != 1) {
                         $(this).show();
                     }
                     else {
                         $(this).hide();
                         count = count + 1;
                     }

                 });
                 return false;
             }
             else {
                 $('.clsGrid tr').each(function (i, row) {

                     var row = $(row).find('.clsteams').eq(0).text().toUpperCase();

                     if (team.trim() == row.trim()){
                         //alert('matched');
                         $(this).show();
                     }
                     else {
                         //alert('not matched');
                         //$(this).css("display","none");
                         $(this).hide();
                     }
                     //                        if (count == 5) { return false; }
                     //count = count + 1;
                 });
             }
             return false;
         });


     });

    </script>
<div id="divPredictions" runat="server" style="z-index:1;position:absolute;width:100%;" >
    <div style="width:80%;height:60px;border-radius:5px;background-color:rgba(0,0,0,0.7);margin-bottom:2px;MARGIN-LEFT:10%;margin-top:15px;padding-top:12px;" data-step="1" data-intro="Hey :) Use this block to view your favourite players">
        <a class="class_name" href="javascript:void(0);" onclick="javascript:introJs().start();" style="margin-left:5px;">What's this?</a>
        <input id="txtbox1" class="txtSearchTeam" type="text" placeholder="Search Team Name"  data-step="2" data-intro="Start typing a team name here in this box" />
        <input type="submit" class="clssearch btnDisable" id="btnSearch" value="Search" style="border-radius:5px;width:100px;height:30px;"  data-step="3" data-intro="Hit this button to get filtered players list for selected team" />
           <a class="" href="javascript:void(0);" onclick="javascript:ShowAll();" style="margin-left:5px;">Show All</a>
    </div>
<div style="width:80%;margin-left:10%;"  data-step="4" data-intro="You will get your players list here :)">

<table style="width:100%" class="clsGrid1">
<tr style="color: rgb(247, 247, 247); font-weight: bold; background-color: rgb(74, 60, 140);">
<th style="text-align:center;width:100px">PlayerCode</th>
<th style="text-align:center;width:250px">Name</th>
<th style="text-align:center;width:200px">Nick Name</th>
<th style="text-align:center;width:100px">Team</th>
</tr>
</table>
<div style="width:100%;max-height:400px;overflow:auto;">
        <asp:GridView ID="GridView1" CssClass="clsGrid" style="width:100%; text-align:center; " runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
            BorderStyle="Double" BorderWidth="2px" CellPadding="10" CellSpacing="10" GridLines="Horizontal"  >
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <HeaderStyle CssClass="hide" />
            <Columns>
                <asp:BoundField DataField="PlayerCode" HeaderText="Match No" ItemStyle-Width="100px" />
                <asp:BoundField DataField="Name" HeaderText="Teams"  ItemStyle-Width="250px" />
                <asp:BoundField DataField="NickName" HeaderText="Toss" ItemStyle-Width="200px" />
                <asp:BoundField DataField="Team" HeaderText="Match Date" ItemStyle-Width="100px" ItemStyle-CssClass="clsteams" />
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>
      </div>    
    </div>
</div>

</asp:Content>