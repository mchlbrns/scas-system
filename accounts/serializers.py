from rest_framework import serializers
from .models import Account, ImportSchema

class AccountSerializer(serializers.ModelSerializer):
    client_name = serializers.CharField(source='client.client_name', read_only=True)
    assigned_analyst_name = serializers.CharField(source='assigned_analyst.user.username', read_only=True, allow_null=True)

    class Meta:
        model = Account
        fields = [
            'id', 'client', 'client_name', 'account_number', 'account_name',
            'endorsement_date', 'recall_date', 'outstanding_balance',
            'status', 'assigned_analyst', 'assigned_analyst_name',
            'data_payload', 'client_template', 'created_at', 'updated_at'
        ]

    client_template = serializers.SerializerMethodField()

    def get_client_template(self, obj):
        # Fetch the active import schema for this client to determine the layout
        schema = ImportSchema.objects.filter(client=obj.client, is_active=True).first()
        if schema and schema.display_config:
             return schema.display_config
        return None

from .models import ImportSchema, ColumnMapping

class ColumnMappingSerializer(serializers.ModelSerializer):
    class Meta:
        model = ColumnMapping
        fields = ['id', 'csv_header', 'target_field', 'data_type', 'is_required', 'default_value']

class ImportSchemaSerializer(serializers.ModelSerializer):
    column_mappings = ColumnMappingSerializer(many=True)
    client_name = serializers.CharField(source='client.client_name', read_only=True)

    class Meta:
        model = ImportSchema
        fields = ['id', 'client', 'client_name', 'name', 'is_active', 'display_config', 'created_at', 'column_mappings']

    def create(self, validated_data):
        mappings_data = validated_data.pop('column_mappings')
        schema = ImportSchema.objects.create(**validated_data)
        for mapping_data in mappings_data:
            ColumnMapping.objects.create(schema=schema, **mapping_data)
        return schema
    
    def update(self, instance, validated_data):
        mappings_data = validated_data.pop('column_mappings', None)
        instance = super().update(instance, validated_data)
        
        if mappings_data is not None:
            instance.column_mappings.all().delete()
            for mapping_data in mappings_data:
                ColumnMapping.objects.create(schema=instance, **mapping_data)
        return instance

from .models import ImportBatch

class ImportBatchSerializer(serializers.ModelSerializer):
    client_name = serializers.CharField(source='client.client_name', read_only=True)

    class Meta:
        model = ImportBatch
        fields = ['id', 'client', 'client_name', 'filename', 'uploaded_at', 'endorsement_date', 'record_count']

from .models import ActivityLog, AccountPTP

class ActivityLogSerializer(serializers.ModelSerializer):
    created_by_name = serializers.CharField(source='created_by.analyst_name', read_only=True)

    class Meta:
        model = ActivityLog
        fields = ['id', 'account', 'action', 'outcome', 'remarks', 'created_by', 'created_by_name', 'created_at']

class AccountPTPSerializer(serializers.ModelSerializer):
    created_by_name = serializers.CharField(source='created_by.analyst_name', read_only=True)

    class Meta:
        model = AccountPTP
        fields = ['id', 'account', 'amount', 'ptp_date', 'status', 'created_by', 'created_by_name', 'created_at', 'source_activity']
