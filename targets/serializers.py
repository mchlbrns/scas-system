from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from .models import Target

class TargetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Target
        fields = '__all__'
        validators = [
            UniqueTogetherValidator(
                queryset=Target.objects.all(),
                fields=['client', 'target_month']
            )
        ]

    def validate_internal_target(self, value):
        if value < 0:
            raise serializers.ValidationError("Target cannot be negative.")
        return value

    def validate_client_target(self, value):
        if value < 0:
            raise serializers.ValidationError("Target cannot be negative.")
        return value
