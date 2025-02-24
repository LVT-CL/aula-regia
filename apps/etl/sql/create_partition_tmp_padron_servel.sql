CREATE TABLE staging."tmp_padron_servel_{{id_archivo}}"
PARTITION OF staging.tmp_padron_servel
FOR VALUES IN ('{{id_archivo}}');