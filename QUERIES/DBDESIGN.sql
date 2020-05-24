--STORE MATCH SCHEDULE
CREATE TABLE PREDICTAMatchSchedule(
	MatchDate DATE,
	intMeeting TINYINT,
	intMatchNumber SMALLINT PRIMARY KEY IDENTITY,
	intTeamCodes INT,
	intWonOrLose INT,
	txtDay CHAR(3)
)

--STORE PARTICIPATING TEAMS

CREATE TABLE PREDICTATeams(
	intTeamCode INT PRIMARY KEY,
	txtTeamName VARCHAR(10),
	intWon INT,
	intLost INT,
	intOthers INT
)
--DROP TABLE PREDICTAMatchSchedule
--STORE PARTICIPATING USERS

CREATE TABLE PREDICTAUsers(
	intUserCode INT PRIMARY KEY IDENTITY,
	txtUserMailId VARCHAR(50),
	txtUserName VARCHAR(50),
	isActiveUser BIT
)

--STORE PARTICIPATING PLAYERS IN TEAMS

CREATE TABLE PREDICTATeamPlayers(
	txtPlayerCode VARCHAR(10),
	intTeamCode INT REFERENCES PREDICTATeams(intTeamCode),
	txtPlayerName VARCHAR(50)
)

--STORE SCORES OF USERS

CREATE TABLE PREDICTATotalScores(
	intUserCode INT REFERENCES PREDICTAUsers(intUserCode),
	intTotalScore INT
)

--STORE PREDICTIONS SNAPSHOTS OF USERS FOR EACH MATCH

CREATE TABLE PREDICTAUserPredictionsRecord(
	intUserCode INT REFERENCES PREDICTAUsers(intUserCode),
	intMatchNo SMALLINT REFERENCES PREDICTAMatchSchedule(intMatchNumber),
	txtPredictions VARCHAR(100),
	txtPredictionResults VARCHAR(100),
	intEarnedPoints SMALLINT,
	PRIMARY KEY (intUserCode,intMatchNo)
)

CREATE TABLE PREDICTALatestPredictions(
	intUserCode INT REFERENCES PREDICTAUsers(intUserCode),
	intMatchNo SMALLINT REFERENCES PREDICTAMatchSchedule(intMatchNumber),
	txtPredictions VARCHAR(100),
	txtPredictionResults VARCHAR(100),
	intEarnedPoints SMALLINT,
	PRIMARY KEY (intUserCode,intMatchNo)
)

CREATE TABLE PREDICTAAdmins(
	intAdminCode INT PRIMARY KEY IDENTITY,
	txtAdminMailid VARCHAR(50),
	txtAdminName VARCHAR(50)
)


--insert queries


-- team table : PREDICTATeams

INSERT INTO PREDICTATeams VALUES(1,'MI',NULL,NULL,NULL)
INSERT INTO PREDICTATeams VALUES(2,'CSK',NULL,NULL,NULL)
INSERT INTO PREDICTATeams VALUES(3,'RR',NULL,NULL,NULL)
INSERT INTO PREDICTATeams VALUES(4,'RCB',NULL,NULL,NULL)
INSERT INTO PREDICTATeams VALUES(5,'KKR',NULL,NULL,NULL)
INSERT INTO PREDICTATeams VALUES(6,'DD',NULL,NULL,NULL)
INSERT INTO PREDICTATeams VALUES(7,'SRH',NULL,NULL,NULL)
INSERT INTO PREDICTATeams VALUES(8,'KXIP',NULL,NULL,NULL)

SELECT * FROM PREDICTATeams

-- schedule table : PREDICTAMatchSchedule

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-07',2,12,null,'SAT')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-08',1,68,null,'SUN')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-08',2,54,null,'SUN')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-09',2,73,null,'OTH')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-10',2,25,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-11',2,36,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-12',2,71,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-13',2,48,null,'OTH')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-14',1,16,null,'SAT')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-14',2,57,null,'SAT')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-15',1,43,null,'SUN')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-15',2,82,null,'SUN')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-16',2,56,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-17',2,14,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-18',2,35,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-19',2,87,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-20',2,23,null,'OTH')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-21',1,58,null,'SAT')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-21',2,64,null,'SAT')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-22',1,72,null,'SUN')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-22',2,31,null,'SUN')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-23',2,86,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-24',2,17,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-25',2,42,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-26',2,78,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-27',2,65,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-28',2,21,null,'SAT')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-29',1,37,null,'SUN')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-29',2,45,null,'SUN')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-04-30',2,26,null,'OTH')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-01',2,41,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-02',2,63,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-03',2,52,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-04',2,81,null,'OTH')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-05',1,24,null,'SAT')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-05',2,76,null,'SAT')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-06',1,15,null,'SUN')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-06',2,83,null,'SUN')

INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-07',2,74,null,'OTH')
INSERT INTO PREDICTAMatchSchedule VALUES('2018-05-08',2,38,null,'OTH')

select * from PREDICTAMatchSchedule



--Players : 

INSERT INTO PREDICTATeamPlayers VALUES('MI_01',1,'Rohit Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('MI_02',1,'Hardik Pandya')
INSERT INTO PREDICTATeamPlayers VALUES('MI_03',1,'Jasprit Bumrah')
INSERT INTO PREDICTATeamPlayers VALUES('MI_04',1,'Krunal Pandya')
INSERT INTO PREDICTATeamPlayers VALUES('MI_05',1,'Ishan Kishan')
INSERT INTO PREDICTATeamPlayers VALUES('MI_06',1,'Kieron Pollard')
INSERT INTO PREDICTATeamPlayers VALUES('MI_07',1,'Pat Cummins')
INSERT INTO PREDICTATeamPlayers VALUES('MI_08',1,'Evin Lewis')
INSERT INTO PREDICTATeamPlayers VALUES('MI_09',1,'Surya Kumar Yadav')
INSERT INTO PREDICTATeamPlayers VALUES('MI_10',1,'Mustafizur Rahman')
INSERT INTO PREDICTATeamPlayers VALUES('MI_11',1,'Ben Cutting')
INSERT INTO PREDICTATeamPlayers VALUES('MI_12',1,'Rahul Chahar')
INSERT INTO PREDICTATeamPlayers VALUES('MI_13',1,'Pradeep Sangwan')
INSERT INTO PREDICTATeamPlayers VALUES('MI_14',1,'Jason Behrendorff')
INSERT INTO PREDICTATeamPlayers VALUES('MI_15',1,'JP Duminy')
INSERT INTO PREDICTATeamPlayers VALUES('MI_16',1,'Saurabh Tiwary')
INSERT INTO PREDICTATeamPlayers VALUES('MI_17',1,'Tajinder Dhillon')
INSERT INTO PREDICTATeamPlayers VALUES('MI_18',1,'Akila Dhananjaya')
INSERT INTO PREDICTATeamPlayers VALUES('MI_19',1,'Siddhesh Lad')
INSERT INTO PREDICTATeamPlayers VALUES('MI_20',1,'Aditya Tare')
INSERT INTO PREDICTATeamPlayers VALUES('MI_21',1,'Mayank Markande')
INSERT INTO PREDICTATeamPlayers VALUES('MI_22',1,'Anukul Roy')
INSERT INTO PREDICTATeamPlayers VALUES('MI_23',1,'harad Lumba')
INSERT INTO PREDICTATeamPlayers VALUES('MI_24',1,'Mohsin Khan')
INSERT INTO PREDICTATeamPlayers VALUES('MI_25',1,'MD Nidheesh')
INSERT INTO PREDICTATeamPlayers VALUES('MI_26',1,'MD Dinesan')

INSERT INTO PREDICTATeamPlayers VALUES('CSK_01',2,'MS Dhoni')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_02',2,'Suresh Raina')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_03',2,'Ravindra Jadeja')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_04',2,'Kedar Jadhav')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_05',2,'Dwayne Bravo')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_06',2,'Karn Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_07',2,'Shane Watson')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_08',2,'Shardul Thakur')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_09',2,'Ambati Rayudu')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_10',2,'Murali Vijay')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_11',2,'Harbhajan Singh')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_12',2,'Faf Du Plessis')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_13',2,'Mark Wood')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_14',2,'Sam Billings')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_15',2,'Imran Tahir')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_16',2,'Deepak Chahar')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_17',2,'Mitchell Santner')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_18',2,'Lungisani Ngidi')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_19',2,'KM Asif')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_20',2,'Kshitiz Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_21',2,'Monu Singh')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_22',2,'Jagadeesan Narayan')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_23',2,'Dhruv Shorey')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_24',2,'Kanishk Seth')
INSERT INTO PREDICTATeamPlayers VALUES('CSK_25',2,'Chaitanya Bishno')

