from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from .models import Receivable

class ReceivableSerializer(serializers.ModelSerializer):
    class Meta:
        model = Receivable
        fields = '__all__'
        validators = [
            UniqueTogetherValidator(
                queryset=Receivable.objects.all(),
                fields=['client', 'analyst', 'report_date']
            )
        ]

    def validate(self, data):
        # Validation: No negative monetary values? 
        # "Validation Rules: No negative monetary values"
        # BUT "neg_amount" implies negative... 
        # Usually "Negative Receivables" means the amount is negative in accounting terms, 
        # but the request says "pos_amount" and "neg_amount". 
        # It's possible "neg_amount" should be stored as positive number representing the negative receivables?
        # Or "No negative monetary values" applies to Payment/PTP?
        # Let's assume input fields must be positive absolute values for counts/amounts, 
        # or maybe the User meant "don't allow -100 for payment". 
        # For Receivable "neg_amount", it might mean "Amount of Negative Receivables". 
        # I will enforce >= 0 for all fields to be safe and consistent with "No negative monetary values" rule.
        # If the user specifically wants negative numbers in DB, they can update, but "No negative monetary values" is explicit.
        
        errors = {}
        if data.get('pos_amount', 0) < 0:
            errors['pos_amount'] = "Must be non-negative."
        if data.get('neg_amount', 0) < 0:
            errors['neg_amount'] = "Must be non-negative."
        if data.get('pos_account_count', 0) < 0:
            errors['pos_account_count'] = "Must be non-negative."
        if data.get('neg_account_count', 0) < 0:
            errors['neg_account_count'] = "Must be non-negative."
            
        if errors:
            raise serializers.ValidationError(errors)
            
        return data
