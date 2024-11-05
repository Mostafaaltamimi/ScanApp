<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scan.aspx.cs" Inherits="webScan.Scan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        // Function to start scanning when the button is clicked
        function startScan() {
            // Check if a scanning API or plugin is available
            if (window.ScannerAPI) {
                window.ScannerAPI.startScanning().then(function(scanResult) {
                    console.log('Scan complete:', scanResult);
                    // You can now send the scan data (e.g., base64 image) to the server
                    sendScanDataToServer(scanResult);
                }).catch(function(error) {
                    console.error('Error during scanning:', error);
                });
            } else {
                alert('Scanner not available or no API found.');
            }
        }

        // Function to send scanned data to the server
        function sendScanDataToServer(scanResult) {
            // Use the fetch API to send scan data to the server
            fetch('/Scan/Upload', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    scanResult: scanResult
                })
            })
            .then(response => response.json())
            .then(data => {
                console.log('Server response:', data);
                alert('Scan successfully uploaded!');
            })
            .catch(error => {
                console.error('Error uploading scan:', error);
                alert('Error uploading scan.');
            });
        }
    </script>
    <h2>Document Scanner</h2>
    <button onclick="startScan()">Start Scan</button>


</asp:Content>
