--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Debian 16.9-1.pgdg120+1)
-- Dumped by pg_dump version 16.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: backdoor_db_9tl9_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO backdoor_db_9tl9_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attendance; Type: TABLE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE TABLE public.attendance (
    id integer NOT NULL,
    service_number integer NOT NULL,
    service_date date,
    member_id integer NOT NULL,
    center_id integer NOT NULL,
    first_time character varying
);


ALTER TABLE public.attendance OWNER TO backdoor_db_9tl9_user;

--
-- Name: attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE SEQUENCE public.attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_id_seq OWNER TO backdoor_db_9tl9_user;

--
-- Name: attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER SEQUENCE public.attendance_id_seq OWNED BY public.attendance.id;


--
-- Name: center; Type: TABLE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE TABLE public.center (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.center OWNER TO backdoor_db_9tl9_user;

--
-- Name: center_id_seq; Type: SEQUENCE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE SEQUENCE public.center_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.center_id_seq OWNER TO backdoor_db_9tl9_user;

--
-- Name: center_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER SEQUENCE public.center_id_seq OWNED BY public.center.id;


--
-- Name: member; Type: TABLE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE TABLE public.member (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    gender character varying(10),
    contact character varying(20),
    residence character varying(100),
    home_district character varying(100),
    marital_status character varying(20),
    "course_Profession" character varying(100),
    year_of_study character varying(20),
    first_time character varying(10),
    center_id integer NOT NULL
);


ALTER TABLE public.member OWNER TO backdoor_db_9tl9_user;

--
-- Name: member_id_seq; Type: SEQUENCE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE SEQUENCE public.member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.member_id_seq OWNER TO backdoor_db_9tl9_user;

--
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER SEQUENCE public.member_id_seq OWNED BY public.member.id;


--
-- Name: soul; Type: TABLE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE TABLE public.soul (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    contact character varying(10) NOT NULL,
    residence character varying(100) NOT NULL,
    first_time character varying(10),
    service_number integer,
    service_date date,
    outreach_date date,
    source character varying(20),
    center_id integer NOT NULL
);


ALTER TABLE public.soul OWNER TO backdoor_db_9tl9_user;

--
-- Name: soul_id_seq; Type: SEQUENCE; Schema: public; Owner: backdoor_db_9tl9_user
--

CREATE SEQUENCE public.soul_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.soul_id_seq OWNER TO backdoor_db_9tl9_user;

--
-- Name: soul_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER SEQUENCE public.soul_id_seq OWNED BY public.soul.id;


--
-- Name: attendance id; Type: DEFAULT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.attendance ALTER COLUMN id SET DEFAULT nextval('public.attendance_id_seq'::regclass);


--
-- Name: center id; Type: DEFAULT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.center ALTER COLUMN id SET DEFAULT nextval('public.center_id_seq'::regclass);


--
-- Name: member id; Type: DEFAULT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.member ALTER COLUMN id SET DEFAULT nextval('public.member_id_seq'::regclass);


--
-- Name: soul id; Type: DEFAULT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.soul ALTER COLUMN id SET DEFAULT nextval('public.soul_id_seq'::regclass);


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: backdoor_db_9tl9_user
--

COPY public.attendance (id, service_number, service_date, member_id, center_id, first_time) FROM stdin;
155	542	2025-07-17	50	3	No
2	542	2025-07-10	2	1	Yes
4	542	2025-07-10	3	1	Yes
5	542	2025-07-10	47	1	Yes
6	542	2025-07-10	20	1	Yes
7	542	2025-07-10	30	1	Yes
8	542	2025-07-10	31	1	Yes
9	542	2025-07-10	15	1	Yes
10	542	2025-07-10	33	1	Yes
11	542	2025-07-10	34	1	Yes
12	542	2025-07-10	35	1	Yes
117	542	2025-07-27	49	1	Yes
15	542	2025-07-10	38	1	Yes
16	542	2025-07-10	26	1	Yes
17	542	2025-07-10	39	1	Yes
18	542	2025-07-10	27	1	Yes
19	542	2025-07-10	28	1	Yes
20	542	2025-07-10	40	1	Yes
21	542	2025-07-10	41	1	Yes
95	542	2025-07-27	66	1	Yes
96	542	2025-07-27	18	1	Yes
97	542	2025-07-27	67	1	Yes
98	542	2025-07-27	68	1	Yes
99	542	2025-07-27	69	1	Yes
100	542	2025-07-27	23	1	Yes
101	542	2025-07-27	70	1	Yes
102	542	2025-07-27	71	1	Yes
103	542	2025-07-27	72	1	Yes
104	542	2025-07-27	5	1	Yes
105	542	2025-07-27	73	1	Yes
106	542	2025-07-27	74	1	Yes
107	542	2025-07-27	32	1	Yes
108	542	2025-07-27	75	1	Yes
109	542	2025-07-27	76	1	Yes
110	542	2025-07-27	77	1	Yes
111	542	2025-07-27	37	1	Yes
112	542	2025-07-27	78	1	Yes
113	542	2025-07-27	79	1	Yes
114	542	2025-07-27	80	1	Yes
115	542	2025-07-27	81	1	Yes
116	542	2025-07-27	83	1	Yes
118	542	2025-07-27	84	1	Yes
119	542	2025-07-27	85	1	Yes
120	542	2025-07-27	50	1	Yes
121	542	2025-07-27	86	1	Yes
122	542	2025-07-27	36	1	Yes
123	542	2025-07-27	87	1	Yes
124	542	2025-07-27	88	1	Yes
47	546	2025-08-07	49	3	No
125	542	2025-07-27	89	1	Yes
126	542	2025-07-27	51	1	Yes
127	542	2025-07-27	90	1	Yes
128	542	2025-07-27	52	1	Yes
129	542	2025-07-27	91	1	Yes
130	542	2025-07-27	53	1	Yes
131	542	2025-07-27	92	1	Yes
132	542	2025-07-27	54	1	Yes
133	542	2025-07-27	93	1	Yes
134	542	2025-07-27	55	1	Yes
135	542	2025-07-27	94	1	Yes
136	542	2025-07-27	56	1	Yes
137	542	2025-07-27	95	1	Yes
138	542	2025-07-27	57	1	Yes
139	542	2025-07-27	96	1	Yes
140	542	2025-07-27	58	1	Yes
141	542	2025-07-27	97	1	Yes
142	542	2025-07-27	59	1	Yes
143	542	2025-07-27	98	1	Yes
144	542	2025-07-27	60	1	Yes
145	542	2025-07-27	99	1	Yes
146	542	2025-07-27	61	1	Yes
147	542	2025-07-27	100	1	Yes
148	542	2025-07-27	62	1	Yes
149	542	2025-07-27	101	1	Yes
150	542	2025-07-27	63	1	Yes
151	542	2025-07-27	82	1	Yes
152	542	2025-07-27	64	1	Yes
158	546	2025-08-07	3	1	No
22	542	2025-07-10	42	1	Yes
23	542	2025-07-10	43	1	Yes
24	542	2025-07-10	44	1	Yes
25	542	2025-07-10	45	1	Yes
26	542	2025-07-10	29	1	Yes
27	542	2025-07-10	46	1	Yes
28	542	2025-07-10	48	1	Yes
51	542	2025-07-10	1	1	Yes
53	542	2025-07-10	6	1	Yes
54	542	2025-07-10	7	1	Yes
55	542	2025-07-10	8	1	Yes
56	542	2025-07-10	9	1	Yes
57	542	2025-07-10	10	1	Yes
58	542	2025-07-10	11	1	Yes
59	542	2025-07-10	13	1	Yes
60	542	2025-07-10	14	1	Yes
61	542	2025-07-10	16	1	Yes
62	542	2025-07-10	17	1	Yes
63	542	2025-07-10	24	1	Yes
64	542	2025-07-10	25	1	Yes
65	542	2025-07-10	22	1	Yes
66	542	2025-07-10	21	1	Yes
67	542	2025-07-10	19	1	Yes
68	542	2025-07-27	4	1	Yes
69	542	2025-07-27	12	1	Yes
70	542	2025-07-27	18	1	Yes
71	542	2025-07-27	23	1	Yes
72	542	2025-07-27	5	1	Yes
73	542	2025-07-27	32	1	Yes
74	542	2025-07-27	37	1	Yes
75	542	2025-07-27	49	1	Yes
76	542	2025-07-27	50	1	Yes
77	542	2025-07-27	36	1	Yes
78	542	2025-07-27	51	1	Yes
79	542	2025-07-27	52	1	Yes
80	542	2025-07-27	53	1	Yes
81	542	2025-07-27	54	1	Yes
82	542	2025-07-27	55	1	Yes
83	542	2025-07-27	56	1	Yes
84	542	2025-07-27	57	1	Yes
85	542	2025-07-27	58	1	Yes
86	542	2025-07-27	59	1	Yes
87	542	2025-07-27	4	1	Yes
88	542	2025-07-27	60	1	Yes
89	542	2025-07-27	61	1	Yes
90	542	2025-07-27	62	1	Yes
91	542	2025-07-27	63	1	Yes
92	542	2025-07-27	12	1	Yes
93	542	2025-07-27	64	1	Yes
94	542	2025-07-27	65	1	Yes
\.


--
-- Data for Name: center; Type: TABLE DATA; Schema: public; Owner: backdoor_db_9tl9_user
--

COPY public.center (id, name) FROM stdin;
1	Main Campus
2	Nyabikoni
3	Little Ritz
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: backdoor_db_9tl9_user
--

COPY public.member (id, name, gender, contact, residence, home_district, marital_status, "course_Profession", year_of_study, first_time, center_id) FROM stdin;
2	Mutaasa Elijah	Male	0757001272	Rwamukundi	Buikwe	\N	EDUC	3.1	No	1
3	Kadduma Cosmas	Male	0701394382	Ministers village	Iganga	\N	BCS	2.1	No	1
4	MASIKA EVELYNE	Female	0705320168	Ministers village		None	Kiswahili	1.2	No	1
6	AHEREZA CHARLOTTE	Female	0752285923	Ministers village		\N	BTC	1.2	No	1
7	ALISEMERA CLAIRE	Female	0704827585	Rwamukundi		\N	BBA	1.2	No	1
8	ALISHABA PRISCILLA	Female	0768911693	Ministers village		\N	BSCED	2.1	No	1
9	AMPWERA DALTON	Male	0760657474	Mwanjari		\N	KIP		No	1
10	ARIKUSA EMMANUEL	Male	0777054331	TOWN VIEW		\N	MBCHB	2.2	No	1
11	ARINDA SHIVAN	Female	0756763458	Rwamukundi		\N	BTM	1.2	No	1
12	ATENG NANCY	Female	0788800323	Campus		\N	Security		No	1
13	AYEN GEOFFREY ALEXANDER	Male	0773826874	Ministers village		\N	BCS	1.2	No	1
14	BWAMBALE JOHN	Male	0742963221	Ministers village		\N	BNS		No	1
15	EKWANG NEKEMIAH	Male	0770712989	AUGUSTINE		\N	MBCHB		No	1
16	IVAN	Male	0768420769	JIM		\N	MBCHB		No	1
17	JOY ATWASI 	Female	0786445064	NDORWA		\N	Bio Tech	1.2	No	1
18	KABALISA MOUREEN 	Female	0770552324	CITY VIEW		\N	BPAM		No	1
19	KALIBBALA KENETH	Male	0761450542	Rwamukundi		\N	BTC		No	1
21	KIWEWA NAJIB M	Male	0764847126	Ministers village		\N	BCS	2.2	No	1
22	KUSINGURA SHIBAH	Female	0762150913	HILLSIDE		\N	DIT	1.2	No	1
23	KYASIMIRE PHIONAH	Female	0763331999	CITY VIEW		\N	BIC	1.2	No	1
24	KYOMUKAMA BRIAN	Male	0702257185	Rwamukundi		\N	BSCED		No	1
25	MANDE JEREMIAH	Male	0778281686	Rwamukundi		\N	BSCED		No	1
27	ATWIJUKIRE PROSSY	Female	0760524300	NYAKIHARO	null	\N	null	null	Yes	1
5	MUDIBA CHAMPLAIN	Male	0702089091	Nyakambu		None	Engineering		No	1
20	NAMUYIGA RACHEAL	Male	0760166423	KIGONGI		None	BNS		No	1
30	APOYA BRIDGET EVE	Female	0757820054	MINISTER'S VILLAGE		\N	KIB		No	1
31	ARIKUSA EMMANUEL	Male	0777054331	TOWN VIEW		\N	null		No	1
32	EKWANG NEKOMIAH	Male	0770712987	null		\N	null		No	1
33	REAGAN PAUL	Male	0700285811	NYAKIHARO		\N	null		No	1
34	ARINAWE BLESSING CLINTON	Male	0755850664	null		\N	null		No	1
35	TUSIIME OWEN GANA	Male	0753881114	null		\N	null	null	No	1
37	MUKISA ISMAIL	Male	0701957065	NYAKIHARO	null	\N	null	null	No	1
38	NAKINTU IMELDA CABRINE	Female	0706373758	TOWN VIEW	null	\N	null	null	No	1
39	MUHEREZA ALOUZIOUS	Male	0786846486	RWAMUKUNDI	null	\N	null	null	No	1
40	NKINZI DORCUS	Female	0755996079	RWAMUKUNDI	null	\N	null	null	No	1
41	MUGANDA JOHN ANDREW	Male	0772640183	HILLSIDE	null	\N	null	null	No	1
42	GALANDI IVAN	Male	0768420769	RWAMUKUNDI	null	\N	null	null	No	1
43	SSENYONJO REAGAN	Male	0741357229	NYAKIHARO	null	\N	null	null	No	1
44	BYAMUKAMA JOVAN	Male	0764812278	NYABIKONI	null	\N	null	null	No	1
45	ATENG NANCY	Female	0788800323	KAB UNIVERSITY	null	\N	null	null	No	1
46	TUMWEBAZE STEPHEN	Male	0772056389	RUTOOMA	null	\N	null	null	No	1
47	NAMUTEBI IMELDA MADRINE	Female	0758819601	TOWN VIEW	null	\N	null	null	No	1
49	UWERA FORTUNATE	Female	0758386083	Rwakaraba		None	null		No	1
48	BWAMBALE WILSON	Male	0703825557	MINISTER'S VILLAGE	null	\N	KAN	null	No	1
50	WAKHABEKO EMMA	Male	0778897517	Ministers village		None	BCS	1.2	No	1
36	OGWAL RONALD	Male	0776047898	null		None	null	null	No	1
26	BUKENYA DANIEL	Male	0759548083	MACRO	null	None	HEC	null	No	1
29	AYEBALE WINFRED SHAKIRAH	Female	0791363695	MLEX	null	None	null		Yes	1
28	NAMULEMA BRENDA	Female	0756277186	RWAMUKUNDI	null	\N	null	null	No	1
1	Nathan Kerera	Male	0758765875	Ministers Village 	Kampala 	None	Bio Tech	2.1	Yes	1
51	AGABA EMMANUEL	Male	0788508944	Rwamukundi		\N	nu		No	1
52	AGABA EMMANUEL	Male	0788508944	Rwamukundi		\N	nu		No	1
53	AHUMUZA LORINE	Female	0769751869	Ministers village		\N	null		No	1
54	AMONG IRENE	Female	0705306112	Kikungiri		\N	null		No	1
55	AMONGIN CHRISTINE	Female	0778773060	NDORWA		\N	Officer		No	1
56	ANAH NAMARA	Female	0778861566	Kigongi		\N	null		No	1
57	ASSIMWE EDGAR	Male	0707022705	Ministers village		\N	null		No	1
58	ASURU BEATRICE	Female	0778996421	Ministers village		\N	null		No	1
59	ATIM BETTY	Female	0783737595	Ministers village		\N	null		No	1
60	ATUHEIRE MIRACLE	Female	0787982892	Ministers village		\N	null		No	1
61	ISINGOMA HASSAN	Male	0786703729	Nyakiharo		\N	Bio Tech	1.2	No	1
62	KEMIGISA HILDA	Female	0750091874	TOWN VIEW		\N	null		No	1
63	KIPLIMO ROBIN	Male	0776392245	Rwamukundi		\N	null		No	1
64	KIRABO TRACY	Female	0707454224	TOWN VIEW		\N	BIC	1.2	No	1
65	KYAMPEIRE SYLIVIA	Female	0762273912	Rwamukundi		\N	null		No	1
66	MASABA MARK	Male	0701260571	Ministers village		None	Data science	1.2	No	1
67	MUGAWA JOHN ANDRE	Male	0772640183	Rwamukundi		\N	MBCHB		No	1
68	MUHEREZA ALOUZIOUS	Male	0786846486	Rwamukundi		\N	BCS	1.2	No	1
69	MUHWEZI EDSON	Male	0783663482	Mwanjari		\N	null		No	1
70	MUHWEZI JULIUS	Male	0764497361	Ministers village		\N	KSA		No	1
71	MUKISA CALEB	Male	0708446242	HILLSIDE		\N	BIC	2.2	No	1
72	MUKISA DERRICK	Male	0744988098	Ministers village		\N	MBCHB	1.1	No	1
73	MUKISA DERRICK	Male	0744988098	Ministers village		\N	MBCHB		No	1
74	MUSIIME ALVIN	Male	0706983965	Ministers village		\N	null		No	1
75	MWEBEMBEZI SAMUEL	Male	0784398776	Ministers village		\N	null		No	1
76	MWESIGWA ISAAC	Male	0780439291	AFRICAN HOSTELS		\N	KSA		No	1
77	MWESIGWA JOEL 	Male	0709512492	Rwamukundi		\N	Bio Tech	1.2	No	1
78	MWOGEZA PHASEY	Female	0747783802	Kikungiri		\N	BAL		No	1
79	NABUSHAWO SHARON	Female	0776279928	Rwamukundi		\N	BSCED		No	1
80	NAKANWAGI REBECCA	Female	0780543078	Rwamukundi		\N	BSCED		No	1
81	NAKAWEESI CATHERINE	Female	0743401983	TOWN VIEW		\N	BNS		No	1
83	NAYEBARE ANNEST	Female	0771039705	Ministers village		\N	null		No	1
84	NIWEBYOONA DORIS	Female	0765074776	Mwanjari		\N	null		No	1
85	NKAMUSHABA RUHANGA EMMY	Female	0781789931	Rwamukundi		\N	BSCED		No	1
86	NUWAGABA VIOLA	Male	0786825175	Ministers village		\N	null		No	1
87	ODYEK BRIAN	Male	0781550563	NDORWA		\N	null		No	1
88	OGWAL RONALD	Male	0776047898	Green Hostel		\N	null		No	1
89	ORISHABA DAPHINE	Female	0766057112	Ministers village		\N	BSCED		No	1
90	RUZAYO DAN	Male	0774934048	Rwamukundi		\N	AGM		No	1
91	SEGUJJA NICHOLAS	Male	0764411598	Rwamukundi		\N	BSCED		No	1
92	SSENKIMA GERALD	Male	0740642325	Rwamukundi		\N	BSCED		No	1
93	SSENTALA GUSTAR BAISE	Male	0772263833	Ministers village		\N	null		No	1
94	TAYEBWA JIM	Male	0772241350	Rwamukundi		\N	MBCHB		No	1
95	TUGABIRWE IMMACULATE	Male	0789811353	Rwamukundi		\N	null		No	1
96	TUMURANZYE JUNIOR	Male	0770828340	Rwamukundi		\N	BTM		No	1
97	TURICHE AFRICANO	Male	0704167682	Kirigime		\N	null		No	1
98	TUSIIME FOSSY	Male	0763791673	Ministers village		\N	BSW		No	1
99	TUSIIME GIVEN GANA	Male	0760530020	null		\N	KSA		No	1
100	TUSIIME HOPE KEZIA	Female	0772160264	Rwamukundi		\N	null		No	1
101	TWEBAZE JAMES	Male	0756341164	Rwamukundi		\N	BIT		No	1
102	WAMBEWO SAMUEL	Male	0779962554	Kirigime		\N	BNS		No	3
103	WANSOLO ROGERS	Male	0784412158	KAB UNIV		\N	null		No	3
104	WILSON KINYA	Male	0700424249	Ministers village		\N	BSCED		No	3
82	NAMIIRO ZAM	Female	0701192196	Rwamukundi		None	AGM		No	1
\.


--
-- Data for Name: soul; Type: TABLE DATA; Schema: public; Owner: backdoor_db_9tl9_user
--

COPY public.soul (id, name, contact, residence, first_time, service_number, service_date, outreach_date, source, center_id) FROM stdin;
1	Kedress	0758765875	Kekubo	Yes	541	2025-07-03	\N	Service	2
\.


--
-- Name: attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: backdoor_db_9tl9_user
--

SELECT pg_catalog.setval('public.attendance_id_seq', 158, true);


--
-- Name: center_id_seq; Type: SEQUENCE SET; Schema: public; Owner: backdoor_db_9tl9_user
--

SELECT pg_catalog.setval('public.center_id_seq', 3, true);


--
-- Name: member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: backdoor_db_9tl9_user
--

SELECT pg_catalog.setval('public.member_id_seq', 104, true);


--
-- Name: soul_id_seq; Type: SEQUENCE SET; Schema: public; Owner: backdoor_db_9tl9_user
--

SELECT pg_catalog.setval('public.soul_id_seq', 1, true);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (id);


--
-- Name: center center_name_key; Type: CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.center
    ADD CONSTRAINT center_name_key UNIQUE (name);


--
-- Name: center center_pkey; Type: CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.center
    ADD CONSTRAINT center_pkey PRIMARY KEY (id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: soul soul_pkey; Type: CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.soul
    ADD CONSTRAINT soul_pkey PRIMARY KEY (id);


--
-- Name: attendance attendance_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_center_id_fkey FOREIGN KEY (center_id) REFERENCES public.center(id);


--
-- Name: attendance attendance_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.member(id);


--
-- Name: member member_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_center_id_fkey FOREIGN KEY (center_id) REFERENCES public.center(id);


--
-- Name: soul soul_center_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: backdoor_db_9tl9_user
--

ALTER TABLE ONLY public.soul
    ADD CONSTRAINT soul_center_id_fkey FOREIGN KEY (center_id) REFERENCES public.center(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO backdoor_db_9tl9_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO backdoor_db_9tl9_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO backdoor_db_9tl9_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO backdoor_db_9tl9_user;


--
-- PostgreSQL database dump complete
--

