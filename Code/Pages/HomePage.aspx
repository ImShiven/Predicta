<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/MasterPage.master" ValidateRequest="false" CodeFile="HomePage.aspx.cs" Inherits="Pages_HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style type="text/css">
    .clstableteam {
        padding:0px !important;
        border-bottom:0px !important;  
        font-size:12px;      
        }
    .clstableteam td {
        padding:6px !important;
        border-bottom:0px !important;        
        }
   .modal1
    {
        position: fixed; 
        z-index: 1; 
        padding-top: 8% !important; 
        left: 0;
        top: 0;
        width: 100%; 
        height: 100%; 
        overflow: auto; 
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        overflow: hidden;
    }
    
    .modal-content1
    {
        background-color: #fefefe;
        margin-left: 25% !important;
        padding: 6px;
        border: 1px solid #888;
        width: 38% !important;
        max-height: 450px !important;
        overflow: auto;
    }
        table th,tr {
            text-align:center; 
            padding:10px;
        }
        table td {
            border-bottom:2px solid darkgreen;
            padding:10px;
        }
        table th
        {
            border-bottom-color:cadetblue;
            }
        .clsPoints
        {
            background-color: lightblue;
            color:Maroon;
            }
       .txtSearchTeam {
            border-radius:3px;
            margin-left:10%;
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
      function BindTeamTotalData() {
          //alert('enter');
          //$('#divOverlay').css('display','inline');
          var tblval = $('#' + '<%=hdnTable.ClientID%>').val();
          if (tblval != '') {
              $('#divInner').append(tblval);
              //alert('succeed');
          }
          else { alert('No Data'); }
      }

      $(document).ready(function () {
          $('#imgClose').click(function () {
              $('#divOverlay').css('display', 'none');
          });

          $('#' + '<%=lbTeam.ClientID%>').click(function () {
                      $('#divOverlay').css('display', 'inline');
                      return false;
                  });

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
              source: GetArrCodes()
          });
          function GetArrCodes() {
              var rawcodes = $('#' + '<%=hdnNames.ClientID%>').val();
              var i = rawcodes.lastIndexOf(",");
              if (i != -1) {
                  var codes = rawcodes.substring(0, i);
                  var arrCodes = codes.split(",");
              }
              else {
                  var arrCodes = [];
              }
              return arrCodes;
          }
          $('.clssearch').click(function () {

              var name = $(this).prev().val().toString().toUpperCase();
              var count = 1;
              if (name.trim() == '') {
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
                      //alert(row.toString());
                      //return false;
                      if (name.trim() == row.trim()) {
                          $(this).show();
                      }
                      else {
                          $(this).hide();
                      }
                      //if (count == 3) { return false; }
                      //count = count + 1;
                  });
              }
              return false;
          });


      });

    </script>
<div id="divTodaysMatches" runat="server" style="z-index:1;position:absolute;width:100%;" >
<div id="divHome" runat="server" >
    <div style="width:90%;height:60px;border-radius:5px;background-color:rgba(0,0,0,0.7);margin-bottom:2px;MARGIN-LEFT:5%;margin-top:15px;padding-top:12px;" data-step="1" data-intro="Hey :) Use this block to filter your predictions for last match">
        <a class="class_name" href="javascript:void(0);" onclick="javascript:introJs().start();" style="margin-left:5px;">What's this?</a>
                 <asp:LinkButton ID="lbTeam" style="color:orange;text-decoration:underline;margin-left:40px;" runat="server" 
             Text="View Team Level Score" data-step="5" data-intro="You can download your team's score data into an excel by hitting this link."
            ></asp:LinkButton>
        
        <input id="txtbox1" class="txtSearchTeam" type="text" placeholder="Your Name here"  data-step="2" data-intro="Search for your name here" />
        <input type="submit" class="clssearch btnDisable" id="btnSearch" value="Search" style="border-radius:5px;width:100px;height:30px;"  data-step="3" data-intro="Next, Hit this button" />
        <a class="" href="javascript:void(0);" onclick="javascript:ShowAll();" style="margin-left:5px;">Show All</a>
        <asp:LinkButton ID="lbdownload" style="float:right;color:orange;text-decoration:underline;" runat="server" 
            OnClick="lbdownload_Click" Text="Export to Excel" data-step="5" data-intro="Click to download page's data into excel"
            ></asp:LinkButton>
    </div>
<div style="width:90%;margin-left:5%;"  data-step="4" data-intro="You will get your predictions here :)">
<table style="width:100%" class="clsGrid1">
<tr style="color: rgb(247, 247, 247); font-weight: bold; background-color: rgb(74, 60, 140);">
<th style="text-align:left;width:20px">Rank</th>
<th style="text-align:left;width:90px">Name</th>
<th style="text-align:left;width:50px">Score</th>
<th style="text-align:left;width:65px">M.No.</th>
<%--<th style="text-align:left;width:60px">Day</th>--%>
<th style="text-align:left;width:100px">Date</th>
<th style="text-align:left;width:90px">Teams</th>
<th style="width:200px">Predictions</th>
<th style="width:200px">Results</th>
<th style="width:100px">Points</th>
</tr>
</table>
<div style="width:100%;max-height:400px;overflow:auto;">
 <asp:GridView ID="gvDashboard" CssClass="clsGrid" style="width:100%; text-align:center; " runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
            BorderStyle="Double" BorderWidth="2px" CellPadding="10" CellSpacing="10" GridLines="Horizontal" >
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <HeaderStyle CssClass="hide" />

            <Columns>
                <asp:BoundField DataField="Rank" ItemStyle-Width="40px" HeaderText="Rank" ItemStyle-CssClass="clsPoints"  />
                <asp:BoundField DataField="Name" ItemStyle-Width="90px" HeaderText="Name" ItemStyle-CssClass="clsteams" />
                <asp:BoundField DataField="Score" ItemStyle-Width="95px" HeaderText="Total Score"  />
                <asp:BoundField DataField="MatchNo" ItemStyle-Width="65px" HeaderText="M.No."/>
                <%--<asp:BoundField DataField="DAY" ItemStyle-Width="60px" HeaderText="Day" />--%>
                <asp:BoundField DataField="Date" ItemStyle-Width="100px" HeaderText="Date" />
                <asp:BoundField DataField="TEAMS" ItemStyle-Width="120px" HeaderText="Teams"/>
                <asp:BoundField DataField="Predictions" ItemStyle-Width="200px" HeaderText="Predictions" />
                <asp:BoundField DataField="Result" ItemStyle-Width="200px" HeaderText="Results" />
                <asp:BoundField DataField="Points" ItemStyle-Width="100px" HeaderText="Points"  />
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
</div>
<asp:HiddenField ID="hdnNames" runat="server" Value="" />
    <div id="divOverlay" class="modal1" style="display:none;z-index: 999999;position: -ms-page;width: 100%;">
    <image id="imgClose" src="../Images/tabclose.png" alt="close" style="width:20px;height:20px;margin-left:61.5%;margin-top:100px;border-radius:4px;background:white;cursor:pointer;"></image>
    <div id="divInner" class="modal-content1" style="width: 55%; margin-left: 25%; overflow: hidden;">
    </div>
    </div>
    <asp:HiddenField ID="hdnTable" runat="server" />
</asp:Content>