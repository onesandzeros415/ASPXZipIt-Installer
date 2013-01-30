<%@ Page Language="C#" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Threading" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script runat="server">

    //ASPXZipIt Designed and Mainted By: Matthew Costello, 1/28/2013, San Antonio, Texas.
    
    string timestamp = DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss");

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void webconfigvalue_Click(object sender, EventArgs e)
    {
        try
        {
            Configuration config = WebConfigurationManager.OpenWebConfiguration("~");

            config.AppSettings.Settings["SiteName"].Value = "APIKEYGOESHERE";
            config.Save(ConfigurationSaveMode.Modified);
            ConfigurationManager.RefreshSection("appSettings");
        }
        catch (Exception ex)
        {
            lblInfo.Text = "The process failed:" + ex.ToString();
        }
    }
    protected void webconfigvaluedelete_Click(object sender, EventArgs e)
    {
        try
        {
            Configuration config = WebConfigurationManager.OpenWebConfiguration("~");

            WebConfigurationManager.AppSettings.Remove("SiteName");
            config.Save(ConfigurationSaveMode.Modified);
            ConfigurationManager.RefreshSection("appSettings");
        }
        catch (Exception ex)
        {
            lblInfo.Text = "The process failed:" + ex.ToString();
        }
    }
    protected void installaspxzipit_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath("~/");
        string filename1 = "/Ionic.Zip.dll";
        string filename2 = "/ASPXZipIt-NET35.dll";
        string filename3 = "/ASPXZipIt-NET40.dll";
        string filename4 = "/OpenStack.Swift.dll";
        string filename5 = "/Rackspace.Cloudfiles.dll";
        string filename6 = "/Default.aspx";
        string filename7 = "/zipit-db.aspx";
        string filename8 = "/zipit-logs.aspx";
        string filename9 = "/Web.config";
        string filename10 = "/DBResultPage.aspx";
        string filename11 = "/ResultPage.aspx";
        string filename12 = "/Updating.gif";
        string filename13 = "/StyleSheet.css";

        string installerpath_bin = path + "/bin";
        string installerpath_aspxzipit = path + "/aspxzipit";
        string installerpath_progress = path + "/aspxzipit" + "/Progress";
        string installerpath_images = path + "/aspxzipit" + "/Images";
        string installerpath_styles = path + "/aspxzipit" + "/styles";
        string LogResults1 = timestamp + "AspxZipIt install has begun.                                                     \r\n";
        string LogResults2 = timestamp + "AspxZipIt has been successfully installed to:" + installerpath_bin + "           \r\n";
        string LogResults3 = timestamp + "Application has been successfully rebuilt.                                       \r\n";

        Directory.CreateDirectory(installerpath_bin);
        Directory.CreateDirectory(installerpath_aspxzipit);
        Directory.CreateDirectory(installerpath_progress);
        Directory.CreateDirectory(installerpath_images);
        Directory.CreateDirectory(installerpath_styles);

        if (DotNetVersionListBox.SelectedValue == "35")
        {
            try
            {
                EventLogReporting(LogResults1);

                WebClient webClient = new WebClient();
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/bin/Ionic.Zip.dll", @installerpath_bin + filename1);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/bin/ASPXZipIt-NET35.dll", @installerpath_bin + filename2);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/bin/OpenStack.Swift.dll", @installerpath_bin + filename4);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/bin/Rackspace.Cloudfiles.dll", @installerpath_bin + filename5);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/Default.aspx", @installerpath_aspxzipit + filename6);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/zipit-db.aspx", @installerpath_aspxzipit + filename7);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/zipit-logs.aspx", @installerpath_aspxzipit + filename8);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/Web.config", @installerpath_aspxzipit + filename9);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/Progress/DBResultPage.aspx", @installerpath_progress + filename10);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/Progress/ResultPage.aspx", @installerpath_progress + filename11);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/images/Updating.gif", @installerpath_images + filename12);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET35/raw/master/aspxzipit/styles/StyleSheet.css", @installerpath_styles + filename13);

                EventLogReporting(LogResults2);

                rebuildapplication();

                EventLogReporting(LogResults3);

                lblInfo.Text = "Installed ASPXZipIt for .NET Version 3.5";

                Response.Redirect("/aspxzipit/Default.aspx", true);
            }
            catch (Exception ex)
            {
                lblInfo.Text = "The process failed:" + ex.ToString();
            }
        }
        else if (DotNetVersionListBox.SelectedValue == "40")
        {
            try
            {
                EventLogReporting(LogResults1);

                WebClient webClient = new WebClient();
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/bin/Ionic.Zip.dll", @installerpath_bin + filename1);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/bin/ASPXZipIt-NET40.dll", @installerpath_bin + filename3);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/bin/OpenStack.Swift.dll", @installerpath_bin + filename4);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/bin/Rackspace.Cloudfiles.dll", @installerpath_bin + filename5);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/Default.aspx", @installerpath_aspxzipit + filename6);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/zipit-db.aspx", @installerpath_aspxzipit + filename7);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/zipit-logs.aspx", @installerpath_aspxzipit + filename8);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/Web.config", @installerpath_aspxzipit + filename9);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/Progress/DBResultPage.aspx", @installerpath_progress + filename10);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/Progress/ResultPage.aspx", @installerpath_progress + filename11);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/images/Updating.gif", @installerpath_images + filename12);
                webClient.DownloadFile("https://github.com/onesandzeros415/ASPXZipIt-NET40/raw/master/aspxzipit/styles/StyleSheet.css", @installerpath_styles + filename13);

                EventLogReporting(LogResults2);

                rebuildapplication();

                EventLogReporting(LogResults3);

                lblInfo.Text = "Installed ASPXZipIt for .NET Version 4.0";

                Response.Redirect("/aspxzipit/Default.aspx", true);
            }
            catch (Exception ex)
            {
                lblInfo.Text = "The process failed:" + ex.ToString();
            }
        }
        else
        {
            lblInfo.Text = "Please select a .net version from the dropdown.";
        }
    }
    protected void uninstallaspxzipit_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/");
            string filename1 = "/Ionic.Zip.dll";
            string filename2 = "/ASPXZipIt-NET35.dll";
            string filename3 = "/ASPXZipIt-NET40.dll";
            string filename4 = "/OpenStack.Swift.dll";
            string filename5 = "/Rackspace.Cloudfiles.dll";

            string installerpath_bin = path + "/bin";
            string installerpath_aspxzipit = path + "/aspxzipit";
            string installerpath_progress = path + "/aspxzipit" + "/Progress";
            string installerpath_images = path + "/aspxzipit" + "/Images";
            string installerpath_styles = path + "/aspxzipit" + "/styles";

            DirectoryInfo dirInfo1 = new DirectoryInfo(installerpath_bin);
            DirectoryInfo dirInfo2 = new DirectoryInfo(installerpath_aspxzipit);
            DirectoryInfo dirInfo3 = new DirectoryInfo(installerpath_progress);
            DirectoryInfo dirInfo4 = new DirectoryInfo(installerpath_images);
            DirectoryInfo dirInfo5 = new DirectoryInfo(installerpath_styles);
            
            foreach (FileInfo f in dirInfo1.GetFiles())
            {
                f.Delete();
            }
            foreach (FileInfo f in dirInfo2.GetFiles())
            {
                f.Delete();
            }
            foreach (FileInfo f in dirInfo3.GetFiles())
            {
                f.Delete();
            }
            foreach (FileInfo f in dirInfo4.GetFiles())
            {
                f.Delete();
            }
            foreach (FileInfo f in dirInfo5.GetFiles())
            {
                f.Delete();
            }
            
            FileInfo fi1 = new FileInfo(installerpath_bin + filename1);
            FileInfo fi2 = new FileInfo(installerpath_bin + filename2);
            FileInfo fi3 = new FileInfo(installerpath_bin + filename3);
            FileInfo fi4 = new FileInfo(installerpath_bin + filename4);
            FileInfo fi5 = new FileInfo(installerpath_bin + filename5);

            fi1.Delete();
            fi2.Delete();
            fi3.Delete();
            fi4.Delete();
            fi5.Delete();
            
            Directory.Delete(installerpath_progress);
            Directory.Delete(installerpath_images);
            Directory.Delete(installerpath_styles);
            Directory.Delete(installerpath_aspxzipit);

            lblInfo.Text = "AspxZipIt has been successfully removed.";
        }
        catch (Exception ex)
        {
            lblInfo.Text = "The process failed:" + ex.ToString();
        }
    }
    protected void manual_rebuildapplication_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/");
            string filename = "web.config";
            string renamed_filename = "web.config.aspxzipit_renamed";
            string backup_filename = "web.config.aspxzipit_bak";

            if (File.Exists(path + backup_filename))
            {
                FileInfo fi = new FileInfo(path + backup_filename);

                fi.Delete();

                File.Copy(path + filename, path + backup_filename);
                File.Move(path + filename, path + renamed_filename);
                File.Move(path + renamed_filename, path + filename);
            }
            else
            {
                File.Copy(path + filename, path + backup_filename);
                File.Move(path + filename, path + renamed_filename);
                File.Move(path + renamed_filename, path + filename);
            }
        }
        catch (Exception ex)
        {
            lblInfo.Text = ex.ToString();
        }

        lblInfo.Text = "Application has been successfully rebuilt.";
    }
    protected void rebuildapplication()
    {
        try
        {
            string path = Server.MapPath("~/");
            string filename = "web.config";
            string renamed_filename = "web.config.aspxzipit_renamed";
            string backup_filename = "web.config.aspxzipit_bak";

            if (File.Exists(path + backup_filename))
            {
                FileInfo fi = new FileInfo(path + backup_filename);

                fi.Delete();

                File.Copy(path + filename, path + backup_filename);
                File.Move(path + filename, path + renamed_filename);
                File.Move(path + renamed_filename, path + filename);
            }
            else
            {
                File.Copy(path + filename, path + backup_filename);
                File.Move(path + filename, path + renamed_filename);
                File.Move(path + renamed_filename, path + filename);
            }
        }
        catch (Exception ex)
        {
            EventLogReporting(ex.ToString());
        }
    }
    protected void EventLogReporting(object LogResults)
    {
        string path = Server.MapPath("~/");
        string LogResultsString = LogResults.ToString();

        if (Directory.Exists(path))
        {
            if (!File.Exists(path + "\\aspxzipit_eventlog.txt"))
            {
                File.AppendAllText(path + "\\aspxzipit_eventlog.txt", String.Format(LogResultsString, Environment.NewLine));
            }
            else if (File.Exists(path + "\\aspxzipit_eventlog.txt"))
            {
                File.AppendAllText(path + "\\aspxzipit_eventlog.txt", String.Format(LogResultsString, Environment.NewLine));
            }
        }
    }
