from rest_framework import serializers
# from django.contrib.auth.models import User
from .models import BotRequestModel
class BotRequestSerializer(serializers.Serializer):
    query : str
    