from django import views
from django.conf import settings
from django.http import HttpResponse
from django.shortcuts import render
# import tensorflow as tf
# from tensorflow.python import keras
# import keras
import requests
from rest_framework.response import Response
from rest_framework.decorators import api_view
import tensorflow as tf
import numpy as np
# from tensorflow.python import keras
from django_backend.settings import BASE_DIR
# from keras.src.models.cloning import clone_model
# from keras._tf_keras.keras.models import load_model
import pickle
# from tensorflow.keras.layers import Input, Embedding, LSTM
from keras._tf_keras.keras.layers import Input, Embedding, LSTM, Dense
from keras._tf_keras.keras.activations import softmax
from keras._tf_keras.keras.models import Model
from keras._tf_keras.keras.preprocessing import text
from keras._tf_keras.keras.preprocessing.sequence import pad_sequences
# from tensorflow import keras
# from tensorflow.keras.preprocessing import text
# from tensorflow.keras.preprocessing.sequence import pad_sequences

# from keras.src.legacy.preprocessing import text
# from keras._tf_keras.keras.preprocessing import text
# from keras._tf_keras.keras.preprocessing.sequence import pad_sequences

from django_backend.settings import BASE_DIR
from .apps import BotConfig
from rest_framework import generics
from .serializers import BotRequestSerializer
from rest_framework.views import APIView
from rest_framework import status
from rest_framework import permissions
from rest_framework.decorators import api_view, permission_classes

# Create your views here.
# model = tf.keras.models.load_model("django_backend/models/model.h5")

def home(req):
    # print(dir(settings))
    # states_values = enc_model.predict(preprocess_input("Hello"))
    # value = BotConfig.model.predict(preprocess_input("Hello"))
    return HttpResponse(testPrediction())


@api_view(['POST'])
@permission_classes((permissions.AllowAny,))
def getData(req):
    # serializer = BotRequestSerializer(data=req.data)
    try:
        value = testPrediction(req.data['query'])
        answer = {"query":req.data['query'], "answer":value}
        return Response(answer)
    except ValueError:
        return Response({"error":"Cant understand you"})
    except KeyError:
        answer = externalPrediction(req.data['query'])
        if(answer['Abstract']!=""):
            return Response({"query":req.data['query'], "answer":answer['Abstract']})
        else:
            return Response({"error":"Cant understand you"})
        
    # finally:
    #     return Response({"error":"Cant understand you, ask something else"})
    

