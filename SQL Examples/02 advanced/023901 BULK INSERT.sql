USE demo

DROP TABLE IF EXISTS CustomerSignature

CREATE TABLE CustomerSignature(
recordID NVARCHAR(255) NULL,
state NVARCHAR(255) NULL,
account_length NVARCHAR(255) NULL,
area_code NVARCHAR(255) NULL,
international_plan NVARCHAR(255) NULL,
voice_mail_plan NVARCHAR(255) NULL,
number_vmail_messages NVARCHAR(255) NULL,
total_day_minutes NVARCHAR(255) NULL,
total_day_calls NVARCHAR(255) NULL,
total_day_charge NVARCHAR(255) NULL,
total_eve_minutes NVARCHAR(255) NULL,
total_eve_calls NVARCHAR(255) NULL,
total_eve_charge NVARCHAR(255) NULL,
total_night_minutes NVARCHAR(255) NULL,
total_night_calls NVARCHAR(255) NULL,
total_night_charge NVARCHAR(255) NULL,
total_intl_minutes NVARCHAR(255) NULL,
total_intl_calls NVARCHAR(255) NULL,
total_intl_charge NVARCHAR(255) NULL,
number_customer_service_calls NVARCHAR(255) NULL,
churn NVARCHAR(255) NULL,
customer_id NVARCHAR(255) NULL
)

BULK INSERT CustomerSignature
FROM 'E:\customer_data_edited.csv'
WITH (
FIELDTERMINATOR = ',',
FIRSTROW = 2
);

SELECT * FROM CustomerSignature

DROP TABLE CustomerSignature