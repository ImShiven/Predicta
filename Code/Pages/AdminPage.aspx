<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="AdminPage.aspx.cs" Inherits="Pages_AdminPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
   .grad
    {
        background: rgba(147,206,222,1);
        background: -moz-linear-gradient(top, rgba(147,206,222,1) 0%, rgba(147,206,222,1) 0%, rgba(73,165,191,1) 1%, rgba(79,168,194,1) 8%, rgba(117,189,209,0.69) 50%, rgba(117,189,209,0.39) 91%);
        background: -webkit-gradient(left top, left bottom, color-stop(0%, rgba(147,206,222,1)), color-stop(0%, rgba(147,206,222,1)), color-stop(1%, rgba(73,165,191,1)), color-stop(8%, rgba(79,168,194,1)), color-stop(50%, rgba(117,189,209,0.69)), color-stop(91%, rgba(117,189,209,0.39)));
        background: -webkit-linear-gradient(top, rgba(147,206,222,1) 0%, rgba(147,206,222,1) 0%, rgba(73,165,191,1) 1%, rgba(79,168,194,1) 8%, rgba(117,189,209,0.69) 50%, rgba(117,189,209,0.39) 91%);
        background: -o-linear-gradient(top, rgba(147,206,222,1) 0%, rgba(147,206,222,1) 0%, rgba(73,165,191,1) 1%, rgba(79,168,194,1) 8%, rgba(117,189,209,0.69) 50%, rgba(117,189,209,0.39) 91%);
        background: -ms-linear-gradient(top, rgba(147,206,222,1) 0%, rgba(147,206,222,1) 0%, rgba(73,165,191,1) 1%, rgba(79,168,194,1) 8%, rgba(117,189,209,0.69) 50%, rgba(117,189,209,0.39) 91%);
        background: linear-gradient(to bottom, rgba(147,206,222,1) 0%, rgba(147,206,222,1) 0%, rgba(73,165,191,1) 1%, rgba(79,168,194,1) 8%, rgba(117,189,209,0.69) 50%, rgba(117,189,209,0.39) 91%);
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#93cede', endColorstr='#75bdd1', GradientType=0 );
    }
        .hide {
            display:none;
        }
        .selEnable {
            border:1px solid orange !important;
            color:orange !important;
            background:transparent;
        }
          .tblJackpot td,th
        {
            padding:10px !important;
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
        overflow: auto;
    }
    
    .modal-content1
    {
        background-color: #fefefe;
        margin-left: 10% !important;
        padding: 3px;
        border: 1px solid #888;
        width: 72% !important;
        max-height: 600px !important;
        overflow: auto;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
 

        $('#btnPredictions').click(function () {
            if ($('#divPredictions').hasClass('hide')==true) { $('#divPredictions').removeClass('hide'); }
            if ($('#divUsers').hasClass('hide')==false) { $('#divUsers').addClass('hide'); }
            if ($('#divResult').hasClass('hide') == false) { $('#divResult').addClass('hide'); }
            if ($('#divParser').hasClass('hide') == false) { $('#divParser').addClass('hide'); }
            $('.clsSelection').removeClass('selEnable');
            $(this).addClass('selEnable');
            return false;
        });

        $('#btnResults').click(function () {
            if ($('#divResult').hasClass('hide') == true) { $('#divResult').removeClass('hide'); }
            if ($('#divUsers').hasClass('hide') == false) { $('#divUsers').addClass('hide'); }
            if ($('#divPredictions').hasClass('hide') == false) { $('#divPredictions').addClass('hide'); }
            if ($('#divParser').hasClass('hide') == false) { $('#divParser').addClass('hide'); }
            $('.clsSelection').removeClass('selEnable');
            $(this).addClass('selEnable');
            return false;
        });

        $('#btnUsers').click(function () {
            if ($('#divUsers').hasClass('hide') == true) { $('#divUsers').removeClass('hide'); }
            if ($('#divResult').hasClass('hide') == false) { $('#divResult').addClass('hide'); }
            if ($('#divPredictions').hasClass('hide') == false) { $('#divPredictions').addClass('hide'); }
            if ($('#divParser').hasClass('hide') == false) { $('#divParser').addClass('hide'); }
            $('.clsSelection').removeClass('selEnable');
            $(this).addClass('selEnable');
            return false;
        });

        $('#btnParser').click(function () {
            if ($('#divUsers').hasClass('hide') == false) { $('#divUsers').addClass('hide'); }
            if ($('#divResult').hasClass('hide') == false) { $('#divResult').addClass('hide'); }
            if ($('#divPredictions').hasClass('hide') == false) { $('#divPredictions').addClass('hide'); }
            if ($('#divParser').hasClass('hide') == true) { $('#divParser').removeClass('hide'); }
            $('.clsSelection').removeClass('selEnable');
            $(this).addClass('selEnable');
            return false;
        });
        $('#' + '<%=btnUploadFile.ClientID%>').click(function () {
            if ($('#' + '<%=flUploadUsersData.ClientID%>').val() != '')
            {
                //alert('yes');
                return true;
            }
            else
            {
                alert('Please browse a file to be uploaded !!');
                return false;
            }
            return false;
        });
        
        $('#' + '<%=btnClearData.ClientID%>').click(function () {
            $('#' + '<%=txtMNumber.ClientID%>').val('');
            $('#' + '<%=txtWinningTeamCode.ClientID%>').val('');
            $('#' + '<%=txtResultCode.ClientID%>').val('');
            $('#' + '<%=txtPoints.ClientID%>').val('');
            return false;
        });

        $('#' + '<%=btnUpdate.ClientID%>').click(function () {

            var t1 = $('#' + '<%=txtMNumber.ClientID%>').val().trim();
            var t2 = $('#' + '<%=txtWinningTeamCode.ClientID%>').val().trim();
            var t3 = $('#' + '<%=txtResultCode.ClientID%>').val().trim();
            var t4 = $('#' + '<%=txtPoints.ClientID%>').val().trim();

            if ((t1 == '') || (t2 == '') || (t3 == '') || (t4 == '')) {
                alert('Enter all fields to proceed !!');
                return false;
            }
            return true;
        });


        $('#' + '<%=btnClear.ClientID%>').click(function () {
            $('#' + '<%=txtMailId.ClientID%>').val('');
            $('#' + '<%=txtName.ClientID%>').val('');
            $('#' + '<%=txtGroup.ClientID%>').val('');
            
            return false;
        });

        $('#' + '<%=btnAdd.ClientID%>').click(function () {
            if (($('#' + '<%=txtMailId.ClientID%>').val().trim() == '') || ($('#' + '<%=txtName.ClientID%>').val().trim() == '') || ($('#' + '<%=txtGroup.ClientID%>').val().trim() == '')) {
                alert('Enter Both User Name and User Mail Id to proceed !!');
                return false;
            }
            return true;

        });

    });
