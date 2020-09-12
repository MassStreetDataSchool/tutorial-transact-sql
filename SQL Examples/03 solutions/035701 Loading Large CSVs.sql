USE demo

DROP TABLE IF EXISTS temp.FlightsStaging
DROP SCHEMA IF EXISTS temp
DROP VIEW IF EXISTS FlightsStaging

GO

CREATE SCHEMA temp

CREATE TABLE temp.FlightsStaging(
[ETLKey] [uniqueidentifier] NOT NULL,
year NVARCHAR(255) NULL,
month NVARCHAR(255) NULL,
day NVARCHAR(255) NULL,
dep_time NVARCHAR(255) NULL,
sched_dep_time NVARCHAR(255) NULL,
dep_delay NVARCHAR(255) NULL,
arr_time NVARCHAR(255) NULL,
sched_arr_time NVARCHAR(255) NULL,
arr_delay NVARCHAR(255) NULL,
carrier NVARCHAR(255) NULL,
flight NVARCHAR(255) NULL,
tailnum NVARCHAR(255) NULL,
origin NVARCHAR(255) NULL,
dest NVARCHAR(255) NULL,
air_time NVARCHAR(255) NULL,
distance NVARCHAR(255) NULL,
hour NVARCHAR(255) NULL,
minute NVARCHAR(255) NULL,
time_hour NVARCHAR(255) NULL,
[UniqueDims] [varbinary](35) NULL,
[UniqueRows] [varbinary](16) NULL,
[SourceSystem] [nvarchar](255) NULL,
[Cleansed] [bit] NULL,
[ErrorRecord] [bit] NULL,
[ErrorReason] [nvarchar](255) NULL,
[Processed] [bit] NULL,
[RunDate] [datetime] NULL,
CONSTRAINT [PK_FlightsStaging] PRIMARY KEY CLUSTERED 
(
       [ETLKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE temp.FlightsStaging ADD  CONSTRAINT [DF_FlightsStaging_ETLKey]  DEFAULT (newid()) FOR [ETLKey]
GO

ALTER TABLE temp.FlightsStaging ADD  CONSTRAINT [DF_FlightsStaging_SourceSystem]  DEFAULT (N'Flights System') FOR [SourceSystem]
GO

ALTER TABLE temp.FlightsStaging ADD  CONSTRAINT [DF_FlightsStaging_Cleansed]  DEFAULT ((0)) FOR [Cleansed]
GO

ALTER TABLE temp.FlightsStaging ADD  CONSTRAINT [DF_FlightsStaging_ErrorRecord]  DEFAULT ((0)) FOR [ErrorRecord]
GO

ALTER TABLE temp.FlightsStaging ADD  CONSTRAINT [DF_FlightsStaging_Processed]  DEFAULT ((0)) FOR [Processed]
GO

ALTER TABLE temp.FlightsStaging ADD  CONSTRAINT [DF_FlightsStaging_RunDate]  DEFAULT (getdate()) FOR [RunDate]
GO

CREATE VIEW FlightsStaging
AS
SELECT
year,
month,
day,
dep_time,
sched_dep_time,
dep_delay,
arr_time,
sched_arr_time,
arr_delay,
carrier,
flight,
tailnum,
origin,
dest,
air_time,
distance,
hour,
minute,
time_hour
FROM temp.FlightsStaging
GO
--Begin Load
ALTER TABLE [temp].[FlightsStaging] DROP CONSTRAINT [PK_FlightsStaging] WITH ( ONLINE = OFF )
GO

--Insert into the view
BULK INSERT FlightsStaging
FROM 'E:\flights.csv'
WITH (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0x0a',
FIRSTROW = 2
);

ALTER TABLE [temp].[FlightsStaging] ADD  CONSTRAINT [PK_FlightsStaging] PRIMARY KEY CLUSTERED 
(
   [ETLKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

--but the records went to the actual table
SELECT *
FROM temp.FlightsStaging



DROP TABLE temp.FlightsStaging
DROP SCHEMA temp
DROP VIEW FlightsStaging