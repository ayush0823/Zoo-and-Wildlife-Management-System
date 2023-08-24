from django.db import models

class zooModel(models.Model):
    z_id=models.IntegerField(primary_key=True, db_column='z_id')
    name=models.CharField(max_length=100)
    s_id=models.IntegerField()
    area_covered=models.FloatField()
    class Meta:
        db_table="zoo"

class mrModel(models.Model):
    mr_id=models.IntegerField(primary_key=True, db_column='mr_id')
    source_id=models.IntegerField()
    destination_id=models.IntegerField()
    animal_id=models.IntegerField()
    animal_count=models.IntegerField()
    reason=models.CharField(max_length=100)
    class Meta:
        db_table="migration_record"