</script>
   <div style="width:80%;height:60px;border-radius:5px;background-color:rgba(0,0,0,0.7);margin-bottom:2px;MARGIN-LEFT:10%;margin-top:15px;padding-top:12px;" data-step="1" data-intro="Hey :) Choose an action from this block">
        <a class="class_name" href="javascript:void(0);" onclick="javascript:introJs().start();" style="margin-left:5px;">What's this?</a>
      
       <input type="submit" class="clsSelection"  id="btnParser" value="Parse Predictions" style="cursor:pointer;background:transparent;color:white;border:1px solid white; border-radius:5px;width:200px;height:35px;"  data-step="5" data-intro="Hit this button to parse whatsapp predictions" />

        <input type="submit" class="clsSelection selEnable" id="btnPredictions" value="Upload Predictions" style="margin-left:15%; cursor:pointer; background:transparent;color:white;border:1px solid white;border-radius:5px;width:200px;height:35px;"  data-step="2" data-intro="Hit this button to upload predictions" />
       <input type="submit" class="clsSelection"  id="btnResults" value="Update Results" style="cursor:pointer;background:transparent;color:white;border:1px solid white;border-radius:5px;width:200px;height:35px;"  data-step="3" data-intro="Hit this button to upload results" />
       <input type="submit" class="clsSelection"  id="btnUsers" value="Add Participant" style="cursor:pointer;background:transparent;color:white;border:1px solid white; border-radius:5px;width:200px;height:35px;"  data-step="4" data-intro="Hit this button to add new user" />
    </div>
