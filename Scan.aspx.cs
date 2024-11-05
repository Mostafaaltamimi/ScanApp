using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webScan
{
    public partial class Scan : System.Web.UI.Page
    {

        // Page Load event, can be used to initialize components if necessary
        protected void Page_Load(object sender, EventArgs e)
        {
            // You can add page load logic here
        }

        // WebMethod for handling scan data upload
        [System.Web.Services.WebMethod]
        public static string UploadScanData(string scanResult)
        {
            try
            {
                // Assuming the scanResult is a base64 encoded image string
                byte[] imageBytes = Convert.FromBase64String(scanResult);

                // Generate a file path to save the image on the server
                string filePath = HttpContext.Current.Server.MapPath("~/Scans/scan_" + DateTime.Now.Ticks + ".png");

                // Ensure the directory exists
                string directoryPath = Path.GetDirectoryName(filePath);
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }

                // Save the image to the file system
                File.WriteAllBytes(filePath, imageBytes);

                return "Scan uploaded successfully to " + filePath;
            }
            catch (Exception ex)
            {
                // Handle any exceptions during the upload
                return "Error uploading scan: " + ex.Message;
            }
        }
    }

}