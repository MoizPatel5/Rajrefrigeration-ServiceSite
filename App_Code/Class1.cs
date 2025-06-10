using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data.SqlTypes;

/// <summary>
/// Summary description for Class1
/// </summary>
public class Class1
{
    public Class1()
    {

    }
    public string connectionString()
    {
        //LOCAL DB CONNECTIONSTRINGS
        //string cn = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=D:\Sri_Om_Infotech\ASP.NET\Raj_Refrigeration\App_Data\Database.mdf;Integrated Security=True";

        //LOCAL SSMS DB CONNECTIONSTRINGS
        string cn = @"Data Source=80.65.208.158;Initial Catalog=rajrefrigeration_Testing;Integrated Security=False;User ID=rajrefrigeration_rajref;Password=Mark@283152;Connect Timeout=30;Encrypt=False;Packet Size=4096";

        return cn;
    }
}