@permission_classes((permissions.AllowAny,))
class BotView(APIView):
    def get_result(self, request):
        serializer = BotRequestSerializer(data=request.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
        
    




maxlen_answers=74
maxlen_questions=22
VOCAB_SIZE=1894
encoder_inputs = Input(shape=(maxlen_questions ,))
encoder_embedding = Embedding(VOCAB_SIZE, 200 , mask_zero=True) (encoder_inputs)
encoder_outputs , state_h , state_c = LSTM(200 , return_state=True)(encoder_embedding)
encoder_states = [ state_h , state_c ]
decoder_inputs = Input(shape=(maxlen_answers , ))
decoder_embedding = Embedding(VOCAB_SIZE, 200 , mask_zero=True) (decoder_inputs)
decoder_lstm = LSTM(200 , return_state=True , return_sequences=True)
decoder_outputs , _ , _ = decoder_lstm (decoder_embedding , initial_state=encoder_states)
decoder_dense = Dense(VOCAB_SIZE , activation=softmax) 
output = decoder_dense (decoder_outputs)

def loadModels():
    with open('models/enc-model.pkl', 'rb') as enc:
        enc_model = pickle.load(enc)
    with open('models/dec-model.pkl', 'rb') as dec:
        dec_model = pickle.load(dec)
    return enc_model, dec_model

enc_model, dec_model = loadModels()
encoder_inputs = enc_model.input
encoder_states = enc_model.output
decoder_inputs = dec_model.input[0]  # Assuming the first input is the decoder input
decoder_embedding = dec_model.layers[1]  # Assuming the second layer is the embedding layer
decoder_lstm = dec_model.layers[2]  # Assuming the third layer is the LSTM layer
decoder_dense = dec_model.layers[3] 

def inference():
    encoder_model = Model(encoder_inputs, encoder_states)
    decoder_state_input_h = Input(shape=( 200 ,),name='anotherInput1')
    decoder_state_input_c = Input(shape=( 200 ,),name='anotherInput2')
    
    decoder_states_inputs = [decoder_state_input_h, decoder_state_input_c]
    
    decoder_outputs, state_h, state_c = decoder_lstm(
        decoder_embedding , initial_state=decoder_states_inputs)
    
    decoder_states = [state_h, state_c]

    decoder_outputs = decoder_dense(decoder_outputs)
    
    decoder_model = Model(
        [decoder_inputs] + decoder_states_inputs,
        [decoder_outputs] + decoder_states)
    
    return encoder_model , decoder_model
    # encoder_inputs = Input(shape=(maxlen_questions ,), name='anotherInput1')
    # encoder_embedding = Embedding(VOCAB_SIZE, 200 , mask_zero=True) (encoder_inputs)
    # encoder_outputs , state_h , state_c = LSTM(200 , return_state=True)(encoder_embedding)
    # encoder_states = [ state_h , state_c ]
    
    # encoder_model = Model(encoder_inputs, encoder_states)
    
    # decoder_state_input_h = Input(shape=(200 ,), name='anotherInput2')
    # decoder_state_input_c = Input(shape=(200 ,), name='anotherInput3')
    
    # decoder_states_inputs = [decoder_state_input_h, decoder_state_input_c]
    
    # decoder_outputs, state_h, state_c = decoder_lstm(
    #     decoder_embedding , initial_state=decoder_states_inputs)
    # decoder_states = [state_h, state_c]
    # decoder_outputs = decoder_dense(decoder_outputs)
    # decoder_model = Model(
    #     [decoder_inputs] + decoder_states_inputs,
    #     [decoder_outputs] + decoder_states)
    # # decoder_model.name="model2"
    # return encoder_model , decoder_model

def load_word_index():
    with open('models/tokenizer_word_index.pkl', 'rb') as f:
        return pickle.load(f)
    

# tokenizer = text.Tokenizer()
word_index = load_word_index()
def preprocess_input(input_sentence):
    tokens = input_sentence.lower().split()
    tokens_list = []
    for word in tokens:
        tokens_list.append(word_index[word]) 
    return pad_sequences([tokens_list] , maxlen=maxlen_questions , padding='post')

def str_to_tokens( sentence : str ):
        words = sentence.lower().replace("?","").split()
        tokens_list = list()
        for word in words:
            tokens_list.append(word_index[ word ] ) 
        return pad_sequences( [tokens_list] , maxlen=maxlen_questions , padding='post')
    
def testPrediction(query : str):
    enc_model , dec_model = BotConfig.enc_model, BotConfig.dec_model
    # states_values = enc_model.predict(preprocess_input("Who is your mother"))
    states_values = enc_model.predict(str_to_tokens(query))
    empty_target_seq = np.zeros( ( 1 , 1 ) )
    empty_target_seq[0, 0] = word_index['start']
    stop_condition = False
    decoded_translation = ''
    i = 0
    while not stop_condition :
        dec_outputs , h , c = dec_model.predict([empty_target_seq] + states_values)
        sampled_word_index = np.argmax(dec_outputs[0, -1, :])
        sampled_word = None
        
        for word , index in word_index.items() :
            if sampled_word_index == index :
                decoded_translation += f' {word}'
                sampled_word = word
        
        if sampled_word == 'end' or len(decoded_translation.split()) > maxlen_answers:
            stop_condition = True
            
        empty_target_seq = np.zeros((1 , 1))  
        empty_target_seq[0 , 0] = sampled_word_index
        states_values = [h , c]
    decoded_translation = decoded_translation.split(' end')[0]
    return decoded_translation

sendQueryDDGUrl: str = "https://api.duckduckgo.com/?format=json&pretty=1&q="
def externalPrediction(query:str):
    proccessedQuery = query.replace("?","")
    response = requests.get(sendQueryDDGUrl+proccessedQuery)
    print(response.json())
    return response.json()
    
    




