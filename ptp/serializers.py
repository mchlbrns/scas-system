from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from .models import DailyPTP

class DailyPTPSerializer(serializers.ModelSerializer):
    class Meta:
        model = DailyPTP
        fields = '__all__'
        validators = [
            UniqueTogetherValidator(
                queryset=DailyPTP.objects.all(),
                fields=['client', 'analyst', 'ptp_date']
            )
        ]

    def validate_ptp_amount(self, value):
        if value < 0:
            raise serializers.ValidationError("PTP Amount cannot be negative.")
        return value