</script>

<head runat="server">
    <link href="styles/StyleSheet.css" rel="stylesheet" type="text/css" />

    <style id="importcss" runat="server" type="text/css">
        body {
            height: 100%;
            background: #ddd;
            margin-bottom: 1px;
        }

        .clear {
            clear: both;
        }

        input {
            border: 1px solid #818185;
            -moz-border-radius: 15px;
            border-radius: 15px;
            height: 30px;
            width: 200px;
            padding-left: 8px;
            padding-right: 8px;
        }

        .button {
            border: 1px solid #818185;
            background-color: #ccc;
            -moz-border-radius: 15px;
            border-radius: 15px;
            text-align: center;
            width: 100px;
            color: #000;
            padding: 3px;
        }

        .wrapper {
            width: 700px;
            position: absolute;
            left: 50%;
            top: 50%;
            margin: -225px 0 0 -345px;
            background-color: #eee;
            -moz-border-radius: 15px;
            border-radius: 15px;
            text-align: center;
            padding: 20px;
            -moz-box-shadow: 5px 5px 7px #888;
            -webkit-box-shadow: 5px 5px 7px #888;
        }

        a {
            color: #55688A;
        }



        * {
            margin: 0;
            padding: 0;
        }

        .group {
            zoom: 1;
            position: absolute;
            top: -47px;
            left: 24px;
        }

        .head {
            text-align: center;
            font-family: Fontin, sans-serif;
            font-size: 28px;
            margin-bottom: 10px;
        }


        .tabs {
            list-style: none;
            width: 700px;
            position: absolute;
            left: 50%;
            top: 50%;
            margin: -262px 0 0 -325px;
        }

            .tabs li {
                /* Makes a horizontal row */
                float: left; /* So the psueudo elements can be 			   abs. positioned inside */
                position: relative;
            }

            .tabs a {
                /* Make them block level 		     and only as wide as they need */
                float: left;
                padding: 10px 40px;
                text-decoration: none; /* Default colors */
                color: black;
                background: #CCCCCC; /* Only round the top corners */
                -webkit-border-top-left-radius: 15px;
                -webkit-border-top-right-radius: 15px;
                -moz-border-radius-topleft: 15px;
                -moz-border-radius-topright: 15px;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }

            .tabs .active {
                /* Highest, active tab is on top */
                z-index: 3;
            }

                .tabs .active a {
                    /* Colors when tab is active */
                    background: #eee;
                    color: black;
                }
    </style>
    <title>ASPXZipIt - Installer - .NET 3.5, 4.0</title>
