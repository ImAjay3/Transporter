# Transporter

A simple utility suite for sharing files over a local network using WiFi with QR code generation for easy access.

## Overview

Transporter consists of two complementary tools:
- **webserver.cmd**: A batch script that sets up a local file sharing server
- **qr.py**: A Python script that generates QR codes in ASCII format for easy terminal sharing

## Features

- **Easy File Sharing**: Share any folder on your system over HTTP
- **Automatic WiFi Detection**: Automatically detects your WiFi IP address
- **QR Code Generation**: Generate QR codes to easily share URLs
- **Simple Setup**: No complex configuration required

## Requirements

### For webserver.cmd
- Windows OS (batch script)
- HTTP server (Python's built-in `http.server` module or similar)

### For qr.py
- Python 3.x
- `qrcode` library (install via: `pip install qrcode[pil]`)

## Usage

### Step 1: Start the File Sharing Server

Run the batch script:
```batch
webserver.cmd
```

The script will:
1. Prompt you to drag and drop the folder you want to share
2. Ask you to enter a port number (defaults to 8000)
3. Detect your WiFi IP address automatically
4. Display the sharing URL in the format: `http://<WiFi_IP>:<PORT>`

Example output:
```
Sharing: C:\Users\You\Documents\MyFiles
URL: http://192.168.1.100:8000
```

### Step 2: Generate a QR Code (Optional)

Use the QR code script to create a scannable QR code for the URL:

```bash
python qr.py http://192.168.1.100:8000
```

This will generate an ASCII QR code in your terminal that others can scan with their phone cameras.

## How It Works

### webserver.cmd
- Extracts the WiFi adapter name and IP address from system configuration
- Displays connection details for easy network sharing
- Integrates with a local web server to serve files

### qr.py
- Accepts a URL as a command-line argument
- Generates a QR code using the `qrcode` library
- Displays the QR code in ASCII format for terminal viewing

## Example Workflow

1. Run `webserver.cmd` and share a folder containing documents
2. Note the URL provided (e.g., `http://192.168.1.100:8000`)
3. Run `python qr.py http://192.168.1.100:8000` to generate a QR code
4. Display the QR code on your screen or terminal
5. Others on the same WiFi network can scan the QR code to access the shared files

## Installation

### Option 1: Automatic Installation (Recommended for Windows)

1. Ensure Python 3.x is installed and added to your system PATH
2. Double-click `install-dependencies.cmd` in the Transporter folder
3. The script will automatically install all required packages

### Option 2: Manual Installation

1. Clone or download this repository
2. Open a terminal/command prompt in the Transporter directory
3. Run one of the following commands:
   ```bash
   # Using requirements.txt
   pip install -r requirements.txt
   
   # Or manually install the qrcode package
   pip install qrcode[pil]
   ```
4. Ensure Python is added to your system PATH

## Limitations

- **Windows Only**: `webserver.cmd` is designed for Windows systems only
- **Specific WiFi Adapter**: The script looks for a WiFi adapter named "WiFi 2" - may require modification for different system configurations
- **ASCII QR Codes Only**: QR codes are displayed in ASCII text format, which requires adequate terminal width to render properly
- **Local Network Only**: File sharing is limited to devices on the same WiFi network
- **No Authentication**: The basic file server has no built-in security or authentication mechanisms
- **Port Availability**: The specified port must not already be in use by another application
- **Network Visibility**: Depends on proper WiFi network configuration and connectivity
- **URL Scheme Detection**: Some QR code scanners may require the full `http://` protocol in the URL

## Troubleshooting

### "WiFi IP detection failed"
- Ensure you are connected to a WiFi network named "WiFi 2"
- Check that your WiFi adapter is properly configured
- You may need to modify the adapter name in `webserver.cmd` if your system uses a different name

### "Invalid path" error
- Ensure the path to the folder exists
- Try using absolute paths (e.g., `C:\Users\You\Documents\MyFiles`)

### "qrcode module not found"
- Install the qrcode library: `pip install qrcode[pil]`

## Notes

- The QR code is displayed in ASCII format and is best viewed in a terminal with adequate width
- Both tools are lightweight and designed for quick file sharing on local networks
- Ensure you trust the WiFi network before sharing sensitive files