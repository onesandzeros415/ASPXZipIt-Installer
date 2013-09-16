<%@ Page Language="C#" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Xml" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script runat="server">

    //ASPXZipIt Designed and Mainted By: Matthew Costello, 1/28/2013, San Antonio, Texas.
    //Updated : 9/7/2013

    protected static string path = HttpContext.Current.Server.MapPath("~\\");
    string rootwebConfigPath = HttpContext.Current.Server.MapPath("~\\Web.config");

    string aspxZipItInstaller = "\\ASPXZipIt-Installer.aspx";
    string fileName1 = "\\users.xml";
    string fileName2 = "\\Ionic.Zip.dll";
    string fileName3 = "\\ASPXZipIt-NET35.dll";
    string fileName4 = "\\ASPXZipIt-NET40.dll";
    string fileName5 = "\\ASPXZipIt-NET45.dll";
    string fileName6 = "\\OpenStack.Swift.dll";
    string fileName7 = "\\Rackspace.Cloudfiles.dll";
    string fileName19 = "\\Newtonsoft.Json.dll";
    string fileName20 = "\\openstacknet.dll";
    string fileName21 = "\\SimpleRESTServices.dll";
    string fileName8 = "\\Default.aspx";
    string fileName9 = "\\zipit-db.aspx";
    string fileName10 = "\\zipit-logs.aspx";
    string fileName11 = "\\zipit-login.aspx";
    string fileName12 = "\\zipit-settings.aspx";
    string fileName13 = "\\zipit-success.aspx";
    string fileName14 = "\\Web.config";
    string fileName15 = "\\DBResultPage.aspx";
    string fileName16 = "\\ResultPage.aspx";
    string fileName17 = "\\progress.gif";
    string fileName18 = "\\StyleSheet.css";

    string installerPath_AppData = path + "App_Data";
    string installerPath_bin = path + "bin";
    string installerPath_aspxzipit = path + "aspxzipit";
    string installerPath_progress = path + "aspxzipit" + "\\Progress";
    string installerPath_images = path + "aspxzipit" + "\\Images";
    string installerPath_styles = path + "aspxzipit" + "\\styles";
    string installerPath_sqlbak = path + "aspxzipit_sql_bak";

    protected void Page_Load(object sender, EventArgs e)
    {
        checkForFomsAuthentication();
        checkForASPMembership();
        rebuildApplication();
    }
    protected void installAspxZipIt_Click(object sender, EventArgs e)
    {
        string gitHubDotNetVersion35 = "ASPXZipIt-NET35";
        string gitHubDotNetVersion40 = "ASPXZipIt-NET40";
        string gitHubDotNetVersion45 = "ASPXZipIt-NET45";

        //Create list of directory names to create
        List<string> createDirArray = new List<string>();
        createDirArray.Add(installerPath_AppData);
        createDirArray.Add(installerPath_bin);
        createDirArray.Add(installerPath_aspxzipit);
        createDirArray.Add(installerPath_sqlbak);
        createDirArray.Add(installerPath_progress);
        createDirArray.Add(installerPath_images);
        createDirArray.Add(installerPath_styles);

        //Loop though createDirArray to create directories
        foreach (string directory in createDirArray)
        {
            Directory.CreateDirectory(directory);
        }

        //Detect framework version and than download ASPX Zipit
        if (dotNetVersionListBox.SelectedValue == "35")
        {
            try
            {
                downloadAspxZipIt(gitHubDotNetVersion35);

                Response.Redirect("/aspxzipit/Default.aspx", true);
            }
            catch (Exception ex)
            {
                lblInfo.Text = "The process failed:" + ex.ToString();
            }
        }
        else if (dotNetVersionListBox.SelectedValue == "40")
        {
            try
            {
                downloadAspxZipIt(gitHubDotNetVersion40);

                Response.Redirect("/aspxzipit/Default.aspx", true);
            }
            catch (Exception ex)
            {
                lblInfo.Text = "The process failed:" + ex.ToString();
            }
        }
        else if (dotNetVersionListBox.SelectedValue == "45")
        {
            try
            {
                downloadAspxZipIt(gitHubDotNetVersion45);

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
    protected void downloadAspxZipIt(string dotNetVersion)
    {
        string LogResults1 = "  AspxZipIt install has begun.                                                     \r\n";
        string LogResults2 = "  AspxZipIt has been successfully installed to:" + installerPath_aspxzipit + "           \r\n";
        string LogResults3 = "  CloudFiles API Information Written to" + installerPath_aspxzipit + fileName14 + "\r\n";
        string LogResults4 = "  ASPXZipIt crendentials have been set.                                            \r\n";

        //Setup source github urls
        List<string> src = new List<string>();
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/App_Data/users.xml");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/Default.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/zipit-db.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/zipit-logs.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/zipit-login.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/zipit-settings.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/zipit-success.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/Web.config");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/Progress/DBResultPage.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/Progress/ResultPage.aspx");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/images/progress.gif");
        src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/aspxzipit/styles/StyleSheet.css");

        //Setup destination install list
        List<string> dst = new List<string>();
        dst.Add(@installerPath_AppData + fileName1);
        dst.Add(@installerPath_aspxzipit + fileName8);
        dst.Add(@installerPath_aspxzipit + fileName9);
        dst.Add(@installerPath_aspxzipit + fileName10);
        dst.Add(@installerPath_aspxzipit + fileName11);
        dst.Add(@installerPath_aspxzipit + fileName12);
        dst.Add(@installerPath_aspxzipit + fileName13);
        dst.Add(@installerPath_aspxzipit + fileName14);
        dst.Add(@installerPath_progress + fileName15);
        dst.Add(@installerPath_progress + fileName16);
        dst.Add(@installerPath_images + fileName17);
        dst.Add(@installerPath_styles + fileName18);

        //Setup .NET 35 exludes list
        List<string> excludes35 = new List<string>();
        excludes35.Add(@installerPath_bin + fileName2);
        excludes35.Add(@installerPath_bin + fileName6);
        excludes35.Add(@installerPath_bin + fileName7);

        //Setup .NET 40 exludes list
        List<string> excludes40 = new List<string>();
        excludes40.Add(@installerPath_bin + fileName2);
        excludes40.Add(@installerPath_bin + fileName19);
        excludes40.Add(@installerPath_bin + fileName20);
        excludes40.Add(@installerPath_bin + fileName21);

        //Setup .NET 45 exludes list
        List<string> excludes45 = new List<string>();
        excludes45.Add(@installerPath_bin + fileName19);
        excludes45.Add(@installerPath_bin + fileName20);
        excludes45.Add(@installerPath_bin + fileName21);


        try
        {
            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResults1);

            if (dotNetVersion == "ASPXZipIt-NET35")
            {
                //Add .NET 3.5 specific dll's to source list
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/Ionic.Zip.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/ASPXZipIt-NET35.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/OpenStack.Swift.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/Rackspace.Cloudfiles.dll");

                //Add .NET 3.5 specific dll's to destination list
                dst.Add(@installerPath_bin + fileName2);
                dst.Add(@installerPath_bin + fileName3);
                dst.Add(@installerPath_bin + fileName6);
                dst.Add(@installerPath_bin + fileName7);

                foreach (string exclude in excludes35)
                {
                    if (File.Exists(exclude))
                    {
                        //Remove .NET 3.5 specific dll from destination list
                        dst.Remove(@exclude);

                        //Remove .NET 3.5 specific dll from source github list
                        string getFileName = Path.GetFileName(exclude);
                        string srcGitHubList = "https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/" + getFileName;
                        src.Remove(srcGitHubList);

                        EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  " + exclude + " already exist and will not be installed. \r\n");
                    }
                    else
                    {
                        EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  " + exclude + " does not exist and will be installed. \r\n");
                    }
                    continue;
                }
            }
            else if (dotNetVersion == "ASPXZipIt-NET40")
            {
                //Add .NET 4.0 specific dll's to source list
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/Ionic.Zip.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/ASPXZipIt-NET40.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/Newtonsoft.Json.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/openstacknet.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/SimpleRESTServices.dll");

                //Add .NET 4.0 specific dll's to destination list
                dst.Add(@installerPath_bin + fileName2);
                dst.Add(@installerPath_bin + fileName4);
                dst.Add(@installerPath_bin + fileName19);
                dst.Add(@installerPath_bin + fileName20);
                dst.Add(@installerPath_bin + fileName21);

                foreach (string exclude in excludes40)
                {
                    if (File.Exists(exclude))
                    {
                        //Remove .NET 4.0 specific dll from destination list
                        dst.Remove(@exclude);

                        //Remove .NET 4.0 specific dll from source github list
                        string getFileName = Path.GetFileName(exclude);
                        string srcGitHubList = "https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/" + getFileName;
                        src.Remove(srcGitHubList);

                        EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  " + exclude + " already exist and will not be installed. \r\n");
                    }
                    else
                    {
                        EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  " + exclude + "  does not exist and will be installed. \r\n");
                    }
                }
            }
            else if (dotNetVersion == "ASPXZipIt-NET45")
            {
                //Add .NET 4.5 specific dll's to source list
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/ASPXZipIt-NET45.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/Newtonsoft.Json.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/openstacknet.dll");
                src.Add("https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/SimpleRESTServices.dll");

                //Add .NET 4.5 specific dll's to destination list
                dst.Add(@installerPath_bin + fileName5);
                dst.Add(@installerPath_bin + fileName19);
                dst.Add(@installerPath_bin + fileName20);
                dst.Add(@installerPath_bin + fileName21);

                foreach (string exclude in excludes45)
                {
                    if (File.Exists(exclude))
                    {
                        //Remove .NET 4.5 specific dll from destination list
                        dst.Remove(@exclude);

                        //Remove .NET 4.5 specific dll from source github list
                        string getFileName = Path.GetFileName(exclude);
                        string srcGitHubList = "https://github.com/onesandzeros415/" + dotNetVersion + "/raw/master/bin/" + getFileName;
                        src.Remove(srcGitHubList);

                        EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  " + exclude + " already exist and will not be installed. \r\n");
                    }
                    else
                    {
                        EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  " + exclude + "  does not exist and will be installed. \r\n");
                    }
                }
            }

            // Setting up source and destination and creating a list of the file source and destination.
            List<KeyValuePair<string, string>> _srcdstList = new List<KeyValuePair<string, string>>();

            for (int i = 0; i < src.Count; i++)
            {
                string urlPath = src[i];
                string dstPath = dst[i];

                _srcdstList.Add(new KeyValuePair<string, string>(urlPath, dstPath));
            }

            StringBuilder downloadLoopSb = new StringBuilder();

            // Just iterated through the list to issue 10 concurrent async file downloads
            foreach (KeyValuePair<string, string> fi in _srcdstList)
            {
                downloadLoopSb.Append(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  Downloading : " + fi.Key + "  |  Installing to :" + fi.Value + "\r\n");

                WebClient client = new WebClient();
                client.DownloadFile(fi.Key, fi.Value);
                client.Dispose();
            }

            EventLogReporting(downloadLoopSb);

            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResults2);

            rebuildApplication();

            //Add user CloudFiles API to ASPXZipIt Web.config
            UpdateAppSetting("CloudFilesUserName", TxtCloudFilesUserName.Text);
            UpdateAppSetting("CloudFilesApiKey", TxtCloudFilesApiKey.Text);
            UpdateAppSetting("snet", ddlServiceNet.SelectedValue.ToString());

            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResults3);

            //Add user credential to ASPXZipIt Web.config
            updateAspMembershipPasswd();

            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResults4);

            //Remove temp directory from local disk
            FileInfo fi1 = new FileInfo(path + aspxZipItInstaller);
            fi1.Delete();
        }
        catch (Exception ex)
        {
            string LogResultsError = ex.ToString();
            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResultsError);
        }
    }
    protected void UpdateAppSetting(string name, string value)
    {
        try
        {
            string webConfigPath = HttpContext.Current.Server.MapPath("~/aspxzipit/web.config");
            string xpathToSetting = string.Format("//add[@key='{0}']", name);

            XmlDocument xDoc = new XmlDocument();
            //Load web.config
            xDoc.Load(HttpContext.Current.Server.MapPath("~/aspxzipit/web.config"));
            //Find appSettings node
            XmlNodeList settingNodes = xDoc.GetElementsByTagName("appSettings");
            //Select appSettings node
            XmlNode appSettingNode = settingNodes[0].SelectSingleNode(xpathToSetting);

            if (appSettingNode != null && appSettingNode.Attributes != null)
            {
                XmlAttribute idAttribute = appSettingNode.Attributes["value"];
                if (idAttribute != null)
                {
                    idAttribute.Value = value;
                    xDoc.Save(webConfigPath);
                }
            }
        }
        catch (Exception ex)
        {
            string LogResultsError = ex.ToString();
            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResultsError);
        }
    }
    protected void updateAspMembershipPasswd()
    {
        string Log1 = DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  ASPXZipIt Username has been successfully changed to: " + txtAspxZipItUsername.Text + "               \r\n";
        string Log2 = DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  ASPXZipIt Password has been successfully changed.                              \r\n";

        try
        {
            string webConfigPath = Server.MapPath("~/App_Data/users.xml");

            XmlDocument xDoc = new XmlDocument();
            xDoc.Load((webConfigPath));
            XmlNode XmlUserName = xDoc.SelectSingleNode("Users/User/UserName");

            if (XmlUserName != null)
            {
                XmlUserName.InnerText = txtAspxZipItUsername.Text;
                xDoc.Save(webConfigPath);
                EventLogReporting(Log1);
            }

            XmlDocument xDoc2 = new XmlDocument();
            xDoc2.Load((webConfigPath));
            XmlNode XmlPasswd = xDoc.SelectSingleNode("Users/User/Password");

            if (XmlUserName != null)
            {
                XmlPasswd.InnerText = txtAspxZipItPassword.Text;
                xDoc.Save(webConfigPath);
                EventLogReporting(Log2);
            }

            Response.Redirect(Request.RawUrl, false);
        }
        catch (Exception ex)
        {
            string LogResultsError = ex.ToString();
            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResultsError);
        }
    }
    protected void checkForASPMembership()
    {
        XmlDocument FindASPMembership = new XmlDocument();
        FindASPMembership.Load(rootwebConfigPath);
        XmlNode xnodes = FindASPMembership.SelectSingleNode("/configuration/system.web/membership");

        try
        {
            if (xnodes == null)
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(rootwebConfigPath);

                XmlNode parentNode = doc.SelectSingleNode("/configuration/system.web");

                XmlNode MembershipNode = doc.CreateElement("membership");
                XmlAttribute MembershipAttribute = doc.CreateAttribute("defaultProvider");
                MembershipAttribute.Value = "AspNetReadOnlyXmlMembershipProvider";
                MembershipNode.Attributes.Append(MembershipAttribute);

                XmlNode ProviderNode = doc.CreateElement("providers");
                MembershipNode.AppendChild(ProviderNode);

                XmlNode MembershipAddNode = doc.CreateElement("add");
                XmlAttribute MembershipAddAttribute1 = doc.CreateAttribute("name");
                MembershipAddAttribute1.Value = "AspNetReadOnlyXmlMembershipProvider";
                MembershipAddNode.Attributes.Append(MembershipAddAttribute1);

                XmlAttribute MembershipAddAttribute2 = doc.CreateAttribute("type");
                MembershipAddAttribute2.Value = "ReadOnlyXmlMembershipProvider";
                MembershipAddNode.Attributes.Append(MembershipAddAttribute2);

                XmlAttribute MembershipAddAttribute3 = doc.CreateAttribute("description");
                MembershipAddAttribute3.Value = "Read-only XML membership provider";
                MembershipAddNode.Attributes.Append(MembershipAddAttribute3);

                XmlAttribute MembershipAddAttribute4 = doc.CreateAttribute("xmlFileName");
                MembershipAddAttribute4.Value = "~/App_Data/users.xml";
                MembershipAddNode.Attributes.Append(MembershipAddAttribute4);

                ProviderNode.AppendChild(MembershipAddNode);

                parentNode.InsertBefore(MembershipNode, parentNode.FirstChild);

                doc.Save(rootwebConfigPath);

                EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  Successfully added ASP Membership.                                                     \r\n");
            }
            else
            {
                EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  Succesfully detected ASP Membership.                                                     \r\n");
            }
        }
        catch (Exception ex)
        {
            string LogResultsError = ex.ToString();
            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResultsError + "\r\n");
        }
    }
    protected void checkForFomsAuthentication()
    {
        XmlDocument FindASPMembership = new XmlDocument();
        FindASPMembership.Load(rootwebConfigPath);
        XmlNode xnodes = FindASPMembership.SelectSingleNode("/configuration/system.web/authentication");

        try
        {
            if (xnodes == null)
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(rootwebConfigPath);

                XmlNode parentNode = doc.SelectSingleNode("/configuration/system.web");

                XmlNode MembershipNode = doc.CreateElement("authentication");
                XmlAttribute MembershipAttribute = doc.CreateAttribute("mode");
                MembershipAttribute.Value = "Forms";
                MembershipNode.Attributes.Append(MembershipAttribute);

                XmlNode MembershipAddNode = doc.CreateElement("forms");
                XmlAttribute MembershipAddAttribute1 = doc.CreateAttribute("loginUrl");
                MembershipAddAttribute1.Value = "~/aspxzipit/zipit-login.aspx";
                MembershipAddNode.Attributes.Append(MembershipAddAttribute1);

                MembershipNode.AppendChild(MembershipAddNode);

                parentNode.InsertBefore(MembershipNode, parentNode.FirstChild);

                doc.Save(rootwebConfigPath);

                EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  Successfully added Forms Authentication Mode.                                                     \r\n");
            }
            else
            {
                EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  Succesfully detected Form Authentication.                                                     \r\n");
            }
        }
        catch (Exception ex)
        {
            string LogResultsError = ex.ToString();
            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResultsError + "\r\n");
        }
    }
    protected void rebuildApplication()
    {
        try
        {
            string path = Server.MapPath("~/");
            string filename = "web.config";
            string renamed_filename = "web.config.aspxzipit_renamed";
            string backup_filename = "web.config.aspxzipit_bak";
            string LogResults1 = DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + "  Application has been rebuilt successfully.                            \r\n";

            if (File.Exists(path + backup_filename))
            {
                FileInfo fi = new FileInfo(path + backup_filename);

                fi.Delete();

                File.Copy(path + filename, path + backup_filename);
                File.Move(path + filename, path + renamed_filename);
                File.Move(path + renamed_filename, path + filename);
                File.Delete(path + backup_filename);
                EventLogReporting(LogResults1);
            }
            else
            {
                File.Copy(path + filename, path + backup_filename);
                File.Move(path + filename, path + renamed_filename);
                File.Move(path + renamed_filename, path + filename);
                File.Delete(path + backup_filename);
                EventLogReporting(LogResults1);
            }
        }
        catch (Exception ex)
        {
            string LogResultsError = ex.ToString();
            EventLogReporting(DateTime.Now.ToString("MM-dd-yyyy_HH-mm-ss") + LogResultsError);
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
            <asp:DropDownList ID="dotNetVersionListBox" runat="server">
                <asp:ListItem Enabled="true" Selected="True" Text="Please Select a .NET Version" Value="0" />
                <asp:ListItem Enabled="true" Text=".NET 3.5" Value="35" />
                <asp:ListItem Enabled="true" Text=".NET 4.0" Value="40" />
                <asp:ListItem Enabled="true" Text=".NET 4.5" Value="45" />
            </asp:DropDownList>
            <br />
            <br />
            <center>
                <table>
                    <tr>
                        <td style="text-align: center;" colspan="2">
                            <h1>CloudFiles API Information</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50%; text-align: right; padding-right: 10px;">CloudFiles Username:
                        </td>
                        <td style="width: 50%; text-align: left;">
                            <asp:TextBox ID="TxtCloudFilesUserName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50%; text-align: right; padding-right: 10px;">CloudFiles API Key:
                        </td>
                        <td style="width: 50%; text-align: left;">
                            <asp:TextBox ID="TxtCloudFilesApiKey" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50%; text-align: right; padding-right: 10px;">ServiceNet:
                        </td>
                        <td style="width: 50%; text-align: left;">
                            <asp:DropDownList ID="ddlServiceNet" runat="server">
                                <asp:ListItem Text="Enable" Value="true"></asp:ListItem>
                                <asp:ListItem Text="Disable" Value="false"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center;" colspan="2">
                            <h1>ASPXZipIt Crendentials</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50%; text-align: right; padding-right: 10px;">ASPXZipIt Username:
                        </td>
                        <td style="width: 50%; text-align: left;">
                            <asp:TextBox ID="txtAspxZipItUsername" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50%; text-align: right; padding-right: 10px;">ASPXZipIt Password:
                        </td>
                        <td style="width: 50%; text-align: left;">
                            <asp:TextBox ID="txtAspxZipItPassword" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </center>
            <br />
            <br />
            <asp:Button runat="server" ID="btnDownload" OnClick="installAspxZipIt_Click" Text="Install AspxZipIt" />
            <br />
            <br />
            <asp:Label runat="server" ID="lblInfo" ForeColor="Red" Text="" />
        </div>
    </form>
</body>
</html>