<div id="divResult" style="width:80%;height:400px;background-color:rgba(0,0,0,0.4);margin-left:10%;margin-top:2%;" class="hide">
<table class="grid" style="width:100%;height:25px;">
<tr class="grad">
<td style="padding:7px !important;text-align: center !important;">
<asp:Label ID="lblheadertext" Text="Update Match Results" Style="color: purple;font-size: 12PX; font-weight: bold;" runat="server"></asp:Label>
<asp:LinkButton ID="lbDownload" Text="Download Data" style="color: white; font-weight: bold; text-decoration: underline; float: right;" runat="server" OnClick="lbDownload_Click"></asp:LinkButton>
</td>
</tr>
</table>
<table class="grid" style="width:50%;height:100px;margin-left:25%;">
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="Label1" Text="Match Number : " Style="color: darkslategrey;font-size: 12PX; font-weight: bold;width:40%;" runat="server"></asp:Label>
</td>
<td style="text-align:center;">
<asp:TextBox ID="txtMNumber" runat="server" style="background-color:lightyellow;color:darkslategrey;width:250px;height:30px;border-radius:3px;" placeHolder="Enter Match Number"> </asp:TextBox>
</td>
</tr>
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="Label2" Text="Winning Team Code : " Style="width:40%;color: darkslategrey;font-size: 12PX; font-weight: bold;" runat="server"></asp:Label>
</td>
<td style="text-align:center;">
<asp:TextBox ID="txtWinningTeamCode" runat="server" style="border-radius:3px;width:250px;height:30px;background-color:lightyellow;color:darkslategrey;" placeHolder="Winning Team Code"></asp:TextBox>
</td>
</tr>
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="lblResult" Text="Match Result String : "  runat="server" Style="width:40%;color: darkslategrey;font-size: 12PX; font-weight: bold;"></asp:Label>
</td>
<td style="text-align:center;">
<asp:TextBox ID="txtResultCode" runat="server" style="border-radius:3px;width:250px;height:30px;background-color:lightyellow;color:darkslategrey;" placeHolder="Match Result String"></asp:TextBox>
</td>
</tr>
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="Label3" Text="Points weightage String : "  runat="server" Style="width:40%;color: darkslategrey;font-size: 12PX; font-weight: bold;"></asp:Label>
</td>
<td style="text-align:center;">
<asp:TextBox ID="txtPoints" runat="server" style="border-radius:3px;width:250px;height:30px;background-color:lightyellow;color:darkslategrey;" placeHolder="Points weightage string"></asp:TextBox>
</td>
</tr>
<tr style="background-color:rgba(0,0,0,0.5);">
<td style="text-align:center;" colspan=2>
<asp:Button ID="btnUpdate" Text="Update"  runat="server" 
        
        Style="width:30%;color: DarkOrange;font-size: 12PX; font-weight: bold;height:30px;" onclick="btnUpdate_Click"
      ></asp:Button>
<asp:Button ID="btnClearData" Text="Clear" OnClientClick="return false;"  runat="server" Style="background-color:darkgrey;width:30%;color: white;font-size: 12PX; font-weight: bold;height:30px;"></asp:Button>
</td>
</tr>
</table>
</div>
<div id="divUsers" style="width:80%;height:400px;background-color:rgba(0,0,0,0.4);margin-left:10%;margin-top:2%;" class="hide">
<table class="grid" style="width:100%;height:25px;">
<tr class="grad">
<td style="padding:7px !important;text-align: center !important;">
<asp:Label ID="Label4" Text="Add New User" Style="color: purple;font-size: 12PX; font-weight: bold;" runat="server"></asp:Label>
</td>
</tr>
</table>
<table class="grid" style="width:50%;height:100px;margin-left:25%;">
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="lnlName" Text="User Name : " Style="color: darkslategrey;font-size: 12PX; font-weight: bold;width:40%;" runat="server"></asp:Label>
</td>
<td style="text-align:center;">
<asp:TextBox ID="txtName" runat="server" style="background-color:lightyellow;width:250px;height:30px;color:darkslategray;border-radius:3px;" placeHolder="Enter User Name"> </asp:TextBox>
</td>
</tr>
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="lblMailId" Text="User MailId : " Style="width:40%;color: darkslategrey;font-size: 12PX; font-weight: bold;" runat="server"></asp:Label>
</td>
<td style="text-align:center;">
<asp:TextBox ID="txtMailId" runat="server" style="background-color:lightyellow;border-radius:3px;width:250px;height:30px;color:darkslategray;" placeHolder="Enter User MailId"></asp:TextBox>
</td>
</tr>
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="lblGrp" Text="Group Code : " Style="width:40%;color: darkslategrey;font-size: 12PX; font-weight: bold;" runat="server"></asp:Label>
</td>
<td style="text-align:center;">
<asp:TextBox ID="txtGroup" runat="server" style="background-color:lightyellow;border-radius:3px;width:250px;height:30px;color:darkslategray;" placeHolder="Enter Group Code"></asp:TextBox>
</td>
</tr>
<tr style="background-color:rgba(0,0,0,0.5);">
<td style="text-align:center;" colspan=2>
<asp:Button ID="btnAdd" Text="Add User"  runat="server" 
        Style="width:30%;color: DarkOrange;font-size: 12PX; font-weight: bold;height:30px;"
        onclick="btnAdd_Click"></asp:Button>
