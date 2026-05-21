import sys
import qrcode

if len(sys.argv) < 2:
    print("Usage: python qr.py <url>")
    sys.exit(1)

url = sys.argv[1]

qr = qrcode.QRCode(border=1)
qr.add_data(url)
qr.make(fit=True)

qr.print_ascii(invert=True)