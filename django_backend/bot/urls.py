from django.urls import path
from . import views

urlpatterns = [
    path("", views.home, name="home"),
    path("bot-view", views.BotView.as_view(), name="bot-view"),
    path("get-data", views.getData)
]