<asp:Button ID="btnClear" Text="Clear" OnClientClick="return false;"  runat="server" Style="background-color:darkgrey;width:30%;color: white;font-size: 12PX; font-weight: bold;height:30px;"></asp:Button>
</td>
</tr>
</table>

</div>

<div id="divPredictions" style="width:80%;height:400px;background-color:rgba(0,0,0,0.4);margin-left:10%;margin-top:2%;">
<table class="grid" style="width:100%;height:25px;">
<tr class="grad">
<td style="padding:7px !important;text-align: center !important;">
<asp:Label ID="Label5" Text="Upload Match Predictions" Style="color: purple;font-size: 12PX; font-weight: bold;" runat="server"></asp:Label>
<asp:LinkButton ID="lbDownloadUsers" Text="Download participants data" style="color: white; font-weight: bold; text-decoration: underline; float: right;" runat="server" OnClick="lbDownloadUsers_Click"></asp:LinkButton>
</td>
</tr>
</table>
<table class="grid" style="width:50%;height:100px;margin-left:25%;">
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="lblUploadFile" Text="Upload Excel file(.xlsx) : " Style="color: darkslategrey;font-size: 12PX; font-weight: bold;width:40%;" runat="server"></asp:Label>
</td>
<td style="text-align:center;">
<asp:FileUpload id="flUploadUsersData" runat="server" />
</td>
</tr>
<tr style="background-color:rgba(0,0,0,0.5);">
<td style="text-align:center;" colspan="2">
 <asp:Button ID="btnUploadFile" Text="Upload"  runat="server" Style="width:30%;color: DarkOrange;font-size: 12PX; font-weight: bold;height:30px;" 
  OnClick="btnUploadFile_Click"></asp:Button>
</td>
</tr>
</table>
</div>

<div id="divParser" style="width:80%;height:400px;background-color:rgba(0,0,0,0.4);margin-left:10%;margin-top:2%;" class="hide">

<table class="grid" style="width:100%;height:25px;">
<tr class="grad">
<td style="padding:7px !important;text-align: center !important;">
<asp:Label ID="Label7" Text="Convert Raw Whatsapp Predictions" Style="color: purple;font-size: 12PX; font-weight: bold;" runat="server"></asp:Label>
<asp:LinkButton ID="lbTeam" Text="View Team score data" style="color: white; font-weight: bold; text-decoration: underline; float: right;" runat="server" OnClick="lbTeam_Click"></asp:LinkButton>

</td>
</tr>
</table>
<table class="grid" style="width:50%;height:100px;margin-left:25%;">
<tr style="background-color:rgba(255,255,255,0.8);">
<td style="text-align:center;">
<asp:Label ID="Label8" Text="Upload text file(.txt) : " Style="color: darkslategrey;font-size: 12PX; font-weight: bold;width:40%;" runat="server"></asp:Label>
</td>
<td style="text-align:center;">
<asp:FileUpload id="flText" runat="server" />
</td>
</tr>
<tr style="background-color:rgba(0,0,0,0.5);">
<td style="text-align:center;" colspan="2">
 <asp:Button ID="btnConvert" Text="Convert Data"  runat="server" Style="width:30%;color: DarkOrange;font-size: 12PX; font-weight: bold;height:30px;" 
  OnClick="btnUpload_Click"></asp:Button>
</td>
</tr>
</table>
</div>
    <asp:HiddenField ID="hdnTable" runat="server" Value="" />

</asp:Content>