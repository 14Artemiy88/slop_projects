from googletrans import Translator
import sys

translator = Translator()
res = translator.translate(sys.argv[1], dest='ru').text

print(res)