</head>
<body>
    <form id="form1" runat="server">
        <center>
            <ul class="tabs group">
                <li class="active"><a href="zipit-logs.aspx" onfocus="this.blur();">Logs</a></li>
            </ul>
        </center>
        <div class="wrapper">
            Please be sure that your web.config has impersonation enabled before running this installer.  For more information please
            see the official Rackspace Cloud Knowledge Center Article on how to enable: <a href="http://www.rackspace.com/knowledge_center/article/how-do-i-add-impersonation-to-my-aspnet-cloud-site" target="_blank">Click Here</a>.
            <br />
            <br />
            <asp:DropDownList ID="DotNetVersionListBox" runat="server">
                <asp:ListItem Enabled="true" Selected="True" Text="Please Select a .NET Version" Value="0" />
                <asp:ListItem Enabled="true" Text=".NET 3.5" Value="35" />
                <asp:ListItem Enabled="true" Text=".NET 4.0" Value="40" />
            </asp:DropDownList>
            <br />
            <br />
            <asp:Button runat="server" ID="btndownload" OnClick="installaspxzipit_Click" Text="Install AspxZipIt" />
            <br />
            <br />
            <asp:Button runat="server" ID="btndownloaddelete" OnClick="uninstallaspxzipit_Click" Text="UnInstall AspxZipIt" />
            <br />
            <br />
            <br />
            <asp:Button runat="server" ID="btnrebuildapplication" ForeColor="Red" OnClick="manual_rebuildapplication_Click" Text="Rebuild Application" />
            <br />
            <br />
            <asp:Label runat="server" ID="lblInfo" ForeColor="Red" Text="" />
        </div>
    </form>
</body>
</html>
