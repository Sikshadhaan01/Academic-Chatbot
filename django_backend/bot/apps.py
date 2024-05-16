import os
from django.apps import AppConfig
from django.conf import settings
# import keras
from tensorflow.python import keras 
from django_backend.settings import BASE_DIR
import pickle

def loadModels():
    with open('models/enc-model.pkl', 'rb') as enc:
        enc_model = pickle.load(enc)
    with open('models/dec-model.pkl', 'rb') as dec:
        dec_model = pickle.load(dec)
    return enc_model, dec_model


class BotConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'bot'
    path = os.path.join(settings.MODELS, "new-model.h5") 
    model = pickle.load(open('models/pickle-model.pkl','rb'))
    enc_model,dec_model = loadModels()
    # json_file = open(path, 'r')
    # with open(path, 'rb') as f:
    #     json_file = f.read()
    #     loaded_model_json = f.read()
    #     f.close()
        # loaded_model = load_model(loaded_model_json)
        # loaded_model.load_weights(path)




