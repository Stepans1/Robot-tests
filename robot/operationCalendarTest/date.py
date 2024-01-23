import datetime
import locale
from googletrans import Translator


def get_current_date_in_latvia():
    return datetime.datetime.now().strftime("%B %Y")


def translate_to_english(text):
    translator = Translator()
    translation = translator.translate(text, dest='en')
    single_line_text = translation.text.replace('\n', ' ')
    return single_line_text

def get_current_day():
    return datetime.datetime.now().strftime("%d")
