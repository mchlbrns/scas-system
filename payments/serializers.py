from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from .models import DailyPayment

class DailyPaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = DailyPayment
        fields = '__all__'
        validators = [
            UniqueTogetherValidator(
                queryset=DailyPayment.objects.all(),
                fields=['client', 'analyst', 'payment_date']
            )
        ]

    def validate_amount(self, value):
        if value < 0:
            raise serializers.ValidationError("Amount cannot be negative.")
        return value