INSERT INTO PREDICTATeamPlayers VALUES('RR_01',3,'Steve Smith')
INSERT INTO PREDICTATeamPlayers VALUES('RR_02',3,'Ben Stokes')
INSERT INTO PREDICTATeamPlayers VALUES('RR_03',3,'Jaydev Unadkat')
INSERT INTO PREDICTATeamPlayers VALUES('RR_04',3,'Sanju Samson')
INSERT INTO PREDICTATeamPlayers VALUES('RR_05',3,'Jofra Archer')
INSERT INTO PREDICTATeamPlayers VALUES('RR_06',3,'Gowtham Krishnappa')
INSERT INTO PREDICTATeamPlayers VALUES('RR_07',3,'Jos Buttler')
INSERT INTO PREDICTATeamPlayers VALUES('RR_08',3,'Ajinkya Rahane')
INSERT INTO PREDICTATeamPlayers VALUES('RR_09',3,'Darcy Short')
INSERT INTO PREDICTATeamPlayers VALUES('RR_10',3,'Rahul Tripathi')
INSERT INTO PREDICTATeamPlayers VALUES('RR_11',3,'Dhawal Kulkarni')
INSERT INTO PREDICTATeamPlayers VALUES('RR_12',3,'Zahir Khan')
INSERT INTO PREDICTATeamPlayers VALUES('RR_13',3,'Ben Laughlin')
INSERT INTO PREDICTATeamPlayers VALUES('RR_14',3,'Dushmanta Chameera')
INSERT INTO PREDICTATeamPlayers VALUES('RR_15',3,'Stuart Binny')
INSERT INTO PREDICTATeamPlayers VALUES('RR_16',3,'Aryaman Vikram Birla')
INSERT INTO PREDICTATeamPlayers VALUES('RR_17',3,'Anureet Singh Kathuria')
INSERT INTO PREDICTATeamPlayers VALUES('RR_18',3,'Prashant Chopra')
INSERT INTO PREDICTATeamPlayers VALUES('RR_19',3,'Ankit Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('RR_20',3,'Midhun S')
INSERT INTO PREDICTATeamPlayers VALUES('RR_21',3,'Shreyas Gopal')
INSERT INTO PREDICTATeamPlayers VALUES('RR_22',3,'Jatin Saxena')
INSERT INTO PREDICTATeamPlayers VALUES('RR_23',3,'Mahipal Lomror')

INSERT INTO PREDICTATeamPlayers VALUES('RCB_01',4,'Virat Kohli')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_02',4,'AB de Villiers')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_03',4,'Sarfraz Khan')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_04',4,'Chris Woakes')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_05',4,'Yuzvendra Chahal')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_06',4,'Umesh Yadav')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_07',4,'Brendon McCullum')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_08',4,'Washington Sundar')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_09',4,'Navdeep Saini')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_10',4,'Quinton De Kock')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_11',4,'Mohd Siraj')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_12',4,'Colin De Grandhomme')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_13',4,'Murugan Ashwin')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_14',4,'Nathan Coulter-Nile')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_15',4,'Parthiv Patel')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_16',4,'Moeen Ali')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_17',4,'Mandeep Singh')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_18',4,'Manan Vohra')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_19',4,'Tim Southee')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_20',4,'Pawan Negi')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_21',4,'Kulwant Khejroliya')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_22',4,'Aniket Choudhary')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_23',4,'Anirudha Joshi')
INSERT INTO PREDICTATeamPlayers VALUES('RCB_24',4,'Pavan Deshpande')

INSERT INTO PREDICTATeamPlayers VALUES('KKR_01',5,'Sunil Narine')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_02',5,'Andre Russell')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_03',5,'Chris Lynn')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_04',5,'Mitchell Starc')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_05',5,'Dinesh Karthik')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_06',5,'Robin Uthappa')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_07',5,'Kuldeep Yadav')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_08',5,'Piyush Chawla')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_09',5,'Nitish Rana')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_10',5,'Kamlesh Nagarkoti')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_11',5,'Shivam Mavi')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_12',5,'Mitchell Johnson')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_13',5,'Shubman Gill')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_14',5,'R Vinay Kumar')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_15',5,'Rinku Singh')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_16',5,'Cameron Delport')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_17',5,'Javon Searless')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_18',5,'Ishank Jaggi')
INSERT INTO PREDICTATeamPlayers VALUES('KKR_10',5,'Apoorv Wankhade')


