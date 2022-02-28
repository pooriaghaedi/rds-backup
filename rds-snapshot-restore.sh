#!/bin/bash

# listing all snapshots
aws rds describe-db-snapshots

# Restoring a snapshot

db_instanse_identifier=restored-snapshot

# choose one snapshot from list snapshot command or use the latest one as below
db_snapshot_identifier=$(aws rds describe-db-snapshots   --query="reverse(sort_by(DBSnapshots, &SnapshotCreateTime))[0]|DBSnapshotIdentifier"   --output text)

#chose the instance class for your restored database
db_instance_class=db.t2.micro

#restore the database
aws rds restore-db-instance-from-db-snapshot  \
	--db-instance-identifier "${db_instanse_identifier}" \
	--db-snapshot-identifier "${db_snapshot_identifier}" \
	--db-instance-class "${db_instance_class}" 


### Wait until the restored DB instance becomes available ###
aws rds wait db-instance-available --db-instance-identifier "${db_instanse_identifier}"

