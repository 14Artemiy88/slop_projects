from PIL import Image
import zbarlight

file_path = "/run/user/1000/qr.png"
with open(file_path, 'rb') as image_file:
    image = Image.open(image_file)
    image.load()

codes = zbarlight.scan_codes(['qrcode'], image)
if codes != "None":
    print(codes[0].decode("utf-8"))