INSERT INTO PREDICTATeamPlayers VALUES('DD_01',6,'Rishabh Pant')
INSERT INTO PREDICTATeamPlayers VALUES('DD_02',6,'Chris Morris')
INSERT INTO PREDICTATeamPlayers VALUES('DD_03',6,'Shreyas Iyer')
INSERT INTO PREDICTATeamPlayers VALUES('DD_04',6,'Glenn Maxwell')
INSERT INTO PREDICTATeamPlayers VALUES('DD_05',6,'Kagiso Rabada')
INSERT INTO PREDICTATeamPlayers VALUES('DD_06',6,'Amit Mishra')
INSERT INTO PREDICTATeamPlayers VALUES('DD_07',6,'Vijay Shankar')
INSERT INTO PREDICTATeamPlayers VALUES('DD_08',6,'Shahbaz Nadeem')
INSERT INTO PREDICTATeamPlayers VALUES('DD_09',6,'Rahul Tewatia')
INSERT INTO PREDICTATeamPlayers VALUES('DD_10',6,'Mohammed Shami')
INSERT INTO PREDICTATeamPlayers VALUES('DD_11',6,'Gautam Gambhir')
INSERT INTO PREDICTATeamPlayers VALUES('DD_12',6,'Trent Boult')
INSERT INTO PREDICTATeamPlayers VALUES('DD_13',6,'Colin Munro')
INSERT INTO PREDICTATeamPlayers VALUES('DD_14',6,'Jason Roy')
INSERT INTO PREDICTATeamPlayers VALUES('DD_15',6,'Daniel Christian')
INSERT INTO PREDICTATeamPlayers VALUES('DD_16',6,'Naman Ojha')
INSERT INTO PREDICTATeamPlayers VALUES('DD_17',6,'Prithvi Shaw')
INSERT INTO PREDICTATeamPlayers VALUES('DD_18',6,'Gurkeerat Singh')
INSERT INTO PREDICTATeamPlayers VALUES('DD_19',6,'Avesh Khan')
INSERT INTO PREDICTATeamPlayers VALUES('DD_20',6,'Abhishek Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('DD_21',6,'Jayant Yadav')
INSERT INTO PREDICTATeamPlayers VALUES('DD_22',6,'Sandeep Lamichhane')
INSERT INTO PREDICTATeamPlayers VALUES('DD_23',6,'Sayan Ghosh')
INSERT INTO PREDICTATeamPlayers VALUES('DD_24',6,'Harshal Patel')
INSERT INTO PREDICTATeamPlayers VALUES('DD_25',6,'Manjot Kalra')

INSERT INTO PREDICTATeamPlayers VALUES('SRH_01',7,'David Warner')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_02',7,'Bhuvneshwar Kumar')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_03',7,'Manish Pandey')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_04',7,'Rashid Khan')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_05',7,'Shikhar Dhawan')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_06',7,'Wriddhiman Saha')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_07',7,'Kane Williamson')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_08',7,'Sandeep Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_09',7,'Shakib Hasan')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_10',7,'Carlos Brathwaite')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_11',7,'Yusuf Pathan')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_12',7,'Mohammad Nabi Eisakhil')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_13',7,'Chris Jordan')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_14',7,'Billy Stanlake')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_15',7,'Siddharth Kaul')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_16',7,'Deepak Hooda')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_17',7,'Syed Khaleel Ahmed')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_18',7,'Shreevats Goswami')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_19',7,'Basil Thampi')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_20',7,'T Natarajan')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_21',7,'Bipul Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_22',7,'Mehdi Hasan')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_23',7,'Ricky Bhui')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_24',7,'Sachin Baby')
INSERT INTO PREDICTATeamPlayers VALUES('SRH_25',7,'Tanmay Agarwal')

INSERT INTO PREDICTATeamPlayers VALUES('KXIP_01',8,'Axar Patel')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_02',8,'KL Rahul')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_03',8,'Ravichandran Ashwin')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_04',8,'Andrew Tye')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_05',8,'Aaron Finch')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_06',8,'Marcus Stoinis')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_07',8,'Karun Nair')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_08',8,'Mujeeb Zadran')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_09',8,'David Miller')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_10',8,'Ankit Singh Rajpoot')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_11',8,'Mohit Sharma')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_12',8,'Barinder Sran')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_13',8,'Chris Gayle')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_14',8,'Yuvraj Singh')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_15',8,'Ben Dwarshuis')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_16',8,'Mayank Agarwal')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_17',8,'Manoj Tiwary')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_18',8,'Akshdeep Nath')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_19',8,'Mayank Dagar')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_20',8,'Manzoor Dar')
INSERT INTO PREDICTATeamPlayers VALUES('KXIP_21',8,'Pradeep Sahu')



select * from PREDICTATeamPlayers where intTeamCode = 8

SELECT * FROM PREDICTATeams

select * from PREDICTAMatchSchedule

select * from PREDICTATeamPlayers where intTeamCode = 9

select * from PREDICTAUsers

INSERT INTO PREDICTAUsers VALUES('SHIVENDRA.CHAUHAN','SHIVENDRA',1)





select * from PREDICTATotalScores
select * from PREDICTAUserPredictionsRecord
select * from PREDICTALatestPredictions



p1- who will win the toss?
p2 - who will be mom?
p3- no. of 4 /6 in innings1
p4- no. of 4 /6 in innings2
p5- what will happen(in terms of runs) on 16.1 over in innings1?

correct code : 1%MI_1%4,2%2,1%5

ps1 - 1%CSK_2%2,3%2,2%1

1
MI_1
4,2
2,1
5

1
CSK_2
2,3
2,2
1