from django import forms
from wildlife_db.models import zooModel, mrModel

class zooForm(forms.ModelForm):
    class Meta:
        model=zooModel
        fields="__all__"

class mrForm(forms.ModelForm):
    class Meta:
        model=mrModel
        fields="__all__"