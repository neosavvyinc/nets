--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: commonsuser; Type: SCHEMA; Schema: -; Owner: commonsuser
--

CREATE SCHEMA commonsuser;


ALTER SCHEMA commonsuser OWNER TO commonsuser;

SET search_path = commonsuser, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acl_class; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_class (
    id bigint NOT NULL,
    class character varying(255) NOT NULL
);


ALTER TABLE commonsuser.acl_class OWNER TO commonsuser;

--
-- Name: acl_class_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_class_id_seq OWNER TO commonsuser;

--
-- Name: acl_class_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_class_id_seq OWNED BY acl_class.id;


--
-- Name: acl_class_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_class_id_seq', 9, true);


--
-- Name: acl_entry; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_entry (
    id bigint NOT NULL,
    granting boolean NOT NULL,
    ace_order integer,
    audit_success boolean NOT NULL,
    mask integer NOT NULL,
    audit_failure boolean NOT NULL,
    acl_object_identity bigint NOT NULL,
    sid bigint NOT NULL
);


ALTER TABLE commonsuser.acl_entry OWNER TO commonsuser;

--
-- Name: acl_entry_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_entry_id_seq OWNER TO commonsuser;

--
-- Name: acl_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_entry_id_seq OWNED BY acl_entry.id;


--
-- Name: acl_entry_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_entry_id_seq', 2223, true);


--
-- Name: acl_object_identity; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_object_identity (
    id bigint NOT NULL,
    object_id_identity bigint NOT NULL,
    entries_inheriting boolean NOT NULL,
    parent_object bigint,
    object_id_class bigint NOT NULL,
    owner_sid bigint NOT NULL
);


ALTER TABLE commonsuser.acl_object_identity OWNER TO commonsuser;

--
-- Name: acl_object_identity_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_object_identity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_object_identity_id_seq OWNER TO commonsuser;

--
-- Name: acl_object_identity_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_object_identity_id_seq OWNED BY acl_object_identity.id;


--
-- Name: acl_object_identity_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_object_identity_id_seq', 751, true);


--
-- Name: acl_sid; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE acl_sid (
    id bigint NOT NULL,
    sid character varying(100) NOT NULL,
    principal boolean NOT NULL
);


ALTER TABLE commonsuser.acl_sid OWNER TO commonsuser;

--
-- Name: acl_sid_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE acl_sid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.acl_sid_id_seq OWNER TO commonsuser;

--
-- Name: acl_sid_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE acl_sid_id_seq OWNED BY acl_sid.id;


--
-- Name: acl_sid_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('acl_sid_id_seq', 13, true);


--
-- Name: attribute_descriptor; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE attribute_descriptor (
    id bigint NOT NULL,
    type character varying(50),
    "precision" integer DEFAULT 2,
    description character varying(255),
    sort_order integer,
    name character varying(255),
    valuetype character varying(255)
);


ALTER TABLE commonsuser.attribute_descriptor OWNER TO commonsuser;

--
-- Name: attribute_descriptor_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE attribute_descriptor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.attribute_descriptor_id_seq OWNER TO commonsuser;

--
-- Name: attribute_descriptor_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE attribute_descriptor_id_seq OWNED BY attribute_descriptor.id;


--
-- Name: attribute_descriptor_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('attribute_descriptor_id_seq', 1, false);


--
-- Name: attribute_enum_value; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE attribute_enum_value (
    id bigint NOT NULL,
    sort_order integer,
    value character varying(255),
    descriptor_id bigint
);


ALTER TABLE commonsuser.attribute_enum_value OWNER TO commonsuser;

--
-- Name: attribute_enum_value_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE attribute_enum_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.attribute_enum_value_id_seq OWNER TO commonsuser;

--
-- Name: attribute_enum_value_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE attribute_enum_value_id_seq OWNED BY attribute_enum_value.id;


--
-- Name: attribute_enum_value_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('attribute_enum_value_id_seq', 1, false);


--
-- Name: client_company; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE client_company (
    id bigint NOT NULL,
    address_two character varying(255),
    postal_code character varying(255),
    address_one character varying(255),
    state character varying(255),
    company_name character varying(255),
    city character varying(255),
    country character varying(255),
    client_user_contact_fk bigint NOT NULL,
    parent_company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.client_company OWNER TO commonsuser;

--
-- Name: client_company_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE client_company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.client_company_id_seq OWNER TO commonsuser;

--
-- Name: client_company_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE client_company_id_seq OWNED BY client_company.id;


--
-- Name: client_company_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('client_company_id_seq', 7, true);


--
-- Name: client_user_contact; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE client_user_contact (
    id bigint NOT NULL,
    middle_name character varying(255),
    last_name character varying(255),
    email_address character varying(255),
    contact_phone_number character varying(255),
    first_name character varying(255)
);


ALTER TABLE commonsuser.client_user_contact OWNER TO commonsuser;

--
-- Name: client_user_contact_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE client_user_contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.client_user_contact_id_seq OWNER TO commonsuser;

--
-- Name: client_user_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE client_user_contact_id_seq OWNED BY client_user_contact.id;


--
-- Name: client_user_contact_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('client_user_contact_id_seq', 7, true);


--
-- Name: company; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE company (
    id bigint NOT NULL,
    address_one character varying(255),
    address_two character varying(255),
    postal_code character varying(255),
    state character varying(255),
    company_name character varying(255),
    city character varying(255),
    country character varying(255)
);


ALTER TABLE commonsuser.company OWNER TO commonsuser;

--
-- Name: company_expense_item_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE company_expense_item_type (
    id bigint NOT NULL,
    company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.company_expense_item_type OWNER TO commonsuser;

--
-- Name: company_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.company_id_seq OWNER TO commonsuser;

--
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE company_id_seq OWNED BY company.id;


--
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('company_id_seq', 8, true);


--
-- Name: company_payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE company_payment_method (
    id bigint NOT NULL,
    company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.company_payment_method OWNER TO commonsuser;

--
-- Name: databasechangelog; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE databasechangelog (
    id character varying(63) NOT NULL,
    author character varying(63) NOT NULL,
    filename character varying(200) NOT NULL,
    dateexecuted timestamp with time zone NOT NULL,
    md5sum character varying(32),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(10)
);


ALTER TABLE commonsuser.databasechangelog OWNER TO commonsuser;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp with time zone,
    lockedby character varying(255)
);


ALTER TABLE commonsuser.databasechangeloglock OWNER TO commonsuser;

--
-- Name: expense_item_descriptor; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_descriptor (
    id bigint NOT NULL,
    expense_item_type_fk bigint NOT NULL
);


ALTER TABLE commonsuser.expense_item_descriptor OWNER TO commonsuser;

--
-- Name: expense_item_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_type (
    id bigint NOT NULL,
    type character varying(50),
    name character varying(255),
    description character varying(255),
    sort_order integer
);


ALTER TABLE commonsuser.expense_item_type OWNER TO commonsuser;

--
-- Name: expense_item_type_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_item_type_id_seq
    START WITH 1
    INCREMENT BY 50
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_item_type_id_seq OWNER TO commonsuser;

--
-- Name: expense_item_type_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_item_type_id_seq OWNED BY expense_item_type.id;


--
-- Name: expense_item_type_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_item_type_id_seq', 1, false);


--
-- Name: expense_item_value; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value (
    id bigint NOT NULL,
    string_value character varying(255),
    partition_date date NOT NULL,
    enumerated_value_id bigint,
    expense_item_fk bigint NOT NULL,
    descriptor_id bigint NOT NULL
);


ALTER TABLE commonsuser.expense_item_value OWNER TO commonsuser;

--
-- Name: expense_item_value_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_item_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_item_value_id_seq OWNER TO commonsuser;

--
-- Name: expense_item_value_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_item_value_id_seq OWNED BY expense_item_value.id;


--
-- Name: expense_item_value_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_item_value_id_seq', 1, false);


--
-- Name: expense_item_value_yy10mm01; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy10mm01 (CONSTRAINT expense_item_value_yy10mm01_partition_date_check CHECK (((partition_date >= '2010-01-01'::date) AND (partition_date < '2010-06-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy10mm01 OWNER TO commonsuser;

--
-- Name: expense_item_value_yy10mm06; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy10mm06 (CONSTRAINT expense_item_value_yy10mm06_partition_date_check CHECK (((partition_date >= '2010-06-01'::date) AND (partition_date < '2011-01-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy10mm06 OWNER TO commonsuser;

--
-- Name: expense_item_value_yy11mm01; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy11mm01 (CONSTRAINT expense_item_value_yy11mm01_partition_date_check CHECK (((partition_date >= '2011-01-01'::date) AND (partition_date < '2011-06-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy11mm01 OWNER TO commonsuser;

--
-- Name: expense_item_value_yy11mm06; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_item_value_yy11mm06 (CONSTRAINT expense_item_value_yy11mm06_partition_date_check CHECK (((partition_date >= '2011-06-01'::date) AND (partition_date < '2012-01-01'::date)))
)
INHERITS (expense_item_value);


ALTER TABLE commonsuser.expense_item_value_yy11mm06 OWNER TO commonsuser;

--
-- Name: expense_report; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_report (
    id bigint NOT NULL,
    state_date date,
    location character varying(255),
    end_date date,
    purpose character varying(255),
    owner_fk bigint NOT NULL,
    project_fk bigint,
    status character varying(20) DEFAULT 'OPEN'::character varying NOT NULL
);


ALTER TABLE commonsuser.expense_report OWNER TO commonsuser;

--
-- Name: expense_report_audit_history; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_report_audit_history (
    id bigint NOT NULL,
    comment character varying(4098) NOT NULL,
    activity_date date NOT NULL,
    user_fk bigint NOT NULL,
    owner_fk bigint NOT NULL,
    expense_report_fk bigint NOT NULL
);


ALTER TABLE commonsuser.expense_report_audit_history OWNER TO commonsuser;

--
-- Name: expense_report_audit_history_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_report_audit_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_report_audit_history_id_seq OWNER TO commonsuser;

--
-- Name: expense_report_audit_history_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_report_audit_history_id_seq OWNED BY expense_report_audit_history.id;


--
-- Name: expense_report_audit_history_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_report_audit_history_id_seq', 1, false);


--
-- Name: expense_report_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_report_id_seq OWNER TO commonsuser;

--
-- Name: expense_report_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_report_id_seq OWNED BY expense_report.id;


--
-- Name: expense_report_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_report_id_seq', 24, true);


--
-- Name: expense_report_item; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE expense_report_item (
    id bigint NOT NULL,
    amount numeric(38,2),
    expense_date date,
    comment character varying(255),
    expense_report_fk bigint NOT NULL,
    expense_item_type_fk bigint,
    payment_method_fk bigint,
    project_type_fk bigint,
    receipt_file_ref_fk bigint
);


ALTER TABLE commonsuser.expense_report_item OWNER TO commonsuser;

--
-- Name: expense_report_item_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE expense_report_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.expense_report_item_id_seq OWNER TO commonsuser;

--
-- Name: expense_report_item_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE expense_report_item_id_seq OWNED BY expense_report_item.id;


--
-- Name: expense_report_item_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('expense_report_item_id_seq', 346, true);


--
-- Name: file_refs; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE file_refs (
    id bigint NOT NULL,
    type character varying(50) NOT NULL,
    file_size character varying(4098) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_modified_at timestamp with time zone NOT NULL,
    record_status character varying(1) NOT NULL
);


ALTER TABLE commonsuser.file_refs OWNER TO commonsuser;

--
-- Name: file_refs_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE file_refs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.file_refs_id_seq OWNER TO commonsuser;

--
-- Name: file_refs_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE file_refs_id_seq OWNED BY file_refs.id;


--
-- Name: file_refs_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('file_refs_id_seq', 327, true);


--
-- Name: payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE payment_method (
    id bigint NOT NULL,
    type character varying(31),
    description character varying(255),
    name character varying(255)
);


ALTER TABLE commonsuser.payment_method OWNER TO commonsuser;

--
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE payment_method_id_seq
    START WITH 1
    INCREMENT BY 3
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.payment_method_id_seq OWNER TO commonsuser;

--
-- Name: payment_method_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE payment_method_id_seq OWNED BY payment_method.id;


--
-- Name: payment_method_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('payment_method_id_seq', 1, false);


--
-- Name: project; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project (
    id bigint NOT NULL,
    start_date date,
    project_name character varying(255),
    end_date date,
    code character varying(255),
    parent_company_fk bigint NOT NULL,
    client_company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.project OWNER TO commonsuser;

--
-- Name: project_approvers; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_approvers (
    user_id bigint NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE commonsuser.project_approvers OWNER TO commonsuser;

--
-- Name: project_approvers_user_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_approvers_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_approvers_user_id_seq OWNER TO commonsuser;

--
-- Name: project_approvers_user_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_approvers_user_id_seq OWNED BY project_approvers.user_id;


--
-- Name: project_approvers_user_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_approvers_user_id_seq', 1, false);


--
-- Name: project_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_id_seq OWNER TO commonsuser;

--
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_id_seq OWNED BY project.id;


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_id_seq', 12, true);


--
-- Name: project_participants; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_participants (
    user_id bigint NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE commonsuser.project_participants OWNER TO commonsuser;

--
-- Name: project_participants_user_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_participants_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_participants_user_id_seq OWNER TO commonsuser;

--
-- Name: project_participants_user_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_participants_user_id_seq OWNED BY project_participants.user_id;


--
-- Name: project_participants_user_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_participants_user_id_seq', 1, false);


--
-- Name: project_payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_payment_method (
    id bigint NOT NULL,
    project_fk bigint NOT NULL
);


ALTER TABLE commonsuser.project_payment_method OWNER TO commonsuser;

--
-- Name: project_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE project_type (
    id bigint NOT NULL,
    type character varying(255)
);


ALTER TABLE commonsuser.project_type OWNER TO commonsuser;

--
-- Name: project_type_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE project_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.project_type_id_seq OWNER TO commonsuser;

--
-- Name: project_type_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE project_type_id_seq OWNED BY project_type.id;


--
-- Name: project_type_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('project_type_id_seq', 3, true);


--
-- Name: role; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE role (
    id bigint NOT NULL,
    long_name character varying(255),
    short_name character varying(255)
);


ALTER TABLE commonsuser.role OWNER TO commonsuser;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.role_id_seq OWNER TO commonsuser;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('role_id_seq', 2, true);


--
-- Name: standard_expense_item_type; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE standard_expense_item_type (
    id bigint NOT NULL
);


ALTER TABLE commonsuser.standard_expense_item_type OWNER TO commonsuser;

--
-- Name: standard_payment_method; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE standard_payment_method (
    id bigint NOT NULL
);


ALTER TABLE commonsuser.standard_payment_method OWNER TO commonsuser;

--
-- Name: storage_service_file_refs; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE storage_service_file_refs (
    id bigint NOT NULL,
    bucket character varying(50) NOT NULL,
    file_key character varying(100) NOT NULL,
    file_name character varying(256),
    location character varying(20),
    content_type character varying(50),
    owner character varying(256)
);


ALTER TABLE commonsuser.storage_service_file_refs OWNER TO commonsuser;

--
-- Name: user_company_role; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_company_role (
    id bigint NOT NULL,
    role_fk bigint NOT NULL,
    company_fk bigint NOT NULL,
    user_fk bigint NOT NULL
);


ALTER TABLE commonsuser.user_company_role OWNER TO commonsuser;

--
-- Name: user_company_role_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE user_company_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.user_company_role_id_seq OWNER TO commonsuser;

--
-- Name: user_company_role_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE user_company_role_id_seq OWNED BY user_company_role.id;


--
-- Name: user_company_role_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('user_company_role_id_seq', 12, true);


--
-- Name: user_invite; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_invite (
    id bigint NOT NULL,
    middle_name character varying(255),
    last_name character varying(255),
    email_address character varying(255),
    contact_phone_number character varying(255),
    first_name character varying(255),
    registration_token character varying(255),
    company_fk bigint NOT NULL
);


ALTER TABLE commonsuser.user_invite OWNER TO commonsuser;

--
-- Name: user_invite_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE user_invite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.user_invite_id_seq OWNER TO commonsuser;

--
-- Name: user_invite_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE user_invite_id_seq OWNED BY user_invite.id;


--
-- Name: user_invite_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('user_invite_id_seq', 9, true);


--
-- Name: user_receipts; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_receipts (
    user_fk bigint NOT NULL,
    receipt_fk bigint NOT NULL
);


ALTER TABLE commonsuser.user_receipts OWNER TO commonsuser;

--
-- Name: user_sessions; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE user_sessions (
    id character varying(100) NOT NULL,
    username character varying(256) NOT NULL,
    creation_date timestamp with time zone NOT NULL
);


ALTER TABLE commonsuser.user_sessions OWNER TO commonsuser;

--
-- Name: users; Type: TABLE; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE TABLE users (
    id bigint NOT NULL,
    middle_name character varying(255),
    last_name character varying(255),
    email_address character varying(255),
    contact_phone_number character varying(255),
    password character varying(255),
    username character varying(255),
    active boolean,
    first_name character varying(255),
    confirmed_registration boolean,
    reg_token character varying(255),
    password_reset boolean DEFAULT false NOT NULL
);


ALTER TABLE commonsuser.users OWNER TO commonsuser;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: commonsuser; Owner: commonsuser
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE commonsuser.users_id_seq OWNER TO commonsuser;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: commonsuser; Owner: commonsuser
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: commonsuser; Owner: commonsuser
--

SELECT pg_catalog.setval('users_id_seq', 12, true);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_class ALTER COLUMN id SET DEFAULT nextval('acl_class_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_entry ALTER COLUMN id SET DEFAULT nextval('acl_entry_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_object_identity ALTER COLUMN id SET DEFAULT nextval('acl_object_identity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE acl_sid ALTER COLUMN id SET DEFAULT nextval('acl_sid_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE attribute_descriptor ALTER COLUMN id SET DEFAULT nextval('attribute_descriptor_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE attribute_enum_value ALTER COLUMN id SET DEFAULT nextval('attribute_enum_value_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE client_company ALTER COLUMN id SET DEFAULT nextval('client_company_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE client_user_contact ALTER COLUMN id SET DEFAULT nextval('client_user_contact_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE company ALTER COLUMN id SET DEFAULT nextval('company_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_item_type ALTER COLUMN id SET DEFAULT nextval('expense_item_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_item_value ALTER COLUMN id SET DEFAULT nextval('expense_item_value_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_report ALTER COLUMN id SET DEFAULT nextval('expense_report_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_report_audit_history ALTER COLUMN id SET DEFAULT nextval('expense_report_audit_history_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE expense_report_item ALTER COLUMN id SET DEFAULT nextval('expense_report_item_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE file_refs ALTER COLUMN id SET DEFAULT nextval('file_refs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE payment_method ALTER COLUMN id SET DEFAULT nextval('payment_method_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project_approvers ALTER COLUMN user_id SET DEFAULT nextval('project_approvers_user_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project_participants ALTER COLUMN user_id SET DEFAULT nextval('project_participants_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE project_type ALTER COLUMN id SET DEFAULT nextval('project_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE user_company_role ALTER COLUMN id SET DEFAULT nextval('user_company_role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE user_invite ALTER COLUMN id SET DEFAULT nextval('user_invite_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: acl_class; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_class (id, class) FROM stdin;
1	com.neosavvy.user.dto.companyManagement.UserDTO
2	com.neosavvy.user.dto.companyManagement.CompanyDTO
3	com.neosavvy.user.dto.companyManagement.UserInviteDTO
4	com.neosavvy.user.dto.project.ClientUserContact
5	com.neosavvy.user.dto.project.ClientCompany
6	com.neosavvy.user.dto.project.Project
7	com.neosavvy.user.dto.project.ExpenseReport
8	com.neosavvy.user.dto.project.ExpenseItem
9	fineline.focal.common.types.v1.StorageServiceFileRef
\.


--
-- Data for Name: acl_entry; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_entry (id, granting, ace_order, audit_success, mask, audit_failure, acl_object_identity, sid) FROM stdin;
4	t	0	f	1	f	1	2
5	t	1	f	2	f	1	2
6	t	2	f	8	f	1	2
10	t	0	f	1	f	2	2
11	t	1	f	2	f	2	2
12	t	2	f	8	f	2	2
118	t	0	f	1	f	167	6
119	t	1	f	2	f	167	6
120	t	2	f	8	f	167	6
19	t	0	f	1	f	4	3
20	t	1	f	2	f	4	3
21	t	2	f	8	f	4	3
124	t	0	f	1	f	168	2
23	t	0	f	1	f	9	3
24	t	1	f	1	f	9	2
125	t	1	f	2	f	168	2
26	t	0	f	1	f	10	3
27	t	1	f	1	f	10	2
126	t	2	f	8	f	168	2
31	t	0	f	1	f	11	2
32	t	1	f	2	f	11	2
33	t	2	f	8	f	11	2
130	t	0	f	1	f	169	2
131	t	1	f	2	f	169	2
37	t	0	f	1	f	52	4
38	t	1	f	2	f	52	4
39	t	2	f	8	f	52	4
132	t	2	f	8	f	169	2
43	t	0	f	1	f	53	4
44	t	1	f	2	f	53	4
45	t	2	f	8	f	53	4
136	t	0	f	1	f	170	2
137	t	1	f	2	f	170	2
49	t	0	f	1	f	55	4
50	t	1	f	2	f	55	4
51	t	2	f	8	f	55	4
138	t	2	f	8	f	170	2
55	t	0	f	1	f	56	4
56	t	1	f	2	f	56	4
57	t	2	f	8	f	56	4
142	t	0	f	1	f	171	2
143	t	1	f	2	f	171	2
61	t	0	f	1	f	57	4
62	t	1	f	2	f	57	4
63	t	2	f	8	f	57	4
144	t	2	f	8	f	171	2
67	t	0	f	1	f	58	4
68	t	1	f	2	f	58	4
69	t	2	f	8	f	58	4
148	t	0	f	1	f	172	2
149	t	1	f	2	f	172	2
73	t	0	f	1	f	59	2
74	t	1	f	2	f	59	2
75	t	2	f	8	f	59	2
150	t	2	f	8	f	172	2
79	t	0	f	1	f	129	2
80	t	1	f	2	f	129	2
81	t	2	f	8	f	129	2
154	t	0	f	1	f	195	7
155	t	1	f	2	f	195	7
85	t	0	f	1	f	130	2
86	t	1	f	2	f	130	2
87	t	2	f	8	f	130	2
156	t	2	f	8	f	195	7
91	t	0	f	1	f	131	2
92	t	1	f	2	f	131	2
93	t	2	f	8	f	131	2
160	t	0	f	1	f	196	7
161	t	1	f	2	f	196	7
97	t	0	f	1	f	132	2
98	t	1	f	2	f	132	2
99	t	2	f	8	f	132	2
162	t	2	f	8	f	196	7
103	t	0	f	1	f	158	5
104	t	1	f	2	f	158	5
105	t	2	f	8	f	158	5
166	t	0	f	1	f	197	2
167	t	1	f	2	f	197	2
109	t	0	f	1	f	159	5
110	t	1	f	2	f	159	5
111	t	2	f	8	f	159	5
168	t	2	f	8	f	197	2
172	t	0	f	1	f	228	2
173	t	1	f	2	f	228	2
174	t	2	f	8	f	228	2
178	t	0	f	1	f	252	2
179	t	1	f	2	f	252	2
180	t	2	f	8	f	252	2
184	t	0	f	1	f	253	2
185	t	1	f	2	f	253	2
186	t	2	f	8	f	253	2
190	t	0	f	1	f	254	2
191	t	1	f	2	f	254	2
192	t	2	f	8	f	254	2
196	t	0	f	1	f	255	2
197	t	1	f	2	f	255	2
198	t	2	f	8	f	255	2
202	t	0	f	1	f	256	2
203	t	1	f	2	f	256	2
204	t	2	f	8	f	256	2
208	t	0	f	1	f	257	2
209	t	1	f	2	f	257	2
210	t	2	f	8	f	257	2
268	t	0	f	1	f	268	2
269	t	1	f	2	f	268	2
270	t	2	f	8	f	268	2
214	t	0	f	1	f	258	2
215	t	1	f	2	f	258	2
216	t	2	f	8	f	258	2
436	t	0	f	1	f	303	10
437	t	1	f	2	f	303	10
438	t	2	f	8	f	303	10
220	t	0	f	1	f	259	2
221	t	1	f	2	f	259	2
222	t	2	f	8	f	259	2
274	t	0	f	1	f	270	2
275	t	1	f	2	f	270	2
276	t	2	f	8	f	270	2
226	t	0	f	1	f	260	2
227	t	1	f	2	f	260	2
228	t	2	f	8	f	260	2
232	t	0	f	1	f	262	2
233	t	1	f	2	f	262	2
234	t	2	f	8	f	262	2
280	t	0	f	1	f	272	2
281	t	1	f	2	f	272	2
282	t	2	f	8	f	272	2
238	t	0	f	1	f	263	2
239	t	1	f	2	f	263	2
240	t	2	f	8	f	263	2
244	t	0	f	1	f	264	2
245	t	1	f	2	f	264	2
246	t	2	f	8	f	264	2
286	t	0	f	1	f	274	2
287	t	1	f	2	f	274	2
288	t	2	f	8	f	274	2
250	t	0	f	1	f	265	2
251	t	1	f	2	f	265	2
252	t	2	f	8	f	265	2
256	t	0	f	1	f	266	2
257	t	1	f	2	f	266	2
258	t	2	f	8	f	266	2
292	t	0	f	1	f	276	2
293	t	1	f	2	f	276	2
294	t	2	f	8	f	276	2
262	t	0	f	1	f	267	2
263	t	1	f	2	f	267	2
264	t	2	f	8	f	267	2
298	t	0	f	1	f	277	2
299	t	1	f	2	f	277	2
300	t	2	f	8	f	277	2
304	t	0	f	1	f	278	8
305	t	1	f	2	f	278	8
306	t	2	f	8	f	278	8
310	t	0	f	1	f	279	8
311	t	1	f	2	f	279	8
312	t	2	f	8	f	279	8
316	t	0	f	1	f	280	8
317	t	1	f	2	f	280	8
318	t	2	f	8	f	280	8
322	t	0	f	1	f	281	2
323	t	1	f	2	f	281	2
324	t	2	f	8	f	281	2
328	t	0	f	1	f	283	2
329	t	1	f	2	f	283	2
330	t	2	f	8	f	283	2
334	t	0	f	1	f	285	9
335	t	1	f	2	f	285	9
336	t	2	f	8	f	285	9
340	t	0	f	1	f	286	9
341	t	1	f	2	f	286	9
342	t	2	f	8	f	286	9
349	t	0	f	1	f	289	10
350	t	1	f	2	f	289	10
351	t	2	f	8	f	289	10
355	t	0	f	1	f	290	2
356	t	1	f	2	f	290	2
357	t	2	f	8	f	290	2
361	t	0	f	1	f	291	2
362	t	1	f	2	f	291	2
363	t	2	f	8	f	291	2
367	t	0	f	1	f	292	10
368	t	1	f	2	f	292	10
369	t	2	f	8	f	292	10
373	t	0	f	1	f	293	10
374	t	1	f	2	f	293	10
375	t	2	f	8	f	293	10
382	t	0	f	1	f	294	11
383	t	1	f	2	f	294	11
384	t	2	f	8	f	294	11
388	t	0	f	1	f	295	11
389	t	1	f	2	f	295	11
390	t	2	f	8	f	295	11
394	t	0	f	1	f	296	11
395	t	1	f	2	f	296	11
396	t	2	f	8	f	296	11
400	t	0	f	1	f	297	10
401	t	1	f	2	f	297	10
402	t	2	f	8	f	297	10
406	t	0	f	1	f	298	10
407	t	1	f	2	f	298	10
408	t	2	f	8	f	298	10
412	t	0	f	1	f	299	11
413	t	1	f	2	f	299	11
414	t	2	f	8	f	299	11
673	t	0	f	1	f	365	10
674	t	1	f	2	f	365	10
675	t	2	f	8	f	365	10
442	t	0	f	1	f	304	10
443	t	1	f	2	f	304	10
444	t	2	f	8	f	304	10
955	t	0	f	1	f	430	11
956	t	1	f	2	f	430	11
957	t	2	f	8	f	430	11
460	t	0	f	1	f	307	10
461	t	1	f	2	f	307	10
462	t	2	f	8	f	307	10
691	t	0	f	1	f	368	10
692	t	1	f	2	f	368	10
693	t	2	f	8	f	368	10
478	t	0	f	1	f	310	10
479	t	1	f	2	f	310	10
480	t	2	f	8	f	310	10
1294	t	0	f	1	f	514	2
1295	t	1	f	2	f	514	2
1296	t	2	f	8	f	514	2
490	t	0	f	1	f	312	10
491	t	1	f	2	f	312	10
492	t	2	f	8	f	312	10
709	t	0	f	1	f	371	10
710	t	1	f	2	f	371	10
711	t	2	f	8	f	371	10
514	t	0	f	1	f	316	10
515	t	1	f	2	f	316	10
516	t	2	f	8	f	316	10
973	t	0	f	1	f	433	11
974	t	1	f	2	f	433	11
975	t	2	f	8	f	433	11
532	t	0	f	1	f	319	11
533	t	1	f	2	f	319	11
534	t	2	f	8	f	319	11
721	t	0	f	1	f	373	10
722	t	1	f	2	f	373	10
723	t	2	f	8	f	373	10
538	t	0	f	1	f	320	11
539	t	1	f	2	f	320	11
540	t	2	f	8	f	320	11
565	t	0	f	1	f	341	11
566	t	1	f	2	f	341	11
567	t	2	f	8	f	341	11
727	t	0	f	1	f	381	11
728	t	1	f	2	f	381	11
729	t	2	f	8	f	381	11
613	t	0	f	1	f	349	11
614	t	1	f	2	f	349	11
615	t	2	f	8	f	349	11
979	t	0	f	1	f	434	11
980	t	1	f	2	f	434	11
981	t	2	f	8	f	434	11
631	t	0	f	1	f	352	11
632	t	1	f	2	f	352	11
633	t	2	f	8	f	352	11
745	t	0	f	1	f	384	11
746	t	1	f	2	f	384	11
747	t	2	f	8	f	384	11
667	t	0	f	1	f	364	10
668	t	1	f	2	f	364	10
669	t	2	f	8	f	364	10
751	t	0	f	1	f	385	11
752	t	1	f	2	f	385	11
753	t	2	f	8	f	385	11
997	t	0	f	1	f	438	11
998	t	1	f	2	f	438	11
999	t	2	f	8	f	438	11
769	t	0	f	1	f	388	11
770	t	1	f	2	f	388	11
771	t	2	f	8	f	388	11
793	t	0	f	1	f	397	11
794	t	1	f	2	f	397	11
795	t	2	f	8	f	397	11
1003	t	0	f	1	f	444	11
1004	t	1	f	2	f	444	11
1005	t	2	f	8	f	444	11
799	t	0	f	1	f	398	11
800	t	1	f	2	f	398	11
801	t	2	f	8	f	398	11
823	t	0	f	1	f	402	11
824	t	1	f	2	f	402	11
825	t	2	f	8	f	402	11
1015	t	0	f	1	f	451	11
1016	t	1	f	2	f	451	11
1017	t	2	f	8	f	451	11
829	t	0	f	1	f	403	11
830	t	1	f	2	f	403	11
831	t	2	f	8	f	403	11
835	t	0	f	1	f	404	11
836	t	1	f	2	f	404	11
837	t	2	f	8	f	404	11
865	t	0	f	1	f	414	10
866	t	1	f	2	f	414	10
867	t	2	f	8	f	414	10
883	t	0	f	1	f	417	10
884	t	1	f	2	f	417	10
885	t	2	f	8	f	417	10
925	t	0	f	1	f	424	10
926	t	1	f	2	f	424	10
927	t	2	f	8	f	424	10
937	t	0	f	1	f	426	11
938	t	1	f	2	f	426	11
939	t	2	f	8	f	426	11
418	t	0	f	1	f	300	11
419	t	1	f	2	f	300	11
420	t	2	f	8	f	300	11
424	t	0	f	1	f	301	10
425	t	1	f	2	f	301	10
426	t	2	f	8	f	301	10
448	t	0	f	1	f	305	11
449	t	1	f	2	f	305	11
450	t	2	f	8	f	305	11
679	t	0	f	1	f	366	10
680	t	1	f	2	f	366	10
681	t	2	f	8	f	366	10
466	t	0	f	1	f	308	10
467	t	1	f	2	f	308	10
468	t	2	f	8	f	308	10
961	t	0	f	1	f	431	11
962	t	1	f	2	f	431	11
963	t	2	f	8	f	431	11
484	t	0	f	1	f	311	10
485	t	1	f	2	f	311	10
486	t	2	f	8	f	311	10
697	t	0	f	1	f	369	10
698	t	1	f	2	f	369	10
699	t	2	f	8	f	369	10
496	t	0	f	1	f	313	11
497	t	1	f	2	f	313	11
498	t	2	f	8	f	313	11
520	t	0	f	1	f	317	11
521	t	1	f	2	f	317	11
522	t	2	f	8	f	317	11
715	t	0	f	1	f	372	10
551	t	0	f	1	f	328	10
552	t	1	f	1	f	328	11
716	t	1	f	2	f	372	10
717	t	2	f	8	f	372	10
985	t	0	f	1	f	435	11
571	t	0	f	1	f	342	11
572	t	1	f	2	f	342	11
573	t	2	f	8	f	342	11
986	t	1	f	2	f	435	11
987	t	2	f	8	f	435	11
739	t	0	f	1	f	383	11
583	t	0	f	1	f	344	11
584	t	1	f	2	f	344	11
585	t	2	f	8	f	344	11
740	t	1	f	2	f	383	11
741	t	2	f	8	f	383	11
589	t	0	f	1	f	345	11
590	t	1	f	2	f	345	11
591	t	2	f	8	f	345	11
775	t	0	f	1	f	389	11
595	t	0	f	1	f	346	11
596	t	1	f	2	f	346	11
597	t	2	f	8	f	346	11
776	t	1	f	2	f	389	11
777	t	2	f	8	f	389	11
991	t	0	f	1	f	437	11
601	t	0	f	1	f	347	11
602	t	1	f	2	f	347	11
603	t	2	f	8	f	347	11
992	t	1	f	2	f	437	11
993	t	2	f	8	f	437	11
805	t	0	f	1	f	399	11
619	t	0	f	1	f	350	11
620	t	1	f	2	f	350	11
621	t	2	f	8	f	350	11
806	t	1	f	2	f	399	11
807	t	2	f	8	f	399	11
637	t	0	f	1	f	356	10
638	t	1	f	2	f	356	10
639	t	2	f	8	f	356	10
841	t	0	f	1	f	405	11
655	t	0	f	1	f	362	10
656	t	1	f	2	f	362	10
657	t	2	f	8	f	362	10
842	t	1	f	2	f	405	11
843	t	2	f	8	f	405	11
1021	t	0	f	1	f	452	11
847	t	0	f	1	f	406	11
848	t	1	f	2	f	406	11
849	t	2	f	8	f	406	11
853	t	0	f	1	f	412	10
854	t	1	f	2	f	412	10
855	t	2	f	8	f	412	10
871	t	0	f	1	f	415	10
872	t	1	f	2	f	415	10
873	t	2	f	8	f	415	10
889	t	0	f	1	f	418	10
890	t	1	f	2	f	418	10
891	t	2	f	8	f	418	10
895	t	0	f	1	f	419	10
896	t	1	f	2	f	419	10
897	t	2	f	8	f	419	10
907	t	0	f	1	f	421	10
908	t	1	f	2	f	421	10
909	t	2	f	8	f	421	10
919	t	0	f	1	f	423	10
920	t	1	f	2	f	423	10
921	t	2	f	8	f	423	10
943	t	0	f	1	f	427	11
944	t	1	f	2	f	427	11
945	t	2	f	8	f	427	11
430	t	0	f	1	f	302	10
431	t	1	f	2	f	302	10
432	t	2	f	8	f	302	10
1300	t	0	f	1	f	515	2
1301	t	1	f	2	f	515	2
1302	t	2	f	8	f	515	2
454	t	0	f	1	f	306	11
455	t	1	f	2	f	306	11
456	t	2	f	8	f	306	11
685	t	0	f	1	f	367	10
686	t	1	f	2	f	367	10
687	t	2	f	8	f	367	10
472	t	0	f	1	f	309	10
473	t	1	f	2	f	309	10
474	t	2	f	8	f	309	10
967	t	0	f	1	f	432	11
968	t	1	f	2	f	432	11
969	t	2	f	8	f	432	11
502	t	0	f	1	f	314	11
503	t	1	f	2	f	314	11
504	t	2	f	8	f	314	11
703	t	0	f	1	f	370	10
704	t	1	f	2	f	370	10
705	t	2	f	8	f	370	10
508	t	0	f	1	f	315	10
509	t	1	f	2	f	315	10
510	t	2	f	8	f	315	10
526	t	0	f	1	f	318	11
527	t	1	f	2	f	318	11
528	t	2	f	8	f	318	11
733	t	0	f	1	f	382	11
734	t	1	f	2	f	382	11
735	t	2	f	8	f	382	11
544	t	0	f	1	f	321	10
545	t	1	f	2	f	321	10
546	t	2	f	8	f	321	10
1009	t	0	f	1	f	450	11
548	t	0	f	1	f	327	10
549	t	1	f	1	f	327	11
1010	t	1	f	2	f	450	11
554	t	0	f	1	f	329	10
555	t	1	f	1	f	329	11
1011	t	2	f	8	f	450	11
757	t	0	f	1	f	386	11
758	t	1	f	2	f	386	11
559	t	0	f	1	f	330	11
560	t	1	f	2	f	330	11
561	t	2	f	8	f	330	11
759	t	2	f	8	f	386	11
1022	t	1	f	2	f	452	11
1023	t	2	f	8	f	452	11
577	t	0	f	1	f	343	11
578	t	1	f	2	f	343	11
579	t	2	f	8	f	343	11
763	t	0	f	1	f	387	11
764	t	1	f	2	f	387	11
607	t	0	f	1	f	348	11
608	t	1	f	2	f	348	11
609	t	2	f	8	f	348	11
765	t	2	f	8	f	387	11
625	t	0	f	1	f	351	11
626	t	1	f	2	f	351	11
627	t	2	f	8	f	351	11
1027	t	0	f	1	f	453	11
781	t	0	f	1	f	390	11
782	t	1	f	2	f	390	11
643	t	0	f	1	f	357	10
644	t	1	f	2	f	357	10
645	t	2	f	8	f	357	10
783	t	2	f	8	f	390	11
1028	t	1	f	2	f	453	11
1029	t	2	f	8	f	453	11
649	t	0	f	1	f	361	10
650	t	1	f	2	f	361	10
651	t	2	f	8	f	361	10
787	t	0	f	1	f	396	11
788	t	1	f	2	f	396	11
661	t	0	f	1	f	363	10
662	t	1	f	2	f	363	10
663	t	2	f	8	f	363	10
789	t	2	f	8	f	396	11
811	t	0	f	1	f	400	11
812	t	1	f	2	f	400	11
813	t	2	f	8	f	400	11
817	t	0	f	1	f	401	11
818	t	1	f	2	f	401	11
819	t	2	f	8	f	401	11
859	t	0	f	1	f	413	10
860	t	1	f	2	f	413	10
861	t	2	f	8	f	413	10
877	t	0	f	1	f	416	10
878	t	1	f	2	f	416	10
879	t	2	f	8	f	416	10
901	t	0	f	1	f	420	10
902	t	1	f	2	f	420	10
903	t	2	f	8	f	420	10
913	t	0	f	1	f	422	10
914	t	1	f	2	f	422	10
915	t	2	f	8	f	422	10
931	t	0	f	1	f	425	10
932	t	1	f	2	f	425	10
933	t	2	f	8	f	425	10
949	t	0	f	1	f	428	10
950	t	1	f	2	f	428	10
951	t	2	f	8	f	428	10
1033	t	0	f	1	f	454	11
1034	t	1	f	2	f	454	11
1035	t	2	f	8	f	454	11
1039	t	0	f	1	f	455	11
1040	t	1	f	2	f	455	11
1041	t	2	f	8	f	455	11
1045	t	0	f	1	f	456	11
1046	t	1	f	2	f	456	11
1047	t	2	f	8	f	456	11
1051	t	0	f	1	f	457	11
1052	t	1	f	2	f	457	11
1053	t	2	f	8	f	457	11
1057	t	0	f	1	f	458	11
1058	t	1	f	2	f	458	11
1059	t	2	f	8	f	458	11
1063	t	0	f	1	f	459	11
1064	t	1	f	2	f	459	11
1065	t	2	f	8	f	459	11
1069	t	0	f	1	f	460	11
1070	t	1	f	2	f	460	11
1071	t	2	f	8	f	460	11
1075	t	0	f	1	f	466	10
1076	t	1	f	2	f	466	10
1077	t	2	f	8	f	466	10
1081	t	0	f	1	f	467	10
1082	t	1	f	2	f	467	10
1083	t	2	f	8	f	467	10
1087	t	0	f	1	f	468	10
1088	t	1	f	2	f	468	10
1089	t	2	f	8	f	468	10
1093	t	0	f	1	f	469	10
1094	t	1	f	2	f	469	10
1095	t	2	f	8	f	469	10
1099	t	0	f	1	f	470	10
1100	t	1	f	2	f	470	10
1101	t	2	f	8	f	470	10
1105	t	0	f	1	f	472	2
1106	t	1	f	2	f	472	2
1107	t	2	f	8	f	472	2
1111	t	0	f	1	f	473	2
1112	t	1	f	2	f	473	2
1113	t	2	f	8	f	473	2
1117	t	0	f	1	f	474	2
1118	t	1	f	2	f	474	2
1119	t	2	f	8	f	474	2
1123	t	0	f	1	f	475	2
1124	t	1	f	2	f	475	2
1125	t	2	f	8	f	475	2
1129	t	0	f	1	f	476	12
1130	t	1	f	2	f	476	12
1131	t	2	f	8	f	476	12
1135	t	0	f	1	f	477	12
1136	t	1	f	2	f	477	12
1137	t	2	f	8	f	477	12
1141	t	0	f	1	f	479	2
1142	t	1	f	2	f	479	2
1143	t	2	f	8	f	479	2
1147	t	0	f	1	f	480	2
1148	t	1	f	2	f	480	2
1149	t	2	f	8	f	480	2
1153	t	0	f	1	f	481	2
1154	t	1	f	2	f	481	2
1155	t	2	f	8	f	481	2
1159	t	0	f	1	f	482	2
1160	t	1	f	2	f	482	2
1161	t	2	f	8	f	482	2
1165	t	0	f	1	f	483	2
1166	t	1	f	2	f	483	2
1167	t	2	f	8	f	483	2
1171	t	0	f	1	f	484	2
1172	t	1	f	2	f	484	2
1173	t	2	f	8	f	484	2
1177	t	0	f	1	f	485	2
1178	t	1	f	2	f	485	2
1179	t	2	f	8	f	485	2
1183	t	0	f	1	f	486	2
1184	t	1	f	2	f	486	2
1185	t	2	f	8	f	486	2
1189	t	0	f	1	f	487	2
1190	t	1	f	2	f	487	2
1191	t	2	f	8	f	487	2
1195	t	0	f	1	f	488	2
1196	t	1	f	2	f	488	2
1197	t	2	f	8	f	488	2
1201	t	0	f	1	f	489	2
1202	t	1	f	2	f	489	2
1203	t	2	f	8	f	489	2
1207	t	0	f	1	f	490	2
1208	t	1	f	2	f	490	2
1209	t	2	f	8	f	490	2
1213	t	0	f	1	f	491	2
1214	t	1	f	2	f	491	2
1215	t	2	f	8	f	491	2
1219	t	0	f	1	f	492	2
1220	t	1	f	2	f	492	2
1221	t	2	f	8	f	492	2
1225	t	0	f	1	f	493	2
1226	t	1	f	2	f	493	2
1227	t	2	f	8	f	493	2
1306	t	0	f	1	f	516	2
1307	t	1	f	2	f	516	2
1308	t	2	f	8	f	516	2
1231	t	0	f	1	f	494	2
1232	t	1	f	2	f	494	2
1233	t	2	f	8	f	494	2
1235	t	0	f	1	f	497	2
1236	t	1	f	1	f	497	3
1312	t	0	f	1	f	517	2
1240	t	0	f	1	f	498	2
1241	t	1	f	2	f	498	2
1242	t	2	f	8	f	498	2
1313	t	1	f	2	f	517	2
1314	t	2	f	8	f	517	2
1246	t	0	f	1	f	505	2
1247	t	1	f	2	f	505	2
1248	t	2	f	8	f	505	2
1318	t	0	f	1	f	518	2
1252	t	0	f	1	f	506	2
1253	t	1	f	2	f	506	2
1254	t	2	f	8	f	506	2
1319	t	1	f	2	f	518	2
1320	t	2	f	8	f	518	2
1258	t	0	f	1	f	508	2
1259	t	1	f	2	f	508	2
1260	t	2	f	8	f	508	2
1324	t	0	f	1	f	519	2
1264	t	0	f	1	f	509	2
1265	t	1	f	2	f	509	2
1266	t	2	f	8	f	509	2
1325	t	1	f	2	f	519	2
1326	t	2	f	8	f	519	2
1270	t	0	f	1	f	510	2
1271	t	1	f	2	f	510	2
1272	t	2	f	8	f	510	2
1330	t	0	f	1	f	520	2
1276	t	0	f	1	f	511	2
1277	t	1	f	2	f	511	2
1278	t	2	f	8	f	511	2
1331	t	1	f	2	f	520	2
1332	t	2	f	8	f	520	2
1282	t	0	f	1	f	512	2
1283	t	1	f	2	f	512	2
1284	t	2	f	8	f	512	2
1336	t	0	f	1	f	521	2
1288	t	0	f	1	f	513	2
1289	t	1	f	2	f	513	2
1290	t	2	f	8	f	513	2
1337	t	1	f	2	f	521	2
1338	t	2	f	8	f	521	2
1342	t	0	f	1	f	522	2
1343	t	1	f	2	f	522	2
1344	t	2	f	8	f	522	2
1348	t	0	f	1	f	523	2
1349	t	1	f	2	f	523	2
1350	t	2	f	8	f	523	2
1354	t	0	f	1	f	524	2
1355	t	1	f	2	f	524	2
1356	t	2	f	8	f	524	2
1360	t	0	f	1	f	526	2
1361	t	1	f	2	f	526	2
1362	t	2	f	8	f	526	2
1366	t	0	f	1	f	527	2
1367	t	1	f	2	f	527	2
1368	t	2	f	8	f	527	2
1372	t	0	f	1	f	528	2
1373	t	1	f	2	f	528	2
1374	t	2	f	8	f	528	2
1378	t	0	f	1	f	529	2
1379	t	1	f	2	f	529	2
1380	t	2	f	8	f	529	2
1384	t	0	f	1	f	530	2
1385	t	1	f	2	f	530	2
1386	t	2	f	8	f	530	2
1390	t	0	f	1	f	531	2
1391	t	1	f	2	f	531	2
1392	t	2	f	8	f	531	2
1396	t	0	f	1	f	532	2
1397	t	1	f	2	f	532	2
1398	t	2	f	8	f	532	2
1402	t	0	f	1	f	533	2
1403	t	1	f	2	f	533	2
1404	t	2	f	8	f	533	2
1408	t	0	f	1	f	535	13
1409	t	1	f	2	f	535	13
1410	t	2	f	8	f	535	13
1414	t	0	f	1	f	536	13
1415	t	1	f	2	f	536	13
1416	t	2	f	8	f	536	13
1420	t	0	f	1	f	537	2
1421	t	1	f	2	f	537	2
1422	t	2	f	8	f	537	2
1426	t	0	f	1	f	538	2
1427	t	1	f	2	f	538	2
1428	t	2	f	8	f	538	2
1432	t	0	f	1	f	539	2
1433	t	1	f	2	f	539	2
1434	t	2	f	8	f	539	2
1438	t	0	f	1	f	540	2
1439	t	1	f	2	f	540	2
1440	t	2	f	8	f	540	2
1444	t	0	f	1	f	541	2
1445	t	1	f	2	f	541	2
1446	t	2	f	8	f	541	2
1450	t	0	f	1	f	542	2
1451	t	1	f	2	f	542	2
1452	t	2	f	8	f	542	2
1456	t	0	f	1	f	543	2
1457	t	1	f	2	f	543	2
1458	t	2	f	8	f	543	2
1462	t	0	f	1	f	544	2
1463	t	1	f	2	f	544	2
1464	t	2	f	8	f	544	2
1468	t	0	f	1	f	545	2
1469	t	1	f	2	f	545	2
1470	t	2	f	8	f	545	2
1480	t	0	f	1	f	547	2
1481	t	1	f	2	f	547	2
1482	t	2	f	8	f	547	2
1498	t	0	f	1	f	550	2
1499	t	1	f	2	f	550	2
1500	t	2	f	8	f	550	2
1505	t	0	f	1	f	552	2
1506	t	1	f	1	f	552	3
1474	t	0	f	1	f	546	2
1475	t	1	f	2	f	546	2
1476	t	2	f	8	f	546	2
1486	t	0	f	1	f	548	2
1487	t	1	f	2	f	548	2
1488	t	2	f	8	f	548	2
1502	t	0	f	1	f	551	2
1503	t	1	f	1	f	551	3
1492	t	0	f	1	f	549	2
1493	t	1	f	2	f	549	2
1494	t	2	f	8	f	549	2
1510	t	0	f	1	f	553	2
1511	t	1	f	2	f	553	2
1512	t	2	f	8	f	553	2
1514	t	0	f	1	f	564	2
1515	t	1	f	1	f	564	3
1519	t	0	f	1	f	565	2
1520	t	1	f	2	f	565	2
1521	t	2	f	8	f	565	2
1525	t	0	f	1	f	569	2
1526	t	1	f	2	f	569	2
1527	t	2	f	8	f	569	2
1531	t	0	f	1	f	570	2
1532	t	1	f	2	f	570	2
1533	t	2	f	8	f	570	2
1537	t	0	f	1	f	571	2
1538	t	1	f	2	f	571	2
1539	t	2	f	8	f	571	2
1543	t	0	f	1	f	572	2
1544	t	1	f	2	f	572	2
1545	t	2	f	8	f	572	2
1549	t	0	f	1	f	573	2
1550	t	1	f	2	f	573	2
1551	t	2	f	8	f	573	2
1555	t	0	f	1	f	574	2
1556	t	1	f	2	f	574	2
1557	t	2	f	8	f	574	2
1561	t	0	f	1	f	575	2
1562	t	1	f	2	f	575	2
1563	t	2	f	8	f	575	2
1567	t	0	f	1	f	576	2
1568	t	1	f	2	f	576	2
1569	t	2	f	8	f	576	2
1573	t	0	f	1	f	577	2
1574	t	1	f	2	f	577	2
1575	t	2	f	8	f	577	2
1579	t	0	f	1	f	578	2
1580	t	1	f	2	f	578	2
1581	t	2	f	8	f	578	2
1585	t	0	f	1	f	579	2
1586	t	1	f	2	f	579	2
1587	t	2	f	8	f	579	2
1591	t	0	f	1	f	580	2
1592	t	1	f	2	f	580	2
1593	t	2	f	8	f	580	2
1597	t	0	f	1	f	581	2
1598	t	1	f	2	f	581	2
1599	t	2	f	8	f	581	2
1603	t	0	f	1	f	582	2
1604	t	1	f	2	f	582	2
1605	t	2	f	8	f	582	2
1609	t	0	f	1	f	583	2
1610	t	1	f	2	f	583	2
1611	t	2	f	8	f	583	2
1615	t	0	f	1	f	584	2
1616	t	1	f	2	f	584	2
1617	t	2	f	8	f	584	2
1621	t	0	f	1	f	585	2
1622	t	1	f	2	f	585	2
1623	t	2	f	8	f	585	2
1627	t	0	f	1	f	586	2
1628	t	1	f	2	f	586	2
1629	t	2	f	8	f	586	2
1633	t	0	f	1	f	587	2
1634	t	1	f	2	f	587	2
1635	t	2	f	8	f	587	2
1639	t	0	f	1	f	588	2
1640	t	1	f	2	f	588	2
1641	t	2	f	8	f	588	2
1645	t	0	f	1	f	589	2
1646	t	1	f	2	f	589	2
1647	t	2	f	8	f	589	2
1651	t	0	f	1	f	590	2
1652	t	1	f	2	f	590	2
1653	t	2	f	8	f	590	2
1657	t	0	f	1	f	591	2
1658	t	1	f	2	f	591	2
1659	t	2	f	8	f	591	2
1663	t	0	f	1	f	592	2
1664	t	1	f	2	f	592	2
1665	t	2	f	8	f	592	2
1669	t	0	f	1	f	593	2
1670	t	1	f	2	f	593	2
1671	t	2	f	8	f	593	2
1675	t	0	f	1	f	594	2
1676	t	1	f	2	f	594	2
1677	t	2	f	8	f	594	2
1681	t	0	f	1	f	595	2
1682	t	1	f	2	f	595	2
1683	t	2	f	8	f	595	2
1687	t	0	f	1	f	596	2
1688	t	1	f	2	f	596	2
1689	t	2	f	8	f	596	2
1693	t	0	f	1	f	597	2
1694	t	1	f	2	f	597	2
1695	t	2	f	8	f	597	2
1699	t	0	f	1	f	598	2
1700	t	1	f	2	f	598	2
1701	t	2	f	8	f	598	2
2017	t	0	f	1	f	651	2
2018	t	1	f	2	f	651	2
2019	t	2	f	8	f	651	2
1747	t	0	f	1	f	606	2
1748	t	1	f	2	f	606	2
1749	t	2	f	8	f	606	2
1759	t	0	f	1	f	608	2
1760	t	1	f	2	f	608	2
1761	t	2	f	8	f	608	2
2137	t	0	f	1	f	721	2
2138	t	1	f	2	f	721	2
2139	t	2	f	8	f	721	2
2155	t	0	f	1	f	730	2
2156	t	1	f	2	f	730	2
2157	t	2	f	8	f	730	2
1705	t	0	f	1	f	599	2
1706	t	1	f	2	f	599	2
1707	t	2	f	8	f	599	2
2023	t	0	f	1	f	652	2
2024	t	1	f	2	f	652	2
2025	t	2	f	8	f	652	2
2143	t	0	f	1	f	726	2
2144	t	1	f	2	f	726	2
2145	t	2	f	8	f	726	2
1711	t	0	f	1	f	600	2
1712	t	1	f	2	f	600	2
1713	t	2	f	8	f	600	2
2029	t	0	f	1	f	653	2
2030	t	1	f	2	f	653	2
2031	t	2	f	8	f	653	2
2149	t	0	f	1	f	727	2
2150	t	1	f	2	f	727	2
2151	t	2	f	8	f	727	2
1717	t	0	f	1	f	601	2
1718	t	1	f	2	f	601	2
1719	t	2	f	8	f	601	2
2035	t	0	f	1	f	654	2
2036	t	1	f	2	f	654	2
2037	t	2	f	8	f	654	2
1777	t	0	f	1	f	611	2
1778	t	1	f	2	f	611	2
1779	t	2	f	8	f	611	2
2161	t	0	f	1	f	731	2
2162	t	1	f	2	f	731	2
2163	t	2	f	8	f	731	2
2039	t	0	f	1	f	655	3
2040	t	1	f	1	f	655	2
1723	t	0	f	1	f	602	2
1724	t	1	f	2	f	602	2
1725	t	2	f	8	f	602	2
1783	t	0	f	1	f	612	2
1784	t	1	f	2	f	612	2
1785	t	2	f	8	f	612	2
2050	t	0	f	1	f	659	2
2051	t	1	f	2	f	659	2
2052	t	2	f	8	f	659	2
2059	t	0	f	1	f	664	2
2060	t	1	f	2	f	664	2
2061	t	2	f	8	f	664	2
2113	t	0	f	1	f	717	2
2114	t	1	f	2	f	717	2
2115	t	2	f	8	f	717	2
2167	t	0	f	1	f	734	2
2168	t	1	f	2	f	734	2
2169	t	2	f	8	f	734	2
1729	t	0	f	1	f	603	2
1730	t	1	f	2	f	603	2
1731	t	2	f	8	f	603	2
2044	t	0	f	1	f	656	2
2045	t	1	f	2	f	656	2
2046	t	2	f	8	f	656	2
1765	t	0	f	1	f	609	2
1766	t	1	f	2	f	609	2
1767	t	2	f	8	f	609	2
2077	t	0	f	1	f	684	2
2078	t	1	f	2	f	684	2
2079	t	2	f	8	f	684	2
2089	t	0	f	1	f	713	2
2090	t	1	f	2	f	713	2
2091	t	2	f	8	f	713	2
2179	t	0	f	1	f	737	2
2180	t	1	f	2	f	737	2
2181	t	2	f	8	f	737	2
2215	t	0	f	1	f	749	2
2216	t	1	f	2	f	749	2
2217	t	2	f	8	f	749	2
2054	t	0	f	1	f	663	3
2055	t	1	f	1	f	663	2
1735	t	0	f	1	f	604	2
1736	t	1	f	2	f	604	2
1737	t	2	f	8	f	604	2
1771	t	0	f	1	f	610	2
1772	t	1	f	2	f	610	2
1773	t	2	f	8	f	610	2
2119	t	0	f	1	f	718	2
2120	t	1	f	2	f	718	2
2121	t	2	f	8	f	718	2
2185	t	0	f	1	f	738	2
2186	t	1	f	2	f	738	2
2187	t	2	f	8	f	738	2
1741	t	0	f	1	f	605	2
1742	t	1	f	2	f	605	2
1743	t	2	f	8	f	605	2
1753	t	0	f	1	f	607	2
1754	t	1	f	2	f	607	2
1755	t	2	f	8	f	607	2
1789	t	0	f	1	f	613	2
1790	t	1	f	2	f	613	2
1791	t	2	f	8	f	613	2
1795	t	0	f	1	f	614	2
1796	t	1	f	2	f	614	2
1797	t	2	f	8	f	614	2
1801	t	0	f	1	f	615	2
1802	t	1	f	2	f	615	2
1803	t	2	f	8	f	615	2
1807	t	0	f	1	f	616	2
1808	t	1	f	2	f	616	2
1809	t	2	f	8	f	616	2
1813	t	0	f	1	f	617	2
1814	t	1	f	2	f	617	2
1815	t	2	f	8	f	617	2
1819	t	0	f	1	f	618	2
1820	t	1	f	2	f	618	2
1821	t	2	f	8	f	618	2
1825	t	0	f	1	f	619	2
1826	t	1	f	2	f	619	2
1827	t	2	f	8	f	619	2
1831	t	0	f	1	f	620	2
1832	t	1	f	2	f	620	2
1833	t	2	f	8	f	620	2
1837	t	0	f	1	f	621	2
1838	t	1	f	2	f	621	2
1839	t	2	f	8	f	621	2
1843	t	0	f	1	f	622	2
1844	t	1	f	2	f	622	2
1845	t	2	f	8	f	622	2
1849	t	0	f	1	f	623	2
1850	t	1	f	2	f	623	2
1851	t	2	f	8	f	623	2
1855	t	0	f	1	f	624	2
1856	t	1	f	2	f	624	2
1857	t	2	f	8	f	624	2
1861	t	0	f	1	f	625	2
1862	t	1	f	2	f	625	2
1863	t	2	f	8	f	625	2
1867	t	0	f	1	f	626	2
1868	t	1	f	2	f	626	2
1869	t	2	f	8	f	626	2
1873	t	0	f	1	f	627	2
1874	t	1	f	2	f	627	2
1875	t	2	f	8	f	627	2
1879	t	0	f	1	f	628	2
1880	t	1	f	2	f	628	2
1881	t	2	f	8	f	628	2
1885	t	0	f	1	f	629	2
1886	t	1	f	2	f	629	2
1887	t	2	f	8	f	629	2
1891	t	0	f	1	f	630	2
1892	t	1	f	2	f	630	2
1893	t	2	f	8	f	630	2
1897	t	0	f	1	f	631	2
1898	t	1	f	2	f	631	2
1899	t	2	f	8	f	631	2
1903	t	0	f	1	f	632	2
1904	t	1	f	2	f	632	2
1905	t	2	f	8	f	632	2
1909	t	0	f	1	f	633	2
1910	t	1	f	2	f	633	2
1911	t	2	f	8	f	633	2
1915	t	0	f	1	f	634	2
1916	t	1	f	2	f	634	2
1917	t	2	f	8	f	634	2
1921	t	0	f	1	f	635	2
1922	t	1	f	2	f	635	2
1923	t	2	f	8	f	635	2
1927	t	0	f	1	f	636	2
1928	t	1	f	2	f	636	2
1929	t	2	f	8	f	636	2
1933	t	0	f	1	f	637	2
1934	t	1	f	2	f	637	2
1935	t	2	f	8	f	637	2
1939	t	0	f	1	f	638	2
1940	t	1	f	2	f	638	2
1941	t	2	f	8	f	638	2
1945	t	0	f	1	f	639	2
1946	t	1	f	2	f	639	2
1947	t	2	f	8	f	639	2
1951	t	0	f	1	f	640	2
1952	t	1	f	2	f	640	2
1953	t	2	f	8	f	640	2
1957	t	0	f	1	f	641	2
1958	t	1	f	2	f	641	2
1959	t	2	f	8	f	641	2
1963	t	0	f	1	f	642	2
1964	t	1	f	2	f	642	2
1965	t	2	f	8	f	642	2
1969	t	0	f	1	f	643	2
1970	t	1	f	2	f	643	2
1971	t	2	f	8	f	643	2
2065	t	0	f	1	f	675	2
2066	t	1	f	2	f	675	2
2067	t	2	f	8	f	675	2
1975	t	0	f	1	f	644	2
1976	t	1	f	2	f	644	2
1977	t	2	f	8	f	644	2
1981	t	0	f	1	f	645	2
1982	t	1	f	2	f	645	2
1983	t	2	f	8	f	645	2
2071	t	0	f	1	f	680	2
2072	t	1	f	2	f	680	2
2073	t	2	f	8	f	680	2
1987	t	0	f	1	f	646	2
1988	t	1	f	2	f	646	2
1989	t	2	f	8	f	646	2
2083	t	0	f	1	f	712	2
2084	t	1	f	2	f	712	2
2085	t	2	f	8	f	712	2
2107	t	0	f	1	f	716	2
2108	t	1	f	2	f	716	2
2109	t	2	f	8	f	716	2
2191	t	0	f	1	f	740	2
2192	t	1	f	2	f	740	2
2193	t	2	f	8	f	740	2
1993	t	0	f	1	f	647	2
1994	t	1	f	2	f	647	2
1995	t	2	f	8	f	647	2
2095	t	0	f	1	f	714	2
2096	t	1	f	2	f	714	2
2097	t	2	f	8	f	714	2
2197	t	0	f	1	f	741	2
2198	t	1	f	2	f	741	2
2199	t	2	f	8	f	741	2
2203	t	0	f	1	f	743	2
2204	t	1	f	2	f	743	2
2205	t	2	f	8	f	743	2
1999	t	0	f	1	f	648	2
2000	t	1	f	2	f	648	2
2001	t	2	f	8	f	648	2
2101	t	0	f	1	f	715	2
2102	t	1	f	2	f	715	2
2103	t	2	f	8	f	715	2
2209	t	0	f	1	f	744	2
2210	t	1	f	2	f	744	2
2211	t	2	f	8	f	744	2
2005	t	0	f	1	f	649	2
2006	t	1	f	2	f	649	2
2007	t	2	f	8	f	649	2
2125	t	0	f	1	f	719	2
2126	t	1	f	2	f	719	2
2127	t	2	f	8	f	719	2
2221	t	0	f	1	f	750	2
2222	t	1	f	2	f	750	2
2223	t	2	f	8	f	750	2
2011	t	0	f	1	f	650	2
2012	t	1	f	2	f	650	2
2013	t	2	f	8	f	650	2
2131	t	0	f	1	f	720	2
2132	t	1	f	2	f	720	2
2133	t	2	f	8	f	720	2
2173	t	0	f	1	f	735	2
2174	t	1	f	2	f	735	2
2175	t	2	f	8	f	735	2
\.


--
-- Data for Name: acl_object_identity; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_object_identity (id, object_id_identity, entries_inheriting, parent_object, object_id_class, owner_sid) FROM stdin;
44	33	t	11	8	1
1	1	t	\N	1	1
45	34	t	11	8	1
46	35	t	11	8	1
2	1	t	\N	2	1
3	1	t	2	3	1
47	36	t	11	8	1
48	37	t	11	8	1
4	2	t	2	1	1
5	1	t	\N	4	1
6	1	t	2	5	1
7	2	t	\N	4	1
8	2	t	2	5	1
49	38	t	11	8	1
9	1	t	2	6	1
50	39	t	11	8	1
10	2	t	2	6	1
51	40	t	11	8	1
11	1	t	10	7	1
156	133	t	132	8	1
57	3	t	\N	9	1
162	5	t	159	3	1
58	4	t	\N	9	1
163	6	t	159	3	1
59	2	t	10	7	1
181	143	t	172	8	1
105	86	t	59	8	1
182	144	t	172	8	1
106	87	t	59	8	1
167	5	t	159	1	1
107	88	t	59	8	1
183	145	t	172	8	1
108	89	t	59	8	1
170	10	t	\N	9	1
109	90	t	59	8	1
173	135	t	172	8	1
110	91	t	59	8	1
32	21	t	11	8	1
33	22	t	11	8	1
34	23	t	11	8	1
35	24	t	11	8	1
36	25	t	11	8	1
37	26	t	11	8	1
38	27	t	11	8	1
39	28	t	11	8	1
40	29	t	11	8	1
41	30	t	11	8	1
42	31	t	11	8	1
43	32	t	11	8	1
174	136	t	172	8	1
111	92	t	59	8	1
52	3	t	\N	1	1
175	137	t	172	8	1
53	2	t	\N	2	1
54	2	t	53	3	1
112	93	t	59	8	1
55	1	t	\N	9	1
176	138	t	172	8	1
113	94	t	59	8	1
56	2	t	\N	9	1
177	139	t	172	8	1
114	95	t	59	8	1
178	140	t	172	8	1
179	141	t	172	8	1
180	142	t	172	8	1
184	146	t	172	8	1
185	147	t	172	8	1
186	148	t	172	8	1
187	149	t	172	8	1
188	150	t	172	8	1
189	151	t	172	8	1
190	152	t	172	8	1
191	153	t	172	8	1
227	186	t	197	8	1
228	6	t	10	7	1
229	196	t	228	8	1
230	193	t	228	8	1
430	135	t	\N	9	1
232	190	t	228	8	1
433	138	t	\N	9	1
464	259	t	460	8	1
115	96	t	59	8	1
116	97	t	59	8	1
117	98	t	59	8	1
118	99	t	59	8	1
119	100	t	59	8	1
120	101	t	59	8	1
121	102	t	59	8	1
122	103	t	59	8	1
123	104	t	59	8	1
124	105	t	59	8	1
125	106	t	59	8	1
126	107	t	59	8	1
450	143	t	\N	9	1
458	151	t	\N	9	1
465	260	t	460	8	1
534	270	t	498	8	1
470	15	t	328	7	1
471	261	t	470	8	1
530	200	t	\N	9	1
481	163	t	\N	9	1
235	197	t	228	8	1
158	4	t	\N	1	1
237	187	t	228	8	1
159	3	t	\N	2	1
164	3	t	\N	4	1
165	3	t	159	5	1
168	8	t	\N	9	1
239	189	t	228	8	1
240	195	t	228	8	1
171	11	t	\N	9	1
192	154	t	172	8	1
193	155	t	172	8	1
436	245	t	428	8	1
303	55	t	\N	9	1
485	167	t	\N	9	1
195	6	t	\N	1	1
243	192	t	228	8	1
196	4	t	\N	2	1
244	188	t	228	8	1
199	158	t	197	8	1
431	136	t	\N	9	1
279	5	t	\N	2	1
201	160	t	197	8	1
203	162	t	197	8	1
204	163	t	197	8	1
205	164	t	197	8	1
247	199	t	228	8	1
248	200	t	228	8	1
249	191	t	228	8	1
250	194	t	228	8	1
251	198	t	228	8	1
377	230	t	373	8	1
330	9	t	327	7	1
253	13	t	\N	9	1
281	38	t	\N	9	1
305	57	t	\N	9	1
255	15	t	\N	9	1
283	40	t	\N	9	1
257	17	t	\N	9	1
331	211	t	330	8	1
259	19	t	\N	9	1
307	59	t	\N	9	1
285	8	t	\N	1	1
263	23	t	\N	9	1
286	6	t	\N	2	1
265	25	t	\N	9	1
334	214	t	330	8	1
309	61	t	\N	9	1
267	27	t	\N	9	1
289	9	t	286	1	1
336	216	t	321	8	1
274	34	t	\N	9	1
311	63	t	\N	9	1
291	44	t	\N	9	1
276	36	t	\N	9	1
337	217	t	321	8	1
278	7	t	\N	1	1
338	218	t	321	8	1
313	65	t	\N	9	1
292	45	t	\N	9	1
339	219	t	321	8	1
295	47	t	\N	9	1
315	67	t	\N	9	1
296	48	t	\N	9	1
349	81	t	\N	9	1
317	69	t	\N	9	1
298	50	t	\N	9	1
378	231	t	373	8	1
300	52	t	\N	9	1
341	73	t	\N	9	1
361	87	t	\N	9	1
319	71	t	\N	9	1
323	4	t	\N	4	1
324	4	t	286	5	1
351	83	t	\N	9	1
328	5	t	286	6	1
344	76	t	\N	9	1
346	78	t	\N	9	1
366	92	t	\N	9	1
372	98	t	\N	9	1
347	79	t	\N	9	1
362	88	t	\N	9	1
373	10	t	327	7	1
356	85	t	\N	9	1
368	94	t	\N	9	1
363	89	t	\N	9	1
357	86	t	\N	9	1
382	100	t	\N	9	1
370	96	t	\N	9	1
364	90	t	\N	9	1
375	228	t	373	8	1
371	97	t	\N	9	1
376	229	t	373	8	1
380	233	t	373	8	1
381	99	t	\N	9	1
383	101	t	\N	9	1
384	102	t	\N	9	1
385	103	t	\N	9	1
387	105	t	\N	9	1
391	234	t	330	8	1
388	106	t	\N	9	1
389	107	t	\N	9	1
392	235	t	330	8	1
393	236	t	330	8	1
394	237	t	330	8	1
396	109	t	\N	9	1
127	108	t	59	8	1
128	109	t	59	8	1
327	4	t	286	6	1
129	5	t	\N	9	1
293	46	t	\N	9	1
166	3	t	159	6	1
130	6	t	\N	9	1
252	12	t	\N	9	1
131	7	t	\N	9	1
169	9	t	\N	9	1
132	3	t	10	7	1
133	129	t	132	8	1
134	122	t	132	8	1
135	128	t	132	8	1
136	112	t	132	8	1
137	121	t	132	8	1
138	127	t	132	8	1
139	131	t	132	8	1
140	113	t	132	8	1
141	123	t	132	8	1
142	120	t	132	8	1
143	118	t	132	8	1
144	111	t	132	8	1
145	130	t	132	8	1
146	116	t	132	8	1
147	126	t	132	8	1
148	114	t	132	8	1
149	132	t	132	8	1
150	124	t	132	8	1
151	125	t	132	8	1
152	119	t	132	8	1
153	115	t	132	8	1
154	117	t	132	8	1
155	110	t	132	8	1
272	32	t	\N	9	1
254	14	t	\N	9	1
172	4	t	10	7	1
194	156	t	172	8	1
197	5	t	10	7	1
211	170	t	197	8	1
212	171	t	197	8	1
213	172	t	197	8	1
214	173	t	197	8	1
215	174	t	197	8	1
216	175	t	197	8	1
217	176	t	197	8	1
218	177	t	197	8	1
219	178	t	197	8	1
220	179	t	197	8	1
221	180	t	197	8	1
222	181	t	197	8	1
223	182	t	197	8	1
224	183	t	197	8	1
225	184	t	197	8	1
226	185	t	197	8	1
304	56	t	\N	9	1
256	16	t	\N	9	1
329	6	t	286	6	1
258	18	t	\N	9	1
294	10	t	286	1	1
277	37	t	\N	9	1
260	20	t	\N	9	1
314	66	t	\N	9	1
262	22	t	\N	9	1
280	7	t	\N	7	1
531	201	t	\N	9	1
306	58	t	\N	9	1
264	24	t	\N	9	1
297	49	t	\N	9	1
266	26	t	\N	9	1
287	7	t	286	3	1
288	8	t	286	3	1
268	28	t	\N	9	1
321	8	t	\N	7	1
270	30	t	\N	9	1
299	51	t	\N	9	1
290	43	t	\N	9	1
322	210	t	321	8	1
308	60	t	\N	9	1
316	68	t	\N	9	1
301	53	t	\N	9	1
310	62	t	\N	9	1
302	54	t	\N	9	1
325	5	t	\N	4	1
318	70	t	\N	9	1
312	64	t	\N	9	1
326	5	t	286	5	1
343	75	t	\N	9	1
320	72	t	\N	9	1
342	74	t	\N	9	1
332	212	t	330	8	1
335	215	t	330	8	1
345	77	t	\N	9	1
348	80	t	\N	9	1
350	82	t	\N	9	1
352	84	t	\N	9	1
395	238	t	330	8	1
365	91	t	\N	9	1
367	93	t	\N	9	1
369	95	t	\N	9	1
379	232	t	373	8	1
386	104	t	\N	9	1
390	108	t	\N	9	1
397	110	t	\N	9	1
432	137	t	\N	9	1
447	253	t	444	8	1
402	115	t	\N	9	1
486	168	t	\N	9	1
451	144	t	\N	9	1
493	175	t	\N	9	1
459	152	t	\N	9	1
494	176	t	\N	9	1
472	157	t	\N	9	1
507	268	t	498	8	1
482	164	t	\N	9	1
532	202	t	\N	9	1
542	209	t	\N	9	1
516	187	t	\N	9	1
554	271	t	553	8	1
526	196	t	\N	9	1
398	111	t	\N	9	1
404	117	t	\N	9	1
533	203	t	\N	9	1
434	139	t	\N	9	1
413	120	t	\N	9	1
487	169	t	\N	9	1
438	142	t	\N	9	1
443	250	t	428	8	1
495	6	t	\N	4	1
496	6	t	2	5	1
444	13	t	329	7	1
445	251	t	444	8	1
452	145	t	\N	9	1
508	179	t	\N	9	1
460	14	t	327	7	1
461	256	t	460	8	1
462	257	t	460	8	1
543	210	t	\N	9	1
473	158	t	\N	9	1
517	188	t	\N	9	1
483	165	t	\N	9	1
547	214	t	\N	9	1
527	197	t	\N	9	1
557	274	t	553	8	1
399	112	t	\N	9	1
410	242	t	406	8	1
414	121	t	\N	9	1
435	140	t	\N	9	1
448	254	t	444	8	1
449	255	t	444	8	1
488	170	t	\N	9	1
453	146	t	\N	9	1
463	258	t	460	8	1
535	12	t	\N	1	1
497	7	t	2	6	1
474	159	t	\N	9	1
503	266	t	498	8	1
484	166	t	\N	9	1
504	267	t	498	8	1
509	180	t	\N	9	1
536	8	t	\N	2	1
518	189	t	\N	9	1
528	198	t	\N	9	1
537	204	t	\N	9	1
544	211	t	\N	9	1
545	212	t	\N	9	1
548	215	t	\N	9	1
552	9	t	2	6	1
555	272	t	553	8	1
400	113	t	\N	9	1
408	240	t	406	8	1
437	141	t	\N	9	1
441	248	t	428	8	1
454	147	t	\N	9	1
489	171	t	\N	9	1
466	153	t	\N	9	1
538	205	t	\N	9	1
475	160	t	\N	9	1
498	16	t	497	7	1
499	262	t	498	8	1
510	181	t	\N	9	1
546	213	t	\N	9	1
560	277	t	553	8	1
520	191	t	\N	9	1
522	193	t	\N	9	1
529	199	t	\N	9	1
401	114	t	\N	9	1
409	241	t	406	8	1
439	246	t	428	8	1
412	119	t	\N	9	1
442	249	t	428	8	1
455	148	t	\N	9	1
490	172	t	\N	9	1
467	154	t	\N	9	1
500	263	t	498	8	1
501	264	t	498	8	1
476	11	t	\N	1	1
502	265	t	498	8	1
477	7	t	\N	2	1
478	9	t	477	3	1
539	206	t	\N	9	1
511	182	t	\N	9	1
514	185	t	\N	9	1
553	17	t	552	7	1
558	275	t	553	8	1
515	186	t	\N	9	1
563	280	t	553	8	1
523	194	t	\N	9	1
403	116	t	\N	9	1
440	247	t	428	8	1
415	122	t	\N	9	1
456	149	t	\N	9	1
491	173	t	\N	9	1
468	155	t	\N	9	1
540	207	t	\N	9	1
479	161	t	\N	9	1
505	177	t	\N	9	1
512	183	t	\N	9	1
549	216	t	\N	9	1
519	190	t	\N	9	1
551	8	t	2	6	1
521	192	t	\N	9	1
559	276	t	553	8	1
524	195	t	\N	9	1
405	118	t	\N	9	1
446	252	t	444	8	1
406	11	t	327	7	1
407	239	t	406	8	1
411	243	t	406	8	1
416	123	t	\N	9	1
457	150	t	\N	9	1
417	124	t	\N	9	1
492	174	t	\N	9	1
469	156	t	\N	9	1
418	125	t	\N	9	1
541	208	t	\N	9	1
419	126	t	\N	9	1
480	162	t	\N	9	1
506	178	t	\N	9	1
420	127	t	\N	9	1
421	128	t	\N	9	1
513	184	t	\N	9	1
422	129	t	\N	9	1
550	217	t	\N	9	1
423	130	t	\N	9	1
556	273	t	553	8	1
424	131	t	\N	9	1
425	132	t	\N	9	1
426	133	t	\N	9	1
427	134	t	\N	9	1
428	12	t	328	7	1
429	244	t	428	8	1
564	10	t	2	6	1
600	249	t	\N	9	1
586	235	t	\N	9	1
565	18	t	564	7	1
566	281	t	565	8	1
567	282	t	565	8	1
568	283	t	565	8	1
612	261	t	\N	9	1
569	218	t	\N	9	1
587	236	t	\N	9	1
570	219	t	\N	9	1
601	250	t	\N	9	1
648	297	t	\N	9	1
571	220	t	\N	9	1
588	237	t	\N	9	1
634	283	t	\N	9	1
572	221	t	\N	9	1
622	271	t	\N	9	1
602	251	t	\N	9	1
589	238	t	\N	9	1
573	222	t	\N	9	1
613	262	t	\N	9	1
574	223	t	\N	9	1
590	239	t	\N	9	1
575	224	t	\N	9	1
603	252	t	\N	9	1
576	225	t	\N	9	1
591	240	t	\N	9	1
577	226	t	\N	9	1
629	278	t	\N	9	1
614	263	t	\N	9	1
592	241	t	\N	9	1
578	227	t	\N	9	1
604	253	t	\N	9	1
579	228	t	\N	9	1
593	242	t	\N	9	1
580	229	t	\N	9	1
623	272	t	\N	9	1
605	254	t	\N	9	1
581	230	t	\N	9	1
594	243	t	\N	9	1
582	231	t	\N	9	1
615	264	t	\N	9	1
595	244	t	\N	9	1
583	232	t	\N	9	1
606	255	t	\N	9	1
584	233	t	\N	9	1
646	295	t	\N	9	1
585	234	t	\N	9	1
639	288	t	\N	9	1
596	245	t	\N	9	1
607	256	t	\N	9	1
616	265	t	\N	9	1
597	246	t	\N	9	1
624	273	t	\N	9	1
608	257	t	\N	9	1
598	247	t	\N	9	1
630	279	t	\N	9	1
599	248	t	\N	9	1
617	266	t	\N	9	1
609	258	t	\N	9	1
635	284	t	\N	9	1
625	274	t	\N	9	1
618	267	t	\N	9	1
610	259	t	\N	9	1
611	260	t	\N	9	1
631	280	t	\N	9	1
619	268	t	\N	9	1
626	275	t	\N	9	1
620	269	t	\N	9	1
643	292	t	\N	9	1
636	285	t	\N	9	1
621	270	t	\N	9	1
632	281	t	\N	9	1
627	276	t	\N	9	1
640	289	t	\N	9	1
628	277	t	\N	9	1
637	286	t	\N	9	1
633	282	t	\N	9	1
644	293	t	\N	9	1
641	290	t	\N	9	1
638	287	t	\N	9	1
650	299	t	\N	9	1
647	296	t	\N	9	1
642	291	t	\N	9	1
645	294	t	\N	9	1
649	298	t	\N	9	1
652	301	t	\N	9	1
653	302	t	\N	9	1
651	300	t	\N	9	1
658	285	t	565	8	1
654	303	t	\N	9	1
655	11	t	2	6	1
656	19	t	655	7	1
657	284	t	656	8	1
661	7	t	\N	4	1
662	7	t	2	5	1
659	20	t	10	7	1
660	286	t	659	8	1
666	288	t	664	8	1
663	12	t	2	6	1
668	290	t	565	8	1
669	291	t	659	8	1
664	21	t	663	7	1
665	287	t	664	8	1
667	289	t	664	8	1
670	292	t	659	8	1
671	293	t	656	8	1
672	294	t	565	8	1
673	295	t	565	8	1
677	298	t	656	8	1
678	299	t	675	8	1
683	303	t	656	8	1
684	24	t	552	7	1
685	304	t	684	8	1
687	306	t	656	8	1
690	309	t	680	8	1
691	310	t	656	8	1
692	311	t	656	8	1
694	313	t	565	8	1
695	314	t	680	8	1
696	315	t	656	8	1
698	317	t	565	8	1
701	320	t	680	8	1
705	324	t	565	8	1
706	325	t	565	8	1
707	326	t	565	8	1
709	328	t	680	8	1
710	329	t	565	8	1
711	330	t	656	8	1
713	305	t	\N	9	1
715	307	t	\N	9	1
674	296	t	656	8	1
675	22	t	552	7	1
676	297	t	675	8	1
680	23	t	551	7	1
681	301	t	680	8	1
682	302	t	565	8	1
688	307	t	565	8	1
689	308	t	565	8	1
699	318	t	565	8	1
700	319	t	656	8	1
702	321	t	656	8	1
703	322	t	565	8	1
704	323	t	565	8	1
708	327	t	656	8	1
712	304	t	\N	9	1
686	305	t	565	8	1
693	312	t	680	8	1
697	316	t	680	8	1
741	323	t	\N	9	1
714	306	t	\N	9	1
742	341	t	664	8	1
716	308	t	\N	9	1
717	309	t	\N	9	1
743	324	t	\N	9	1
718	310	t	\N	9	1
744	325	t	\N	9	1
719	311	t	\N	9	1
745	342	t	664	8	1
720	312	t	\N	9	1
746	343	t	684	8	1
747	344	t	684	8	1
721	313	t	\N	9	1
722	331	t	565	8	1
723	332	t	565	8	1
724	333	t	565	8	1
725	334	t	565	8	1
748	345	t	684	8	1
726	314	t	\N	9	1
727	315	t	\N	9	1
729	336	t	664	8	1
749	326	t	\N	9	1
730	316	t	\N	9	1
750	327	t	\N	9	1
731	317	t	\N	9	1
732	337	t	656	8	1
733	338	t	664	8	1
751	346	t	684	8	1
734	318	t	\N	9	1
735	319	t	\N	9	1
736	339	t	664	8	1
737	320	t	\N	9	1
738	321	t	\N	9	1
739	340	t	664	8	1
740	322	t	\N	9	1
\.


--
-- Data for Name: acl_sid; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY acl_sid (id, sid, principal) FROM stdin;
1	admin	t
2	neosavvy	t
3	adamparrish	t
4	andre	t
5	airwatch	t
6	lroberts	t
7	j4njusa	t
8	danspeca	t
9	roundarch	t
10	aparrish_ra	t
11	dhamlett_ra	t
12	cbrouillette@globalite.ca	t
13	netsuser	t
\.


--
-- Data for Name: attribute_descriptor; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY attribute_descriptor (id, type, "precision", description, sort_order, name, valuetype) FROM stdin;
\.


--
-- Data for Name: attribute_enum_value; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY attribute_enum_value (id, sort_order, value, descriptor_id) FROM stdin;
\.


--
-- Data for Name: client_company; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY client_company (id, address_two, postal_code, address_one, state, company_name, city, country, client_user_contact_fk, parent_company_fk) FROM stdin;
1	Suite 101	27713	2224 Sedwick Rd	NC	Neosavvy, Inc.	Durham	\N	1	1
2	Suite 20	10004	11 Broad St	NY	Lab 49 Inc.	New York	\N	2	1
3	Suite 33	30318	1425 Ellsworth Industrial Blvd.	GA	AirWatch	Atlanta	\N	3	3
4	Suite 102	02111	One Lincoln Street	MA	State Street	Boston	\N	4	6
5	Suite 212	45420	3137 Delaney Street	OH	Lockheed Martin	Dayton	\N	5	6
6	P.O. Box 12800	27606	2619 Western Blvd	NC	CBC / Albright Digital	Raleigh	\N	6	1
7	Suite 100	27617	9310 Focal Point	NC	Fineline	Raleigh	\N	7	1
\.


--
-- Data for Name: client_user_contact; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY client_user_contact (id, middle_name, last_name, email_address, contact_phone_number, first_name) FROM stdin;
1	W	Parrish	aparrish@neosavvy.com	9197419597	Adam
2	J	Joshi	djoshi@lab49.com	1 (212) 966 3468	Dhaval
3	G	Roberts	alanroberts@airwatch.com	6786502347	Alan
4	M	Hannelford	dhannelford@statestreet.com	9343345876	Daniella
5	S	Fields	dfields@lockheedmartin.com	9377650956	Donna
6	Work	Gibbs	vgibbs@cbcnewmedia.com	919-890-6000	Vickie
7	O	Odom	tommy.odom@finelineprototyping.com	9196228810	Tommy
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY company (id, address_one, address_two, postal_code, state, company_name, city, country) FROM stdin;
1	2224 Sedwick Rd	Suite 101	27713	\N	Neosavvy, Inc.	Durham	USA
2	Somewhere	101	88899	\N	Andre's Company	Durham	USA
3	1425 Ellsworth Industrial Blvd.	Suite 33	30318	\N	AirWatch	Atlanta	USA
4	131 Oakland Ave		08817	\N	A Test Company	Edison	USA
5	35 Liberty St		02818	\N	Mobiquity	East Greenwich	USA
6	111 Broadway	Suite 1505	10006	\N	Roundarch	NY	USA
7	135 de la tire		J8V0E8	\N	Globalite mieux-tre performance	Gatineau	USA
8	1234 Main St.		10029	\N	Test	NY	USA
\.


--
-- Data for Name: company_expense_item_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY company_expense_item_type (id, company_fk) FROM stdin;
\.


--
-- Data for Name: company_payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY company_payment_method (id, company_fk) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY databasechangelog (id, author, filename, dateexecuted, md5sum, description, comments, tag, liquibase) FROM stdin;
raw	includeAll	src/main/db/changelogs/init/initial.sql	2011-01-24 02:31:18.304223+00	ac83697ec5589e630acfe23416832cb	Custom SQL		\N	1.9.5
1	tommy	src/main/db/changelogs/init/standardData.xml	2011-01-24 02:31:18.464223+00	6e906a7d1134c14fa3aae29d86fa075	Insert Row (x11), Alter Sequence, Insert Row (x58), Alter Sequence		\N	1.9.5
1	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.504223+00	a4140f764aa9fe80be8a7e982d645b	Create Table		\N	1.9.5
2	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.514223+00	2e58184f1d879f6fd8b13b8710d0462c	Add Not-Null Constraint		\N	1.9.5
3	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.544223+00	6c8fb6aef661f5c26c4c54a0e4b25c24	Drop Table, Create Table		\N	1.9.5
4	adam	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.614223+00	10518a5c4833b152ab97d0fa8b4af252	Create Table		\N	1.9.5
5	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.674223+00	17d02b8183b8db56fa71ca8c134fa49	Create Table (x2), Add Foreign Key Constraint (x4)		\N	1.9.5
6	tommy	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.694223+00	32e93d79214d9c946e594cbf9cbc56	Add Column, Add Foreign Key Constraint		\N	1.9.5
7	adam	src/main/db/changelogs/1.0.xml	2011-01-24 02:31:18.714223+00	35e536e74f9b25fa44f8f89c8f2f176d	Create Table, Add Foreign Key Constraint (x2)		\N	1.9.5
8	adam	src/main/db/changelogs/1.0.xml	2011-03-02 21:46:26.499261+00	d241325235eb64a4cd96dafcb33157b	Add Column		\N	1.9.5
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: expense_item_descriptor; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_descriptor (id, expense_item_type_fk) FROM stdin;
\.


--
-- Data for Name: expense_item_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_type (id, type, name, description, sort_order) FROM stdin;
1	STANDARD_EXPENSE_ITEM_TYPE	Advance	Cash Advances made by the employee for cash related purchases	1
2	STANDARD_EXPENSE_ITEM_TYPE	Air & Rail	Air and Rail travel expenses	2
3	STANDARD_EXPENSE_ITEM_TYPE	Auto Parking	Parking related expenses for garage, street, or valet parking	3
4	STANDARD_EXPENSE_ITEM_TYPE	Auto Rental	Car rentals for business travel	4
5	STANDARD_EXPENSE_ITEM_TYPE	Auto tolls	Toll fees	5
6	STANDARD_EXPENSE_ITEM_TYPE	Cell Phone	Personal Cell phone expenses for business use	6
7	STANDARD_EXPENSE_ITEM_TYPE	Computer Supplies		7
8	STANDARD_EXPENSE_ITEM_TYPE	Entertainment		8
9	STANDARD_EXPENSE_ITEM_TYPE	Home Office		9
10	STANDARD_EXPENSE_ITEM_TYPE	Incidentals		10
11	STANDARD_EXPENSE_ITEM_TYPE	Local Transportation		11
12	STANDARD_EXPENSE_ITEM_TYPE	Lodging		12
13	STANDARD_EXPENSE_ITEM_TYPE	Lodging Apartments		13
14	STANDARD_EXPENSE_ITEM_TYPE	Lodging Per Diem		14
15	STANDARD_EXPENSE_ITEM_TYPE	Meals (Actual)		15
16	STANDARD_EXPENSE_ITEM_TYPE	Meals (Per Diem)		16
17	STANDARD_EXPENSE_ITEM_TYPE	Mileage		17
18	STANDARD_EXPENSE_ITEM_TYPE	Office Supplies		18
19	STANDARD_EXPENSE_ITEM_TYPE	Paid on behalf of others		19
20	STANDARD_EXPENSE_ITEM_TYPE	Breakfast		20
21	STANDARD_EXPENSE_ITEM_TYPE	Lunch (Per Diem)		21
22	STANDARD_EXPENSE_ITEM_TYPE	Dinner (Per Diem)		22
23	STANDARD_EXPENSE_ITEM_TYPE	Postage Delivery		23
24	STANDARD_EXPENSE_ITEM_TYPE	Printing Copying		24
25	STANDARD_EXPENSE_ITEM_TYPE	Marketing		25
26	STANDARD_EXPENSE_ITEM_TYPE	Teleconference		26
27	STANDARD_EXPENSE_ITEM_TYPE	Telephone		27
28	STANDARD_EXPENSE_ITEM_TYPE	Education		28
29	STANDARD_EXPENSE_ITEM_TYPE	Miscellaneous		29
\.


--
-- Data for Name: expense_item_value; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy10mm01; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy10mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy10mm06; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy10mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy11mm01; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy11mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_item_value_yy11mm06; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_item_value_yy11mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) FROM stdin;
\.


--
-- Data for Name: expense_report; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_report (id, state_date, location, end_date, purpose, owner_fk, project_fk, status) FROM stdin;
1	\N	New York City	\N	January 2011 Travel	1	2	APPROVED
2	\N	New York City	\N	February Expenses	1	2	APPROVED
4	\N	NYC	\N	Travel to NYC	1	2	APPROVED
5	\N	NYC	\N	Travel to NYC	1	2	APPROVED
6	\N	NYC	\N	Travel to NYC	1	2	APPROVED
7	\N	NYC	\N	travel	7	\N	OPEN
8	\N	Boston MA	\N	Travel to Boston	9	6	OPEN
9	\N	Dayton, OH	\N	Travel to Dayton	10	4	OPEN
10	\N	Chicago IL	\N	Travel to Chicago	9	4	OPEN
11	\N	Chicago	\N	Travel to Chicago	10	4	OPEN
12	\N	Chicago	\N	Travel to Chicago	9	5	OPEN
13	\N	Boston, MA	\N	Travel to Boston	10	6	OPEN
14	\N	Chicago	\N	Travel to Chicago	10	4	OPEN
15	\N	Chicago	\N	Travel to Chicago	9	5	SUBMITTED
3	\N	NYC	\N	Travel to NY	1	2	APPROVED
16	\N	North Carolina	\N	Travel to NC	1	7	APPROVED
17	\N	Austin Texas	\N	Brad / Kevin / Nigel Recruiting Trip	1	9	APPROVED
18	\N	New York	\N	Team Meetings	1	10	APPROVED
20	\N	NYC	\N	Client Entertainment	1	2	APPROVED
21	\N	Raleigh, NC	\N	Business Investigation of Fineline Codebase	1	12	APPROVED
19	\N	New York	\N	Office Related Expenses	1	11	APPROVED
22	\N	NYC	\N	Mario Russo Recruiting	1	9	APPROVED
23	\N	NYC	\N	Tilt NYC Planning 2011	1	8	APPROVED
24	\N	NYC	\N	Park Slope Recruiting	1	9	APPROVED
\.


--
-- Data for Name: expense_report_audit_history; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_report_audit_history (id, comment, activity_date, user_fk, owner_fk, expense_report_fk) FROM stdin;
\.


--
-- Data for Name: expense_report_item; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY expense_report_item (id, amount, expense_date, comment, expense_report_fk, expense_item_type_fk, payment_method_fk, project_type_fk, receipt_file_ref_fk) FROM stdin;
34	71.00	2011-01-20	\N	1	16	1	3	\N
35	71.00	2011-01-24	\N	1	16	1	3	\N
32	71.00	2011-01-18	\N	1	16	1	3	\N
33	71.00	2011-01-19	\N	1	16	1	3	\N
38	71.00	2011-01-27	\N	1	16	1	3	\N
39	71.00	2011-01-28	\N	1	16	1	3	\N
36	71.00	2011-01-25	\N	1	16	1	3	\N
37	71.00	2011-01-26	\N	1	16	1	3	\N
40	2971.41	2011-01-01	\N	1	13	2	3	\N
21	71.00	2011-01-03	\N	1	16	1	3	\N
23	71.00	2011-01-05	\N	1	16	1	3	\N
22	71.00	2011-01-04	\N	1	16	1	3	\N
25	71.00	2011-01-07	\N	1	16	1	3	\N
24	71.00	2011-01-06	\N	1	16	1	3	\N
27	71.00	2011-01-11	\N	1	16	1	3	\N
26	71.00	2011-01-10	\N	1	16	1	3	\N
29	71.00	2011-01-13	\N	1	16	1	3	\N
28	71.00	2011-01-12	\N	1	16	1	3	\N
31	71.00	2011-01-17	\N	1	16	1	3	\N
30	71.00	2011-01-14	\N	1	16	1	3	\N
102	71.00	2011-02-22	\N	2	16	1	3	\N
103	71.00	2011-02-23	\N	2	16	1	3	\N
100	71.00	2011-02-18	\N	2	16	1	3	\N
101	71.00	2011-02-21	\N	2	16	1	3	\N
98	71.00	2011-02-16	\N	2	16	1	3	\N
99	71.00	2011-02-17	\N	2	16	1	3	\N
96	71.00	2011-02-14	\N	2	16	1	3	\N
97	71.00	2011-02-15	\N	2	15	1	3	\N
108	7.80	2011-02-22	\N	2	11	3	3	\N
109	44.25	2011-02-11	\N	2	8	3	2	\N
106	71.00	2011-02-28	\N	2	16	1	3	\N
107	57.30	2011-02-22	\N	2	11	3	3	\N
104	71.00	2011-02-24	\N	2	16	1	3	\N
105	71.00	2011-02-25	\N	2	16	1	3	\N
87	71.00	2011-02-01	\N	2	16	1	3	\N
86	2983.74	2011-02-01	\N	2	13	2	3	\N
93	71.00	2011-02-09	\N	2	16	1	3	\N
268	58.49	2011-07-30	\N	16	4	3	3	178
271	39.64	2011-09-18	\N	17	15	1	2	217
156	2956.23	2011-04-01	\N	4	12	2	3	\N
92	71.00	2011-02-08	\N	2	16	1	3	\N
95	71.00	2011-02-11	\N	2	16	1	3	\N
94	71.00	2011-02-10	\N	2	16	1	3	\N
89	71.00	2011-02-03	\N	2	16	1	3	\N
88	71.00	2011-02-02	\N	2	16	1	3	\N
91	71.00	2011-02-07	\N	2	16	1	3	\N
90	71.00	2011-02-04	\N	2	16	1	3	\N
133	2869.30	2011-03-01	\N	3	13	2	3	\N
171	71.00	2011-05-10	\N	5	16	1	3	\N
170	71.00	2011-05-09	\N	5	16	1	3	\N
175	71.00	2011-05-16	\N	5	16	1	3	\N
174	71.00	2011-05-13	\N	5	16	1	3	\N
173	71.00	2011-05-12	\N	5	16	1	3	\N
172	71.00	2011-05-11	\N	5	16	1	3	\N
184	71.00	2011-05-27	\N	5	16	1	3	\N
185	71.00	2011-05-31	\N	5	16	1	3	\N
178	71.00	2011-05-19	\N	5	16	1	3	\N
179	71.00	2011-05-20	\N	5	16	1	3	\N
176	71.00	2011-05-17	\N	5	16	1	3	\N
177	71.00	2011-05-18	\N	5	16	1	3	\N
182	71.00	2011-05-25	\N	5	16	1	3	\N
183	71.00	2011-05-26	\N	5	16	1	3	\N
180	71.00	2011-05-23	\N	5	16	1	3	\N
181	71.00	2011-05-24	\N	5	16	1	3	\N
186	2951.32	2011-05-02	\N	5	13	2	3	\N
196	71.00	2011-06-13	\N	6	16	1	3	\N
193	71.00	2011-06-08	\N	6	16	1	3	\N
190	71.00	2011-06-03	\N	6	16	1	3	\N
197	71.00	2011-06-14	\N	6	16	1	3	\N
187	2950.57	2011-06-01	\N	6	13	2	3	\N
189	71.00	2011-06-02	\N	6	16	1	3	\N
195	71.00	2011-06-10	\N	6	16	1	3	\N
192	71.00	2011-06-07	\N	6	16	1	3	\N
188	71.00	2011-06-01	\N	6	16	1	3	\N
199	71.00	2011-06-16	\N	6	16	1	3	\N
200	71.00	2011-06-17	\N	6	16	1	3	\N
272	72.00	2011-09-18	\N	17	15	1	2	215
280	1104.58	2011-09-15	\N	17	12	3	2	\N
150	71.00	2011-04-22	\N	4	16	1	3	\N
151	71.00	2011-04-25	\N	4	16	1	3	\N
158	71.00	2011-05-02	\N	5	16	1	3	\N
163	71.00	2011-05-04	\N	5	16	1	3	\N
162	71.00	2011-05-03	\N	5	16	1	3	\N
234	0.00	2011-07-11	\N	9	\N	\N	\N	100
129	71.00	2011-03-28	\N	3	16	1	3	\N
122	71.00	2011-03-17	\N	3	16	1	3	\N
128	71.00	2011-03-25	\N	3	16	1	3	\N
112	71.00	2011-03-03	\N	3	16	1	3	\N
121	71.00	2011-03-16	\N	3	16	1	3	\N
127	71.00	2011-03-24	\N	3	16	1	3	\N
131	71.00	2011-03-30	\N	3	16	1	3	\N
113	71.00	2011-03-04	\N	3	16	1	3	\N
123	71.00	2011-03-18	\N	3	16	1	3	\N
120	71.00	2011-03-15	\N	3	16	1	3	\N
118	71.00	2011-03-11	\N	3	16	1	3	\N
111	71.00	2011-03-02	\N	3	16	1	3	\N
130	71.00	2011-03-29	\N	3	16	1	3	\N
116	71.00	2011-03-09	\N	3	16	1	3	\N
126	71.00	2011-03-23	\N	3	16	1	3	\N
114	71.00	2011-03-07	\N	3	16	1	3	\N
132	71.00	2011-03-31	\N	3	16	1	3	\N
124	71.00	2011-03-21	\N	3	16	1	3	\N
125	71.00	2011-03-22	\N	3	16	1	3	\N
119	71.00	2011-03-14	\N	3	16	1	3	\N
115	71.00	2011-03-08	\N	3	16	1	3	\N
117	71.00	2011-03-10	\N	3	16	1	3	\N
110	71.00	2011-03-01	\N	3	16	1	3	\N
137	71.00	2011-04-05	\N	4	16	1	3	\N
136	71.00	2011-04-04	\N	4	16	1	3	\N
139	71.00	2011-04-07	\N	4	16	1	3	\N
138	71.00	2011-04-06	\N	4	16	1	3	\N
141	71.00	2011-04-11	\N	4	16	1	3	\N
140	71.00	2011-04-08	\N	4	16	1	3	\N
143	71.00	2011-04-13	\N	4	16	1	3	\N
142	71.00	2011-04-12	\N	4	16	1	3	\N
135	71.00	2011-04-01	\N	4	16	1	3	\N
152	71.00	2011-04-26	\N	4	16	1	3	\N
153	71.00	2011-04-27	\N	4	16	1	3	\N
154	71.00	2011-04-28	\N	4	16	1	3	\N
155	71.00	2011-04-29	\N	4	16	1	3	\N
144	71.00	2011-04-14	\N	4	16	1	3	\N
145	71.00	2011-04-15	\N	4	16	1	3	\N
146	71.00	2011-04-18	\N	4	16	1	3	\N
147	71.00	2011-04-19	\N	4	16	1	3	\N
148	71.00	2011-04-20	\N	4	16	1	3	\N
149	71.00	2011-04-21	\N	4	16	1	3	\N
164	71.00	2011-05-05	\N	5	16	1	3	\N
160	71.00	2011-05-06	\N	5	16	1	3	\N
191	71.00	2011-06-06	\N	6	16	1	3	\N
194	71.00	2011-06-09	\N	6	16	1	3	\N
198	71.00	2011-06-15	\N	6	16	1	3	\N
235	0.00	2011-07-11	\N	9	\N	\N	\N	102
236	0.00	2011-07-11	\N	9	\N	\N	\N	104
237	0.00	2011-07-11	\N	9	\N	\N	\N	106
216	33.00	2008-04-02	\N	8	11	1	3	56
210	43.00	2008-04-03	\N	8	11	1	3	54
217	40.00	2008-04-03	\N	8	11	1	3	60
218	40.00	2008-03-31	\N	8	11	1	3	62
219	43.00	2008-03-31	\N	8	11	1	3	64
238	0.00	2011-07-11	\N	9	\N	\N	\N	108
228	1375.00	2008-09-08	\N	10	12	1	3	88
214	17.00	2008-10-15	\N	9	11	2	3	66
215	151.75	2008-10-13	\N	9	4	1	3	72
211	151.75	2008-10-13	\N	9	12	2	3	52
212	344.00	2008-10-13	\N	9	2	3	3	58
229	43.00	2008-09-09	\N	10	11	1	3	90
230	43.25	2008-09-08	\N	10	11	1	3	92
231	40.00	2008-09-11	\N	10	11	1	3	94
232	35.00	2008-09-11	\N	10	11	1	3	96
233	307.00	2008-09-08	\N	10	2	1	3	98
239	306.00	2008-06-23	\N	11	2	1	3	110
240	44.85	2008-06-30	\N	11	11	2	3	112
241	604.69	2008-07-03	\N	11	12	2	3	114
242	40.00	2008-06-30	\N	11	11	1	3	116
243	40.00	2008-07-03	\N	11	11	1	3	118
251	434.40	2008-03-20	\N	13	12	2	3	134
270	259.32	2011-08-24	\N	16	12	1	3	197
273	16.50	2011-09-15	\N	17	2	1	2	213
252	40.00	2008-03-20	\N	13	11	1	3	136
274	439.94	2011-07-26	\N	17	2	3	2	211
253	43.00	2008-03-02	\N	13	11	3	3	138
275	25.00	2011-09-19	\N	17	10	1	2	209
254	40.00	2008-03-20	\N	13	11	1	3	140
255	40.00	2008-03-20	\N	13	11	1	3	142
276	89.00	2011-09-15	\N	17	2	3	2	207
244	867.00	2011-02-10	\N	12	12	1	3	120
245	237.00	2011-02-07	\N	12	2	1	3	122
246	43.00	2011-02-07	\N	12	11	1	3	124
247	46.00	2011-02-07	\N	12	11	1	3	126
248	40.00	2011-02-10	\N	12	11	1	3	128
249	40.00	2011-02-07	\N	12	11	1	3	130
250	400.00	2011-02-07	\N	12	12	1	3	132
262	5.33	2011-07-31	\N	16	15	1	3	162
263	23.56	2011-07-30	\N	16	15	1	3	164
264	39.75	2011-08-01	\N	16	29	1	3	166
265	189.40	2011-07-30	\N	16	2	3	3	168
266	10.25	2011-07-30	\N	16	15	1	3	170
256	20.00	2009-02-06	\N	14	11	1	3	144
257	30.45	2009-02-03	\N	14	11	1	3	146
258	19.95	2009-02-05	\N	14	25	2	3	148
259	7.95	2009-02-02	\N	14	29	1	3	150
260	400.00	2009-02-06	\N	14	13	1	3	152
267	15.86	2011-08-14	\N	16	15	1	3	172
261	234.00	2011-07-12	\N	15	9	1	3	156
277	25.00	2011-09-15	\N	17	10	1	2	205
324	35.00	2011-09-02	\N	18	3	1	2	261
325	23.26	2011-12-01	\N	18	15	2	2	251
326	185.71	2011-12-03	\N	18	15	1	2	243
286	110.12	2011-12-28	\N	20	15	1	2	176
329	15.40	2011-11-16	\N	18	11	1	2	277
338	23.14	2011-08-23	\N	21	15	1	2	317
297	98.30	2011-12-02	\N	22	15	1	1	247
291	133.00	2011-07-08	\N	20	8	2	1	199
303	47.08	2011-07-08	\N	19	18	3	1	289
292	22.30	2011-07-12	\N	20	8	3	1	201
301	159.00	2011-11-03	\N	23	29	1	1	271
287	26.00	2011-08-22	\N	21	10	1	2	184
309	105.28	2011-11-08	\N	23	29	1	1	273
312	30.40	2011-12-04	\N	23	29	1	1	233
337	17.04	2011-12-23	\N	19	23	2	1	315
306	29.33	2011-11-23	\N	19	18	3	1	253
288	28.00	2011-08-22	\N	21	11	1	2	187
289	19.01	2011-08-24	\N	21	10	1	2	189
311	6.88	2011-10-01	\N	19	23	2	1	287
315	277.60	2011-10-16	\N	19	18	3	1	285
319	41.81	2011-11-15	\N	19	15	3	1	295
336	189.40	2011-07-21	\N	21	2	3	2	\N
331	90.00	2011-12-22	\N	18	15	2	2	311
332	350.58	2011-12-22	\N	18	25	2	2	305
333	50.08	2011-12-22	\N	18	25	2	2	307
334	29.26	2011-12-21	\N	18	15	2	2	309
321	137.71	2011-10-16	\N	19	18	3	1	283
327	481.75	2011-12-06	\N	19	15	1	1	235
330	510.32	2011-12-06	\N	19	8	1	1	219
342	31.25	2011-08-24	\N	21	11	1	2	325
283	153.00	2011-08-20	\N	18	8	1	2	182
282	27.22	2011-08-20	\N	18	8	1	2	180
281	31.11	2011-08-03	\N	18	15	1	2	174
285	49.01	2011-12-19	\N	18	15	2	2	223
294	145.94	2011-12-08	\N	18	15	3	2	225
290	23.95	2011-08-20	\N	18	8	1	2	195
295	259.75	2011-12-14	\N	18	15	1	2	231
302	364.30	2011-11-12	\N	18	15	1	2	279
305	22.72	2011-12-12	\N	18	15	2	2	237
307	49.26	2011-08-26	\N	18	15	1	2	259
308	68.25	2011-09-02	\N	18	15	1	2	267
313	54.10	2011-11-18	\N	18	15	1	2	241
317	7.59	2011-08-18	\N	18	15	1	2	299
318	320.00	2011-12-18	\N	18	8	2	2	301
322	68.39	2011-09-21	\N	18	15	1	2	275
323	96.35	2011-08-27	\N	18	15	1	2	269
310	24.27	2011-11-02	\N	19	23	2	1	281
284	54.43	2011-12-16	\N	19	7	1	1	303
293	110.78	2011-12-09	\N	19	18	3	1	221
296	149.99	2011-11-12	\N	19	18	1	1	239
298	47.86	2011-11-23	\N	19	18	3	1	255
341	95.26	2011-08-24	\N	21	4	1	2	323
339	66.22	2011-08-23	\N	21	15	1	2	319
340	259.32	2011-08-22	\N	21	12	1	2	321
299	40.84	2011-12-02	\N	22	15	1	1	257
314	17.00	2011-12-01	\N	23	29	3	1	249
316	81.00	2011-11-02	\N	23	29	1	1	297
320	17.40	2011-11-14	\N	23	11	3	1	293
328	183.51	2011-11-17	\N	23	29	3	1	291
304	151.15	2011-12-11	\N	24	15	1	1	227
343	141.22	2011-11-18	\N	24	15	1	1	229
344	89.25	2011-11-30	\N	24	15	3	1	245
345	163.18	2011-09-11	\N	24	15	1	1	263
346	107.28	2011-09-09	\N	24	15	1	1	327
\.


--
-- Data for Name: file_refs; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY file_refs (id, type, file_size, created_at, last_modified_at, record_status) FROM stdin;
1	storage_service	2146017	2011-01-26 15:00:45.959+00	2011-01-26 15:01:20.709+00	a
2	storage_service	2146017	2011-01-26 15:01:22.039+00	2011-01-26 15:01:20+00	a
3	storage_service	2263311	2011-01-28 04:11:54.353+00	2011-01-28 04:12:54.793+00	a
4	storage_service	2263311	2011-01-28 04:12:55.883+00	2011-01-28 04:12:54+00	a
5	storage_service	13616	2011-03-13 18:57:19.329+00	2011-03-13 18:57:20.099+00	a
7	storage_service	2785160	2011-03-14 20:14:47.499+00	2011-03-14 20:14:46+00	a
6	storage_service	2785160	2011-03-14 20:14:11.779+00	2011-03-28 02:51:18.707+00	d
8	storage_service	19739	2011-04-15 00:38:42.458+00	2011-04-23 17:24:20.647+00	d
9	storage_service	40132	2011-04-15 12:35:34.851+00	2011-04-23 17:24:23.237+00	d
10	storage_service	40132	2011-04-15 12:38:34.021+00	2011-04-23 17:24:24.997+00	d
13	storage_service	2288440	2011-06-01 02:46:06.142+00	2011-06-01 02:46:05+00	a
15	storage_service	1631185	2011-06-01 02:54:17.272+00	2011-06-01 02:54:16+00	a
11	storage_service	34861	2011-04-23 17:25:33.457+00	2011-06-03 02:28:06.92+00	d
12	storage_service	2288440	2011-06-01 02:45:02.192+00	2011-06-03 02:28:09.06+00	d
14	storage_service	1631185	2011-06-01 02:53:43.572+00	2011-06-03 02:28:11.16+00	d
17	storage_service	3210469	2011-06-05 00:36:59.267+00	2011-06-05 00:36:58+00	a
19	storage_service	2855565	2011-06-05 00:37:39.627+00	2011-06-05 00:37:39+00	a
20	storage_service	1669476	2011-06-05 00:45:27.207+00	2011-06-05 00:45:29.657+00	a
23	storage_service	2898533	2011-06-05 02:26:39.319+00	2011-06-05 02:26:38+00	a
25	storage_service	19325129	2011-06-05 02:30:31.819+00	2011-06-05 02:30:30+00	a
27	storage_service	326902	2011-06-06 06:32:57.993+00	2011-06-06 06:32:57+00	a
28	storage_service	1556870	2011-06-06 13:32:21.45+00	2011-06-06 13:32:23.85+00	a
30	storage_service	7806850	2011-06-17 12:12:45.101+00	2011-06-17 12:12:56.241+00	a
32	storage_service	7299418	2011-06-29 00:10:52.295+00	2011-06-29 00:11:07.415+00	a
34	storage_service	7580420	2011-06-29 01:00:16.14+00	2011-06-29 01:00:30.16+00	a
37	storage_service	6693432	2011-06-29 02:11:30.463+00	2011-06-29 02:11:17+00	a
38	storage_service	9003839	2011-06-29 03:19:46.256+00	2011-06-29 03:20:04.886+00	a
40	storage_service	7229298	2011-06-29 03:27:34.296+00	2011-06-29 03:27:46.366+00	a
44	storage_service	2621018	2011-07-12 02:51:01.172+00	2011-07-12 02:51:00+00	a
46	storage_service	1373547	2011-07-12 02:53:09.912+00	2011-07-12 02:53:09+00	a
45	storage_service	1373547	2011-07-12 02:53:05.732+00	2011-07-12 02:53:35.302+00	d
48	storage_service	1807643	2011-07-12 03:03:41.606+00	2011-07-12 03:03:41+00	a
47	storage_service	1807643	2011-07-12 03:03:36.936+00	2011-07-12 03:03:57.396+00	d
50	storage_service	1171381	2011-07-12 03:05:25.626+00	2011-07-12 03:05:25+00	a
51	storage_service	1251351	2011-07-12 03:07:09.856+00	2011-07-12 03:07:12.946+00	a
52	storage_service	1251351	2011-07-12 03:07:13.336+00	2011-07-12 03:07:12+00	a
53	storage_service	2620163	2011-07-12 03:07:13.506+00	2011-07-12 03:07:19.096+00	a
54	storage_service	2620163	2011-07-12 03:07:19.616+00	2011-07-12 03:07:19+00	a
55	storage_service	3440895	2011-07-12 03:07:42.756+00	2011-07-12 03:07:49.696+00	a
56	storage_service	3440895	2011-07-12 03:07:50.086+00	2011-07-12 03:07:49+00	a
57	storage_service	1119882	2011-07-12 03:07:52.346+00	2011-07-12 03:07:55.346+00	a
58	storage_service	1119882	2011-07-12 03:07:55.796+00	2011-07-12 03:07:55+00	a
59	storage_service	2877936	2011-07-12 03:08:11.956+00	2011-07-12 03:08:18.206+00	a
60	storage_service	2877936	2011-07-12 03:08:18.776+00	2011-07-12 03:08:18+00	a
61	storage_service	2809155	2011-07-12 03:08:36.916+00	2011-07-12 03:08:42.916+00	a
62	storage_service	2809155	2011-07-12 03:08:43.446+00	2011-07-12 03:08:42+00	a
63	storage_service	2927982	2011-07-12 03:09:04.996+00	2011-07-12 03:09:11.146+00	a
64	storage_service	2927982	2011-07-12 03:09:11.816+00	2011-07-12 03:09:11+00	a
65	storage_service	1062155	2011-07-12 03:09:14.986+00	2011-07-12 03:09:17.816+00	a
66	storage_service	1062155	2011-07-12 03:09:18.236+00	2011-07-12 03:09:17+00	a
67	storage_service	2684941	2011-07-12 03:09:51.186+00	2011-07-12 03:09:57.076+00	a
68	storage_service	2684941	2011-07-12 03:09:57.496+00	2011-07-12 03:09:57+00	a
49	storage_service	1171381	2011-07-12 03:05:21.656+00	2011-07-12 03:10:40.386+00	d
69	storage_service	1310749	2011-07-12 03:10:40.886+00	2011-07-12 03:10:44.366+00	a
70	storage_service	1310749	2011-07-12 03:10:45.576+00	2011-07-12 03:10:44+00	a
71	storage_service	1075936	2011-07-12 03:10:56.586+00	2011-07-12 03:10:59.586+00	a
72	storage_service	1075936	2011-07-12 03:11:00.096+00	2011-07-12 03:10:59+00	a
73	storage_service	1034256	2011-07-12 03:29:27.056+00	2011-07-12 03:29:29.896+00	a
74	storage_service	1034256	2011-07-12 03:29:32.096+00	2011-07-12 03:29:29+00	a
75	storage_service	1324485	2011-07-12 03:29:42.416+00	2011-07-12 03:29:45.686+00	a
76	storage_service	1324485	2011-07-12 03:29:46.126+00	2011-07-12 03:29:45+00	a
77	storage_service	1533742	2011-07-12 03:29:57.186+00	2011-07-12 03:30:00.746+00	a
78	storage_service	1533742	2011-07-12 03:30:01.186+00	2011-07-12 03:30:00+00	a
79	storage_service	1524279	2011-07-12 03:30:30.696+00	2011-07-12 03:30:34.236+00	a
80	storage_service	1524279	2011-07-12 03:30:34.676+00	2011-07-12 03:30:34+00	a
81	storage_service	1186899	2011-07-12 03:30:52.896+00	2011-07-12 03:30:55.846+00	a
82	storage_service	1186899	2011-07-12 03:30:56.956+00	2011-07-12 03:30:55+00	a
83	storage_service	965312	2011-07-12 03:31:09.506+00	2011-07-12 03:31:12.186+00	a
84	storage_service	965312	2011-07-12 03:31:12.546+00	2011-07-12 03:31:12+00	a
85	storage_service	2817539	2011-07-12 03:31:32.066+00	2011-07-12 03:31:38.266+00	a
86	storage_service	2817539	2011-07-12 03:31:38.666+00	2011-07-12 03:31:38+00	a
87	storage_service	2886911	2011-07-12 03:32:01.486+00	2011-07-12 03:32:07.776+00	a
88	storage_service	2886911	2011-07-12 03:32:08.226+00	2011-07-12 03:32:07+00	a
89	storage_service	3083324	2011-07-12 03:32:21.926+00	2011-07-12 03:32:28.576+00	a
90	storage_service	3083324	2011-07-12 03:32:29.056+00	2011-07-12 03:32:28+00	a
91	storage_service	3259920	2011-07-12 03:32:46.386+00	2011-07-12 03:32:53.066+00	a
92	storage_service	3259920	2011-07-12 03:32:53.516+00	2011-07-12 03:32:53+00	a
93	storage_service	3157859	2011-07-12 03:33:05.986+00	2011-07-12 03:33:12.506+00	a
94	storage_service	3157859	2011-07-12 03:33:12.816+00	2011-07-12 03:33:12+00	a
95	storage_service	2911285	2011-07-12 03:33:48.746+00	2011-07-12 03:33:55.106+00	a
96	storage_service	2911285	2011-07-12 03:33:55.546+00	2011-07-12 03:33:55+00	a
97	storage_service	3456905	2011-07-12 03:34:22.756+00	2011-07-12 03:34:31.126+00	a
98	storage_service	3456905	2011-07-12 03:34:31.526+00	2011-07-12 03:34:31+00	a
99	storage_service	1008443	2011-07-12 03:38:10.126+00	2011-07-12 03:38:12.726+00	a
100	storage_service	1008443	2011-07-12 03:38:13.736+00	2011-07-12 03:38:12+00	a
101	storage_service	1501168	2011-07-12 03:38:21.996+00	2011-07-12 03:38:25.546+00	a
102	storage_service	1501168	2011-07-12 03:38:26.746+00	2011-07-12 03:38:25+00	a
103	storage_service	1277923	2011-07-12 03:38:33.366+00	2011-07-12 03:38:36.546+00	a
104	storage_service	1277923	2011-07-12 03:38:37.026+00	2011-07-12 03:38:36+00	a
16	storage_service	3210469	2011-06-05 00:36:54.167+00	2011-08-14 18:34:53.685+00	d
24	storage_service	19325129	2011-06-05 02:30:03.389+00	2011-08-14 18:34:55.415+00	d
22	storage_service	2898533	2011-06-05 02:26:34.109+00	2011-08-14 18:34:57.165+00	d
43	storage_service	2621018	2011-07-12 02:50:54.912+00	2011-08-14 18:35:06.205+00	d
36	storage_service	6693432	2011-06-29 02:10:39.853+00	2011-08-14 18:35:07.405+00	d
105	storage_service	1735726	2011-07-12 03:38:49.916+00	2011-07-12 03:38:53.776+00	a
106	storage_service	1735726	2011-07-12 03:38:54.746+00	2011-07-12 03:38:53+00	a
107	storage_service	941686	2011-07-12 03:39:03.056+00	2011-07-12 03:39:05.746+00	a
108	storage_service	941686	2011-07-12 03:39:06.186+00	2011-07-12 03:39:05+00	a
109	storage_service	1473591	2011-07-12 03:41:19.106+00	2011-07-12 03:41:22.666+00	a
110	storage_service	1473591	2011-07-12 03:41:23.046+00	2011-07-12 03:41:22+00	a
111	storage_service	1061649	2011-07-12 03:41:38.126+00	2011-07-12 03:41:41.016+00	a
112	storage_service	1061649	2011-07-12 03:41:41.426+00	2011-07-12 03:41:41+00	a
113	storage_service	990370	2011-07-12 03:41:53.366+00	2011-07-12 03:41:56.166+00	a
114	storage_service	990370	2011-07-12 03:41:56.506+00	2011-07-12 03:41:56+00	a
115	storage_service	1463784	2011-07-12 03:42:06.496+00	2011-07-12 03:42:09.986+00	a
116	storage_service	1463784	2011-07-12 03:42:11.186+00	2011-07-12 03:42:09+00	a
117	storage_service	1489098	2011-07-12 03:42:18.556+00	2011-07-12 03:42:22.006+00	a
118	storage_service	1489098	2011-07-12 03:42:22.546+00	2011-07-12 03:42:22+00	a
119	storage_service	2643681	2011-07-12 03:46:41.236+00	2011-07-12 03:46:47.186+00	a
120	storage_service	2643681	2011-07-12 03:46:47.676+00	2011-07-12 03:46:47+00	a
121	storage_service	3224490	2011-07-12 03:47:08.286+00	2011-07-12 03:47:15.026+00	a
122	storage_service	3224490	2011-07-12 03:47:15.446+00	2011-07-12 03:47:15+00	a
123	storage_service	3479018	2011-07-12 03:47:38.226+00	2011-07-12 03:47:45.436+00	a
124	storage_service	3479018	2011-07-12 03:47:45.916+00	2011-07-12 03:47:45+00	a
125	storage_service	3018907	2011-07-12 03:47:59.696+00	2011-07-12 03:48:07.196+00	a
126	storage_service	3018907	2011-07-12 03:48:07.636+00	2011-07-12 03:48:07+00	a
127	storage_service	3303755	2011-07-12 03:48:32.786+00	2011-07-12 03:48:39.676+00	a
128	storage_service	3303755	2011-07-12 03:48:40.066+00	2011-07-12 03:48:39+00	a
129	storage_service	2753613	2011-07-12 03:48:51.466+00	2011-07-12 03:48:57.336+00	a
130	storage_service	2753613	2011-07-12 03:48:57.806+00	2011-07-12 03:48:57+00	a
131	storage_service	2574114	2011-07-12 03:49:47.436+00	2011-07-12 03:49:53.156+00	a
132	storage_service	2574114	2011-07-12 03:49:53.596+00	2011-07-12 03:49:53+00	a
133	storage_service	1066431	2011-07-12 03:50:23.076+00	2011-07-12 03:50:25.956+00	a
134	storage_service	1066431	2011-07-12 03:50:26.476+00	2011-07-12 03:50:25+00	a
135	storage_service	1413513	2011-07-12 03:50:45.206+00	2011-07-12 03:50:48.626+00	a
136	storage_service	1413513	2011-07-12 03:50:49.586+00	2011-07-12 03:50:48+00	a
137	storage_service	1413066	2011-07-12 03:50:57.966+00	2011-07-12 03:51:01.366+00	a
138	storage_service	1413066	2011-07-12 03:51:01.946+00	2011-07-12 03:51:01+00	a
139	storage_service	1342102	2011-07-12 03:51:13.936+00	2011-07-12 03:51:17.206+00	a
140	storage_service	1342102	2011-07-12 03:51:17.736+00	2011-07-12 03:51:17+00	a
141	storage_service	1306610	2011-07-12 03:51:31.636+00	2011-07-12 03:51:34.886+00	a
142	storage_service	1306610	2011-07-12 03:51:35.356+00	2011-07-12 03:51:34+00	a
143	storage_service	1381031	2011-07-12 12:38:31.707+00	2011-07-12 12:38:49.967+00	a
144	storage_service	1381031	2011-07-12 12:38:50.487+00	2011-07-12 12:38:49+00	a
145	storage_service	1621489	2011-07-12 12:39:03.757+00	2011-07-12 12:39:24.907+00	a
146	storage_service	1621489	2011-07-12 12:39:25.937+00	2011-07-12 12:39:24+00	a
147	storage_service	1178251	2011-07-12 12:39:38.857+00	2011-07-12 12:39:54.477+00	a
148	storage_service	1178251	2011-07-12 12:39:55.347+00	2011-07-12 12:39:54+00	a
149	storage_service	1214198	2011-07-12 12:40:03.447+00	2011-07-12 12:40:19.657+00	a
150	storage_service	1214198	2011-07-12 12:40:20.167+00	2011-07-12 12:40:19+00	a
151	storage_service	1235913	2011-07-12 12:40:48.247+00	2011-07-12 12:41:04.807+00	a
152	storage_service	1235913	2011-07-12 12:41:05.427+00	2011-07-12 12:41:04+00	a
154	storage_service	1526046	2011-07-12 21:51:21.716+00	2011-07-12 21:51:20+00	a
155	storage_service	2062306	2011-07-12 23:01:18.231+00	2011-07-12 23:01:23.681+00	a
156	storage_service	2062306	2011-07-12 23:01:24.171+00	2011-07-12 23:01:23+00	a
153	storage_service	1526046	2011-07-12 21:51:13.416+00	2011-07-12 23:01:37.621+00	d
158	storage_service	743856	2011-07-24 22:23:21.747+00	2011-07-24 22:23:20+00	a
160	storage_service	1547330	2011-08-12 13:16:19.233+00	2011-08-12 13:16:18+00	a
157	storage_service	743856	2011-07-24 22:23:01.507+00	2011-08-14 18:34:42.575+00	d
159	storage_service	1547330	2011-08-12 13:16:00.993+00	2011-08-14 18:34:48.065+00	d
18	storage_service	2855565	2011-06-05 00:37:35.037+00	2011-08-14 18:34:50.865+00	d
161	storage_service	2457645	2011-08-14 21:53:40.067+00	2011-08-14 21:53:45.487+00	a
162	storage_service	2457645	2011-08-14 21:53:45.957+00	2011-08-14 21:53:45+00	a
163	storage_service	2554955	2011-08-14 21:54:14.667+00	2011-08-14 21:54:20.277+00	a
164	storage_service	2554955	2011-08-14 21:54:20.637+00	2011-08-14 21:54:20+00	a
165	storage_service	2495846	2011-08-14 21:54:34.707+00	2011-08-14 21:54:40.337+00	a
166	storage_service	2495846	2011-08-14 21:54:40.727+00	2011-08-14 21:54:40+00	a
167	storage_service	2728257	2011-08-14 21:55:17.727+00	2011-08-14 21:55:23.547+00	a
168	storage_service	2728257	2011-08-14 21:55:23.897+00	2011-08-14 21:55:23+00	a
169	storage_service	2479424	2011-08-14 21:55:55.247+00	2011-08-14 21:56:00.837+00	a
170	storage_service	2479424	2011-08-14 21:56:01.307+00	2011-08-14 21:56:00+00	a
171	storage_service	2544859	2011-08-14 21:56:39.687+00	2011-08-14 21:56:45.337+00	a
172	storage_service	2544859	2011-08-14 21:56:45.767+00	2011-08-14 21:56:45+00	a
173	storage_service	2425126	2011-08-14 21:57:02.077+00	2011-08-14 21:57:07.397+00	a
174	storage_service	2425126	2011-08-14 21:57:07.847+00	2011-08-14 21:57:07+00	a
175	storage_service	2339610	2011-08-14 21:57:38.967+00	2011-08-14 21:57:44.377+00	a
176	storage_service	2339610	2011-08-14 21:57:44.777+00	2011-08-14 21:57:44+00	a
177	storage_service	1866686	2011-08-14 22:49:46.571+00	2011-08-14 22:49:51.101+00	a
178	storage_service	1866686	2011-08-14 22:49:51.551+00	2011-08-14 22:49:51+00	a
179	storage_service	2841048	2011-08-27 02:13:11.562+00	2011-08-27 02:13:17.842+00	a
180	storage_service	2841048	2011-08-27 02:13:18.282+00	2011-08-27 02:13:17+00	a
181	storage_service	2900191	2011-08-27 02:14:43.872+00	2011-08-27 02:14:50.132+00	a
182	storage_service	2900191	2011-08-27 02:14:50.512+00	2011-08-27 02:14:50+00	a
183	storage_service	2656221	2011-08-27 02:15:02.762+00	2011-08-27 02:15:08.652+00	a
184	storage_service	2656221	2011-08-27 02:15:09.142+00	2011-08-27 02:15:08+00	a
185	storage_service	3079570	2011-08-27 02:17:11.942+00	2011-08-27 02:17:18.742+00	a
186	storage_service	2944933	2011-08-27 02:17:57.362+00	2011-08-27 02:18:03.532+00	a
187	storage_service	2944933	2011-08-27 02:18:03.932+00	2011-08-27 02:18:03+00	a
188	storage_service	3085839	2011-08-27 02:18:38.902+00	2011-08-27 02:18:45.212+00	a
189	storage_service	3085839	2011-08-27 02:18:45.662+00	2011-08-27 02:18:45+00	a
190	storage_service	2911182	2011-08-27 02:19:09.652+00	2011-08-27 02:19:15.912+00	a
191	storage_service	3042085	2011-08-27 02:20:11.612+00	2011-08-27 02:20:17.912+00	a
192	storage_service	2827449	2011-08-27 02:20:56.352+00	2011-08-27 02:21:02.592+00	a
193	storage_service	2343608	2011-08-27 02:21:16.762+00	2011-08-27 02:21:22.192+00	a
194	storage_service	1911026	2011-08-27 13:54:45.981+00	2011-08-27 13:54:50.571+00	a
195	storage_service	1911026	2011-08-27 13:54:50.941+00	2011-08-27 13:54:50+00	a
196	storage_service	2489246	2011-09-09 18:09:13.386+00	2011-09-09 18:09:19.126+00	a
197	storage_service	2489246	2011-09-09 18:09:19.576+00	2011-09-09 18:09:19+00	a
198	storage_service	1774364	2011-09-09 18:09:35.126+00	2011-09-09 18:09:39.566+00	a
199	storage_service	1774364	2011-09-09 18:09:40.026+00	2011-09-09 18:09:39+00	a
200	storage_service	1681357	2011-09-09 18:10:02.786+00	2011-09-09 18:10:06.936+00	a
201	storage_service	1681357	2011-09-09 18:10:07.386+00	2011-09-09 18:10:06+00	a
202	storage_service	1803335	2011-09-09 18:10:18.966+00	2011-09-09 18:10:23.626+00	a
203	storage_service	1803335	2011-09-09 18:10:24.166+00	2011-09-09 18:10:23+00	a
204	storage_service	2126788	2011-11-25 22:05:50.089+00	2011-11-25 22:05:55.869+00	a
205	storage_service	2126788	2011-11-25 22:05:56.729+00	2011-11-25 22:05:55+00	a
206	storage_service	2161343	2011-11-25 22:06:11.009+00	2011-11-25 22:06:16.399+00	a
207	storage_service	2161343	2011-11-25 22:06:16.979+00	2011-11-25 22:06:16+00	a
208	storage_service	2157014	2011-11-25 22:06:33.049+00	2011-11-25 22:06:38.369+00	a
209	storage_service	2157014	2011-11-25 22:06:39.079+00	2011-11-25 22:06:38+00	a
210	storage_service	2179747	2011-11-25 22:06:54.309+00	2011-11-25 22:06:59.589+00	a
211	storage_service	2179747	2011-11-25 22:07:00.279+00	2011-11-25 22:06:59+00	a
212	storage_service	1976338	2011-11-25 22:07:13.349+00	2011-11-25 22:07:18.379+00	a
213	storage_service	1976338	2011-11-25 22:07:19.559+00	2011-11-25 22:07:18+00	a
214	storage_service	2223585	2011-11-25 22:07:34.619+00	2011-11-25 22:07:39.919+00	a
215	storage_service	2223585	2011-11-25 22:07:40.509+00	2011-11-25 22:07:39+00	a
216	storage_service	2079613	2011-11-25 22:07:52.609+00	2011-11-25 22:07:57.709+00	a
217	storage_service	2079613	2011-11-25 22:07:58.329+00	2011-11-25 22:07:57+00	a
218	storage_service	2949144	2011-12-22 01:49:09.536+00	2011-12-22 01:49:18.445+00	a
219	storage_service	2949144	2011-12-22 01:49:19.182+00	2011-12-22 01:49:18+00	a
220	storage_service	2695269	2011-12-22 01:49:58.586+00	2011-12-22 01:50:18.774+00	a
221	storage_service	2695269	2011-12-22 01:50:19.206+00	2011-12-22 01:50:18+00	a
222	storage_service	2741438	2011-12-22 01:50:35.418+00	2011-12-22 01:50:42.125+00	a
223	storage_service	2741438	2011-12-22 01:50:42.506+00	2011-12-22 01:50:42+00	a
224	storage_service	2303686	2011-12-22 01:51:06.878+00	2011-12-22 01:51:15.457+00	a
225	storage_service	2303686	2011-12-22 01:51:15.88+00	2011-12-22 01:51:15+00	a
226	storage_service	2737415	2011-12-22 01:51:56.558+00	2011-12-22 01:52:09.697+00	a
227	storage_service	2737415	2011-12-22 01:52:10.236+00	2011-12-22 01:52:09+00	a
228	storage_service	3059431	2011-12-22 01:52:47.474+00	2011-12-22 01:53:02.068+00	a
229	storage_service	3059431	2011-12-22 01:53:02.529+00	2011-12-22 01:53:02+00	a
230	storage_service	2447830	2011-12-22 01:54:37.363+00	2011-12-22 01:54:51.145+00	a
231	storage_service	2447830	2011-12-22 01:54:51.587+00	2011-12-22 01:54:51+00	a
232	storage_service	2653713	2011-12-22 01:55:40.647+00	2011-12-22 01:56:03.268+00	a
233	storage_service	2653713	2011-12-22 01:56:03.813+00	2011-12-22 01:56:03+00	a
234	storage_service	1738879	2011-12-22 01:57:04.511+00	2011-12-22 01:57:20.269+00	a
235	storage_service	1738879	2011-12-22 01:57:20.81+00	2011-12-22 01:57:20+00	a
236	storage_service	2560350	2011-12-22 01:58:04.978+00	2011-12-22 01:58:25.264+00	a
237	storage_service	2560350	2011-12-22 01:58:25.807+00	2011-12-22 01:58:25+00	a
238	storage_service	2710198	2011-12-22 01:58:48.247+00	2011-12-22 01:59:15.541+00	a
239	storage_service	2710198	2011-12-22 01:59:15.97+00	2011-12-22 01:59:15+00	a
240	storage_service	2086090	2011-12-22 02:00:18.867+00	2011-12-22 02:00:28.668+00	a
241	storage_service	2086090	2011-12-22 02:00:29.253+00	2011-12-22 02:00:28+00	a
242	storage_service	2494500	2011-12-22 02:01:56.93+00	2011-12-22 02:02:10.153+00	a
243	storage_service	2494500	2011-12-22 02:02:10.599+00	2011-12-22 02:02:10+00	a
244	storage_service	2579379	2011-12-22 02:02:35.052+00	2011-12-22 02:02:53.783+00	a
245	storage_service	2579379	2011-12-22 02:02:54.201+00	2011-12-22 02:02:53+00	a
246	storage_service	2758594	2011-12-22 02:03:15.657+00	2011-12-22 02:03:36.472+00	a
247	storage_service	2758594	2011-12-22 02:03:36.922+00	2011-12-22 02:03:36+00	a
248	storage_service	2542187	2011-12-22 02:03:50.922+00	2011-12-22 02:04:10.278+00	a
249	storage_service	2542187	2011-12-22 02:04:10.791+00	2011-12-22 02:04:10+00	a
250	storage_service	2532911	2011-12-22 02:04:21.89+00	2011-12-22 02:04:42.33+00	a
251	storage_service	2532911	2011-12-22 02:04:43.309+00	2011-12-22 02:04:42+00	a
252	storage_service	2716171	2011-12-22 02:04:56.255+00	2011-12-22 02:05:17.129+00	a
253	storage_service	2716171	2011-12-22 02:05:17.753+00	2011-12-22 02:05:17+00	a
254	storage_service	2781449	2011-12-22 02:06:00.444+00	2011-12-22 02:06:21.321+00	a
255	storage_service	2781449	2011-12-22 02:06:21.795+00	2011-12-22 02:06:21+00	a
256	storage_service	2557127	2011-12-22 02:06:34.762+00	2011-12-22 02:07:25.976+00	a
257	storage_service	2557127	2011-12-22 02:07:26.37+00	2011-12-22 02:07:25+00	a
258	storage_service	3227350	2011-12-22 02:07:44.38+00	2011-12-22 02:08:01.485+00	a
259	storage_service	3227350	2011-12-22 02:08:02.434+00	2011-12-22 02:08:01+00	a
260	storage_service	2403565	2011-12-22 02:08:20.119+00	2011-12-22 02:08:36.061+00	a
261	storage_service	2403565	2011-12-22 02:08:36.712+00	2011-12-22 02:08:36+00	a
262	storage_service	3336383	2011-12-22 02:09:24.562+00	2011-12-22 02:09:56.112+00	a
263	storage_service	3336383	2011-12-22 02:09:56.844+00	2011-12-22 02:09:56+00	a
264	storage_service	3431539	2011-12-22 02:10:02.717+00	2011-12-22 02:10:12.198+00	a
265	storage_service	3431539	2011-12-22 02:10:12.729+00	2011-12-22 02:10:12+00	a
266	storage_service	3426861	2011-12-22 02:10:27.973+00	2011-12-22 02:10:43.438+00	a
267	storage_service	3426861	2011-12-22 02:10:43.907+00	2011-12-22 02:10:43+00	a
268	storage_service	2579920	2011-12-22 02:11:31.554+00	2011-12-22 02:11:46.863+00	a
269	storage_service	2579920	2011-12-22 02:11:47.65+00	2011-12-22 02:11:46+00	a
270	storage_service	2781721	2011-12-22 02:12:20.409+00	2011-12-22 02:12:33.15+00	a
271	storage_service	2781721	2011-12-22 02:12:34.003+00	2011-12-22 02:12:33+00	a
272	storage_service	3030070	2011-12-22 02:12:47.179+00	2011-12-22 02:13:15.304+00	a
273	storage_service	3030070	2011-12-22 02:13:16.304+00	2011-12-22 02:13:15+00	a
274	storage_service	2474639	2011-12-22 02:13:32.003+00	2011-12-22 02:13:45.031+00	a
275	storage_service	2474639	2011-12-22 02:13:45.91+00	2011-12-22 02:13:45+00	a
276	storage_service	2696085	2011-12-22 02:14:19.673+00	2011-12-22 02:14:32.027+00	a
277	storage_service	2696085	2011-12-22 02:14:32.448+00	2011-12-22 02:14:32+00	a
278	storage_service	2371839	2011-12-22 02:14:57.166+00	2011-12-22 02:15:15.713+00	a
279	storage_service	2371839	2011-12-22 02:15:16.203+00	2011-12-22 02:15:15+00	a
280	storage_service	2448441	2011-12-22 02:15:28.645+00	2011-12-22 02:15:39.183+00	a
281	storage_service	2448441	2011-12-22 02:15:40.035+00	2011-12-22 02:15:39+00	a
282	storage_service	2746727	2011-12-22 02:16:07.272+00	2011-12-22 02:16:25.406+00	a
283	storage_service	2746727	2011-12-22 02:16:26.258+00	2011-12-22 02:16:25+00	a
284	storage_service	2527509	2011-12-22 02:16:37.492+00	2011-12-22 02:17:13.446+00	a
285	storage_service	2527509	2011-12-22 02:17:14.373+00	2011-12-22 02:17:13+00	a
286	storage_service	2725351	2011-12-22 02:17:25.815+00	2011-12-22 02:17:41.108+00	a
287	storage_service	2725351	2011-12-22 02:17:41.725+00	2011-12-22 02:17:41+00	a
288	storage_service	2755185	2011-12-22 02:17:52.888+00	2011-12-22 02:18:04.51+00	a
289	storage_service	2755185	2011-12-22 02:18:05.49+00	2011-12-22 02:18:04+00	a
290	storage_service	2358443	2011-12-22 02:18:25.53+00	2011-12-22 02:18:39.463+00	a
291	storage_service	2358443	2011-12-22 02:18:39.902+00	2011-12-22 02:18:39+00	a
292	storage_service	2563860	2011-12-22 02:18:59.177+00	2011-12-22 02:19:07.693+00	a
293	storage_service	2563860	2011-12-22 02:19:08.104+00	2011-12-22 02:19:07+00	a
294	storage_service	2072030	2011-12-22 02:19:23.185+00	2011-12-22 02:19:35.708+00	a
295	storage_service	2072030	2011-12-22 02:19:36.549+00	2011-12-22 02:19:35+00	a
296	storage_service	2636706	2011-12-22 02:19:45.356+00	2011-12-22 02:19:59.302+00	a
297	storage_service	2636706	2011-12-22 02:20:00.316+00	2011-12-22 02:19:59+00	a
298	storage_service	2704646	2011-12-22 02:20:09.591+00	2011-12-22 02:20:26.939+00	a
299	storage_service	2704646	2011-12-22 02:20:27.396+00	2011-12-22 02:20:26+00	a
300	storage_service	4470598	2011-12-22 02:20:47.084+00	2011-12-22 02:21:06.073+00	a
301	storage_service	4470598	2011-12-22 02:21:06.495+00	2011-12-22 02:21:06+00	a
302	storage_service	2779977	2011-12-22 02:37:51.246+00	2011-12-22 02:38:13.762+00	a
303	storage_service	2779977	2011-12-22 02:38:14.293+00	2011-12-22 02:38:13+00	a
26	storage_service	326902	2011-06-06 06:32:48.023+00	2011-12-23 20:07:29.724+00	d
304	storage_service	2604146	2011-12-23 20:32:38.657+00	2011-12-23 20:32:45.393+00	a
305	storage_service	2604146	2011-12-23 20:32:45.863+00	2011-12-23 20:32:45+00	a
306	storage_service	2524440	2011-12-23 20:33:04.711+00	2011-12-23 20:33:10.825+00	a
307	storage_service	2524440	2011-12-23 20:33:11.23+00	2011-12-23 20:33:10+00	a
308	storage_service	2421733	2011-12-23 20:33:23.653+00	2011-12-23 20:33:29.601+00	a
309	storage_service	2421733	2011-12-23 20:33:30.082+00	2011-12-23 20:33:29+00	a
310	storage_service	2572207	2011-12-23 20:33:42.995+00	2011-12-23 20:33:49.252+00	a
311	storage_service	2572207	2011-12-23 20:33:49.744+00	2011-12-23 20:33:49+00	a
313	storage_service	758972	2011-12-23 21:14:47.653+00	2011-12-23 21:14:47+00	a
312	storage_service	758972	2011-12-23 21:14:43.922+00	2011-12-23 21:16:06.365+00	d
314	storage_service	2783788	2011-12-23 21:21:07.778+00	2011-12-23 21:21:14.683+00	a
315	storage_service	2783788	2011-12-23 21:21:15.085+00	2011-12-23 21:21:14+00	a
316	storage_service	2862084	2011-12-23 21:50:55.689+00	2011-12-23 21:51:03.146+00	a
317	storage_service	2862084	2011-12-23 21:51:03.604+00	2011-12-23 21:51:03+00	a
318	storage_service	2808805	2011-12-23 21:53:24.799+00	2011-12-23 21:53:31.431+00	a
319	storage_service	2808805	2011-12-23 21:53:31.966+00	2011-12-23 21:53:31+00	a
320	storage_service	2694524	2011-12-23 21:54:48.702+00	2011-12-23 21:54:55.275+00	a
321	storage_service	2694524	2011-12-23 21:54:55.644+00	2011-12-23 21:54:55+00	a
322	storage_service	2780201	2011-12-23 21:56:31.274+00	2011-12-23 21:56:37.902+00	a
323	storage_service	2780201	2011-12-23 21:56:38.368+00	2011-12-23 21:56:37+00	a
324	storage_service	2832001	2011-12-23 21:59:17.582+00	2011-12-23 21:59:24.781+00	a
325	storage_service	2832001	2011-12-23 21:59:25.251+00	2011-12-23 21:59:24+00	a
326	storage_service	2740449	2011-12-23 22:12:39.595+00	2011-12-23 22:12:46.138+00	a
327	storage_service	2740449	2011-12-23 22:12:46.553+00	2011-12-23 22:12:46+00	a
\.


--
-- Data for Name: payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY payment_method (id, type, description, name) FROM stdin;
1	STANDARD	Expense to be reimbursed to employee	Employee Paid
2	STANDARD	Expense will not be reimbursed to employee	Company Paid
3	STANDARD	Expense was on the corporate card and will not be reimbursed	Corp Card
\.


--
-- Data for Name: project; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project (id, start_date, project_name, end_date, code, parent_company_fk, client_company_fk) FROM stdin;
1	2011-01-01	Team Building 2011	2011-12-31	TM2011	1	1
2	2011-01-01	Morgan Stanley Matrix	2012-08-31	MATRIX	1	2
3	2011-04-04	AirWatch Sydney Office	\N	AWTCH-SYDNEY	3	3
4	2009-01-01	USAF-2009	2009-12-31	USAF09	6	5
5	2010-01-01	USAF-2010	2010-12-31	USAF10	6	5
6	2009-01-01	STS-2009	2009-08-31	STS-09	6	4
7	2011-05-01	CBC New Media	\N	CBC	1	6
8	2011-01-01	Event Planning	\N	EVNT	1	1
9	2011-01-01	Recruiting	\N	RCRT	1	1
10	2011-07-01	HBO	\N	HBO	1	1
11	2011-01-03	Office	\N	Office	1	1
12	2011-08-01	Travel to Fineline in NC	2011-12-30	Fineline	1	7
\.


--
-- Data for Name: project_approvers; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_approvers (user_id, project_id) FROM stdin;
\.


--
-- Data for Name: project_participants; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_participants (user_id, project_id) FROM stdin;
1	1
2	1
2	2
1	2
10	4
9	4
10	5
9	5
9	6
10	6
1	7
2	7
1	8
2	8
2	9
1	9
1	10
2	10
1	11
2	11
2	12
1	12
\.


--
-- Data for Name: project_payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_payment_method (id, project_fk) FROM stdin;
\.


--
-- Data for Name: project_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY project_type (id, type) FROM stdin;
1	Administrative
2	Non-Billable
3	Billable
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY role (id, long_name, short_name) FROM stdin;
1	Company Administrator	ROLE_ADMIN
2	Company Employee	ROLE_EMPLOYEE
\.


--
-- Data for Name: standard_expense_item_type; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY standard_expense_item_type (id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
\.


--
-- Data for Name: standard_payment_method; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY standard_payment_method (id) FROM stdin;
1
2
3
\.


--
-- Data for Name: storage_service_file_refs; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY storage_service_file_refs (id, bucket, file_key, file_name, location, content_type, owner) FROM stdin;
1	receipts	1.jpg	IMG_20110126_100027.jpg	2011/01/26	application/octet-stream	andre
2	receipts	1.jpg	IMG_20110126_100027.jpg	2011/01/26	\N	andre
3	receipts	3.jpg	IMG_20110127_231156.jpg	2011/01/28	application/octet-stream	andre
4	receipts	3.jpg	IMG_20110127_231156.jpg	2011/01/28	\N	andre
5	receipts	5.png	Screen shot 2011-03-08 at 11.15.13 AM.png	2011/03/13	application/octet-stream	neosavvy
6	receipts	6.jpg	IMG_20110314_161411.jpg	2011/03/14	application/octet-stream	neosavvy
7	receipts	6.jpg	IMG_20110314_161411.jpg	2011/03/14	\N	neosavvy
8	receipts	8.png	Screen shot 2011-04-13 at 7.12.14 AM.png	2011/04/14	application/octet-stream	neosavvy
9	receipts	9.png	Screen shot 2011-04-14 at 8.50.17 PM.png	2011/04/15	application/octet-stream	neosavvy
10	receipts	10.png	Screen shot 2011-04-14 at 8.50.17 PM.png	2011/04/15	application/octet-stream	neosavvy
11	receipts	11.png	2_1_NETS_admin_OOTB.png	2011/04/23	application/octet-stream	neosavvy
12	receipts	12.jpg	IMG_20110531_224502.jpg	2011/05/31	application/octet-stream	neosavvy
13	receipts	12.jpg	IMG_20110531_224502.jpg	2011/05/31	\N	neosavvy
14	receipts	14.jpg	IMG_20110531_225337.jpg	2011/05/31	application/octet-stream	neosavvy
15	receipts	14.jpg	IMG_20110531_225337.jpg	2011/05/31	\N	neosavvy
16	receipts	16.Gx7335	FlashTmp.Gx7335	2011/06/04	application/octet-stream	neosavvy
17	receipts	16.Gx7335	FlashTmp.Gx7335	2011/06/04	\N	neosavvy
18	receipts	18.Lo7335	FlashTmp.Lo7335	2011/06/04	application/octet-stream	neosavvy
19	receipts	18.Lo7335	FlashTmp.Lo7335	2011/06/04	\N	neosavvy
20	receipts	20bin	FlashTmp0.bin	2011/06/04	application/octet-stream	neosavvy
22	receipts	22.VC8032	FlashTmp.VC8032	2011/06/04	application/octet-stream	neosavvy
23	receipts	22.VC8032	FlashTmp.VC8032	2011/06/04	\N	neosavvy
24	receipts	24.Tv8402	FlashTmp.Tv8402	2011/06/04	application/octet-stream	neosavvy
25	receipts	24.Tv8402	FlashTmp.Tv8402	2011/06/04	\N	neosavvy
26	receipts	26.jpg	IMG_20110605_233210.jpg	2011/06/06	application/octet-stream	neosavvy
27	receipts	26.jpg	IMG_20110605_233210.jpg	2011/06/06	\N	neosavvy
28	receipts	28bin	FlashTmp1.bin	2011/06/06	application/octet-stream	neosavvy
30	receipts	30bin	FlashTmp0.bin	2011/06/17	application/octet-stream	neosavvy
32	receipts	32.png	nets-mobile.png	2011/06/28	application/octet-stream	neosavvy
34	receipts	34.png	nets-mobile.png	2011/06/28	application/octet-stream	neosavvy
36	receipts	36.png	nets-mobile.png	2011/06/28	application/octet-stream	neosavvy
37	receipts	36.png	nets-mobile.png	2011/06/28	\N	neosavvy
38	receipts	38.png	nets-mobile.png	2011/06/28	application/octet-stream	neosavvy
40	receipts	40.png	nets-mobile.png	2011/06/28	application/octet-stream	neosavvy
43	receipts	43.jpg	IMG_20110711_225100.jpg	2011/07/11	application/octet-stream	neosavvy
44	receipts	43.jpg	IMG_20110711_225100.jpg	2011/07/11	\N	neosavvy
45	receipts	45.jpg	IMG_20110711_225308.jpg	2011/07/11	application/octet-stream	aparrish_ra
46	receipts	45.jpg	IMG_20110711_225308.jpg	2011/07/11	\N	aparrish_ra
47	receipts	47.jpg	IMG_20110711_230324.jpg	2011/07/11	application/octet-stream	dhamlett_ra
48	receipts	47.jpg	IMG_20110711_230324.jpg	2011/07/11	\N	dhamlett_ra
49	receipts	49.jpg	IMG_20110711_230524.jpg	2011/07/11	application/octet-stream	aparrish_ra
50	receipts	49.jpg	IMG_20110711_230524.jpg	2011/07/11	\N	aparrish_ra
51	receipts	51.jpg	IMG_20110711_230537.jpg	2011/07/11	application/octet-stream	dhamlett_ra
52	receipts	51.jpg	IMG_20110711_230537.jpg	2011/07/11	\N	dhamlett_ra
53	receipts	53.jpg	IMG_20110711_230716.jpg	2011/07/11	application/octet-stream	aparrish_ra
54	receipts	53.jpg	IMG_20110711_230716.jpg	2011/07/11	\N	aparrish_ra
55	receipts	55.jpg	IMG_20110711_230735.jpg	2011/07/11	application/octet-stream	aparrish_ra
56	receipts	55.jpg	IMG_20110711_230735.jpg	2011/07/11	\N	aparrish_ra
57	receipts	57.jpg	IMG_20110711_230753.jpg	2011/07/11	application/octet-stream	dhamlett_ra
58	receipts	57.jpg	IMG_20110711_230753.jpg	2011/07/11	\N	dhamlett_ra
59	receipts	59.jpg	IMG_20110711_230806.jpg	2011/07/11	application/octet-stream	aparrish_ra
60	receipts	59.jpg	IMG_20110711_230806.jpg	2011/07/11	\N	aparrish_ra
61	receipts	61.jpg	IMG_20110711_230834.jpg	2011/07/11	application/octet-stream	aparrish_ra
62	receipts	61.jpg	IMG_20110711_230834.jpg	2011/07/11	\N	aparrish_ra
63	receipts	63.jpg	IMG_20110711_230859.jpg	2011/07/11	application/octet-stream	aparrish_ra
64	receipts	63.jpg	IMG_20110711_230859.jpg	2011/07/11	\N	aparrish_ra
65	receipts	65.jpg	IMG_20110711_230918.jpg	2011/07/11	application/octet-stream	dhamlett_ra
66	receipts	65.jpg	IMG_20110711_230918.jpg	2011/07/11	\N	dhamlett_ra
67	receipts	67.jpg	IMG_20110711_230953.jpg	2011/07/11	application/octet-stream	aparrish_ra
68	receipts	67.jpg	IMG_20110711_230953.jpg	2011/07/11	\N	aparrish_ra
69	receipts	69.jpg	IMG_20110711_231019.jpg	2011/07/11	application/octet-stream	dhamlett_ra
70	receipts	69.jpg	IMG_20110711_231019.jpg	2011/07/11	\N	dhamlett_ra
71	receipts	71.jpg	IMG_20110711_231058.jpg	2011/07/11	application/octet-stream	dhamlett_ra
72	receipts	71.jpg	IMG_20110711_231058.jpg	2011/07/11	\N	dhamlett_ra
73	receipts	73.jpg	IMG_20110711_232923.jpg	2011/07/11	application/octet-stream	dhamlett_ra
74	receipts	73.jpg	IMG_20110711_232923.jpg	2011/07/11	\N	dhamlett_ra
75	receipts	75.jpg	IMG_20110711_232943.jpg	2011/07/11	application/octet-stream	dhamlett_ra
76	receipts	75.jpg	IMG_20110711_232943.jpg	2011/07/11	\N	dhamlett_ra
77	receipts	77.jpg	IMG_20110711_233000.jpg	2011/07/11	application/octet-stream	dhamlett_ra
78	receipts	77.jpg	IMG_20110711_233000.jpg	2011/07/11	\N	dhamlett_ra
79	receipts	79.jpg	IMG_20110711_233024.jpg	2011/07/11	application/octet-stream	dhamlett_ra
80	receipts	79.jpg	IMG_20110711_233024.jpg	2011/07/11	\N	dhamlett_ra
81	receipts	81.jpg	IMG_20110711_233050.jpg	2011/07/11	application/octet-stream	dhamlett_ra
82	receipts	81.jpg	IMG_20110711_233050.jpg	2011/07/11	\N	dhamlett_ra
83	receipts	83.jpg	IMG_20110711_233109.jpg	2011/07/11	application/octet-stream	dhamlett_ra
84	receipts	83.jpg	IMG_20110711_233109.jpg	2011/07/11	\N	dhamlett_ra
85	receipts	85.jpg	IMG_20110711_233116.jpg	2011/07/11	application/octet-stream	aparrish_ra
86	receipts	85.jpg	IMG_20110711_233116.jpg	2011/07/11	\N	aparrish_ra
87	receipts	87.jpg	IMG_20110711_233158.jpg	2011/07/11	application/octet-stream	aparrish_ra
88	receipts	87.jpg	IMG_20110711_233158.jpg	2011/07/11	\N	aparrish_ra
89	receipts	89.jpg	IMG_20110711_233224.jpg	2011/07/11	application/octet-stream	aparrish_ra
90	receipts	89.jpg	IMG_20110711_233224.jpg	2011/07/11	\N	aparrish_ra
91	receipts	91.jpg	IMG_20110711_233245.jpg	2011/07/11	application/octet-stream	aparrish_ra
92	receipts	91.jpg	IMG_20110711_233245.jpg	2011/07/11	\N	aparrish_ra
93	receipts	93.jpg	IMG_20110711_233311.jpg	2011/07/11	application/octet-stream	aparrish_ra
94	receipts	93.jpg	IMG_20110711_233311.jpg	2011/07/11	\N	aparrish_ra
95	receipts	95.jpg	IMG_20110711_233330.jpg	2011/07/11	application/octet-stream	aparrish_ra
96	receipts	95.jpg	IMG_20110711_233330.jpg	2011/07/11	\N	aparrish_ra
97	receipts	97.jpg	IMG_20110711_233412.jpg	2011/07/11	application/octet-stream	aparrish_ra
98	receipts	97.jpg	IMG_20110711_233412.jpg	2011/07/11	\N	aparrish_ra
99	receipts	99.jpg	IMG_20110711_233804.jpg	2011/07/11	application/octet-stream	dhamlett_ra
100	receipts	99.jpg	IMG_20110711_233804.jpg	2011/07/11	\N	dhamlett_ra
101	receipts	101.jpg	IMG_20110711_233826.jpg	2011/07/11	application/octet-stream	dhamlett_ra
102	receipts	101.jpg	IMG_20110711_233826.jpg	2011/07/11	\N	dhamlett_ra
103	receipts	103.jpg	IMG_20110711_233839.jpg	2011/07/11	application/octet-stream	dhamlett_ra
104	receipts	103.jpg	IMG_20110711_233839.jpg	2011/07/11	\N	dhamlett_ra
105	receipts	105.jpg	IMG_20110711_233855.jpg	2011/07/11	application/octet-stream	dhamlett_ra
106	receipts	105.jpg	IMG_20110711_233855.jpg	2011/07/11	\N	dhamlett_ra
107	receipts	107.jpg	IMG_20110711_233907.jpg	2011/07/11	application/octet-stream	dhamlett_ra
108	receipts	107.jpg	IMG_20110711_233907.jpg	2011/07/11	\N	dhamlett_ra
109	receipts	109.jpg	IMG_20110711_234124.jpg	2011/07/11	application/octet-stream	dhamlett_ra
110	receipts	109.jpg	IMG_20110711_234124.jpg	2011/07/11	\N	dhamlett_ra
111	receipts	111.jpg	IMG_20110711_234138.jpg	2011/07/11	application/octet-stream	dhamlett_ra
112	receipts	111.jpg	IMG_20110711_234138.jpg	2011/07/11	\N	dhamlett_ra
113	receipts	113.jpg	IMG_20110711_234157.jpg	2011/07/11	application/octet-stream	dhamlett_ra
114	receipts	113.jpg	IMG_20110711_234157.jpg	2011/07/11	\N	dhamlett_ra
115	receipts	115.jpg	IMG_20110711_234211.jpg	2011/07/11	application/octet-stream	dhamlett_ra
116	receipts	115.jpg	IMG_20110711_234211.jpg	2011/07/11	\N	dhamlett_ra
117	receipts	117.jpg	IMG_20110711_234224.jpg	2011/07/11	application/octet-stream	dhamlett_ra
118	receipts	117.jpg	IMG_20110711_234224.jpg	2011/07/11	\N	dhamlett_ra
119	receipts	119.jpg	IMG_20110711_234633.jpg	2011/07/11	application/octet-stream	aparrish_ra
120	receipts	119.jpg	IMG_20110711_234633.jpg	2011/07/11	\N	aparrish_ra
121	receipts	121.jpg	IMG_20110711_234709.jpg	2011/07/11	application/octet-stream	aparrish_ra
122	receipts	121.jpg	IMG_20110711_234709.jpg	2011/07/11	\N	aparrish_ra
123	receipts	123.jpg	IMG_20110711_234735.jpg	2011/07/11	application/octet-stream	aparrish_ra
124	receipts	123.jpg	IMG_20110711_234735.jpg	2011/07/11	\N	aparrish_ra
125	receipts	125.jpg	IMG_20110711_234801.jpg	2011/07/11	application/octet-stream	aparrish_ra
126	receipts	125.jpg	IMG_20110711_234801.jpg	2011/07/11	\N	aparrish_ra
127	receipts	127.jpg	IMG_20110711_234830.jpg	2011/07/11	application/octet-stream	aparrish_ra
128	receipts	127.jpg	IMG_20110711_234830.jpg	2011/07/11	\N	aparrish_ra
129	receipts	129.jpg	IMG_20110711_234855.jpg	2011/07/11	application/octet-stream	aparrish_ra
130	receipts	129.jpg	IMG_20110711_234855.jpg	2011/07/11	\N	aparrish_ra
131	receipts	131.jpg	IMG_20110711_234949.jpg	2011/07/11	application/octet-stream	aparrish_ra
132	receipts	131.jpg	IMG_20110711_234949.jpg	2011/07/11	\N	aparrish_ra
133	receipts	133.jpg	IMG_20110711_235027.jpg	2011/07/11	application/octet-stream	dhamlett_ra
134	receipts	133.jpg	IMG_20110711_235027.jpg	2011/07/11	\N	dhamlett_ra
135	receipts	135.jpg	IMG_20110711_235043.jpg	2011/07/11	application/octet-stream	dhamlett_ra
136	receipts	135.jpg	IMG_20110711_235043.jpg	2011/07/11	\N	dhamlett_ra
137	receipts	137.jpg	IMG_20110711_235102.jpg	2011/07/11	application/octet-stream	dhamlett_ra
138	receipts	137.jpg	IMG_20110711_235102.jpg	2011/07/11	\N	dhamlett_ra
139	receipts	139.jpg	IMG_20110711_235119.jpg	2011/07/11	application/octet-stream	dhamlett_ra
140	receipts	139.jpg	IMG_20110711_235119.jpg	2011/07/11	\N	dhamlett_ra
141	receipts	141.jpg	IMG_20110711_235138.jpg	2011/07/11	application/octet-stream	dhamlett_ra
142	receipts	141.jpg	IMG_20110711_235138.jpg	2011/07/11	\N	dhamlett_ra
143	receipts	143.jpg	IMG_20110712_083836.jpg	2011/07/12	application/octet-stream	dhamlett_ra
144	receipts	143.jpg	IMG_20110712_083836.jpg	2011/07/12	\N	dhamlett_ra
145	receipts	145.jpg	IMG_20110712_083908.jpg	2011/07/12	application/octet-stream	dhamlett_ra
146	receipts	145.jpg	IMG_20110712_083908.jpg	2011/07/12	\N	dhamlett_ra
147	receipts	147.jpg	IMG_20110712_083940.jpg	2011/07/12	application/octet-stream	dhamlett_ra
148	receipts	147.jpg	IMG_20110712_083940.jpg	2011/07/12	\N	dhamlett_ra
149	receipts	149.jpg	IMG_20110712_084008.jpg	2011/07/12	application/octet-stream	dhamlett_ra
150	receipts	149.jpg	IMG_20110712_084008.jpg	2011/07/12	\N	dhamlett_ra
223	receipts	222.jpg	IMG_20111221_205037.jpg	2011/12/21	\N	neosavvy
151	receipts	151.jpg	IMG_20110712_084049.jpg	2011/07/12	application/octet-stream	dhamlett_ra
152	receipts	151.jpg	IMG_20110712_084049.jpg	2011/07/12	\N	dhamlett_ra
153	receipts	153.jpg	IMG_20110712_175058.jpg	2011/07/12	application/octet-stream	aparrish_ra
154	receipts	153.jpg	IMG_20110712_175058.jpg	2011/07/12	\N	aparrish_ra
155	receipts	155.jpg	IMG_20110712_190106.jpg	2011/07/12	application/octet-stream	aparrish_ra
156	receipts	155.jpg	IMG_20110712_190106.jpg	2011/07/12	\N	aparrish_ra
157	receipts	157.jpg	IMG_20110724_152235.jpg	2011/07/24	application/octet-stream	neosavvy
158	receipts	157.jpg	IMG_20110724_152235.jpg	2011/07/24	\N	neosavvy
159	receipts	159.jpg	IMG_20110812_091538.jpg	2011/08/12	application/octet-stream	neosavvy
160	receipts	159.jpg	IMG_20110812_091538.jpg	2011/08/12	\N	neosavvy
161	receipts	161.jpg	IMG_20110814_175339.jpg	2011/08/14	application/octet-stream	neosavvy
162	receipts	161.jpg	IMG_20110814_175339.jpg	2011/08/14	\N	neosavvy
163	receipts	163.jpg	IMG_20110814_175420.jpg	2011/08/14	application/octet-stream	neosavvy
164	receipts	163.jpg	IMG_20110814_175420.jpg	2011/08/14	\N	neosavvy
165	receipts	165.jpg	IMG_20110814_175440.jpg	2011/08/14	application/octet-stream	neosavvy
166	receipts	165.jpg	IMG_20110814_175440.jpg	2011/08/14	\N	neosavvy
167	receipts	167.jpg	IMG_20110814_175510.jpg	2011/08/14	application/octet-stream	neosavvy
168	receipts	167.jpg	IMG_20110814_175510.jpg	2011/08/14	\N	neosavvy
169	receipts	169.jpg	IMG_20110814_175541.jpg	2011/08/14	application/octet-stream	neosavvy
170	receipts	169.jpg	IMG_20110814_175541.jpg	2011/08/14	\N	neosavvy
171	receipts	171.jpg	IMG_20110814_175617.jpg	2011/08/14	application/octet-stream	neosavvy
172	receipts	171.jpg	IMG_20110814_175617.jpg	2011/08/14	\N	neosavvy
173	receipts	173.jpg	IMG_20110814_175702.jpg	2011/08/14	application/octet-stream	neosavvy
174	receipts	173.jpg	IMG_20110814_175702.jpg	2011/08/14	\N	neosavvy
175	receipts	175.jpg	IMG_20110814_175724.jpg	2011/08/14	application/octet-stream	neosavvy
176	receipts	175.jpg	IMG_20110814_175724.jpg	2011/08/14	\N	neosavvy
177	receipts	177.jpg	IMG_20110814_184948.jpg	2011/08/14	application/octet-stream	neosavvy
178	receipts	177.jpg	IMG_20110814_184948.jpg	2011/08/14	\N	neosavvy
179	receipts	179.jpg	IMG_20110826_221308.jpg	2011/08/26	application/octet-stream	neosavvy
180	receipts	179.jpg	IMG_20110826_221308.jpg	2011/08/26	\N	neosavvy
181	receipts	181.jpg	IMG_20110826_221359.jpg	2011/08/26	application/octet-stream	neosavvy
182	receipts	181.jpg	IMG_20110826_221359.jpg	2011/08/26	\N	neosavvy
183	receipts	183.jpg	IMG_20110826_221507.jpg	2011/08/26	application/octet-stream	neosavvy
184	receipts	183.jpg	IMG_20110826_221507.jpg	2011/08/26	\N	neosavvy
185	receipts	185.jpg	IMG_20110826_221606.jpg	2011/08/26	application/octet-stream	neosavvy
186	receipts	186.jpg	IMG_20110826_221756.jpg	2011/08/26	application/octet-stream	neosavvy
187	receipts	186.jpg	IMG_20110826_221756.jpg	2011/08/26	\N	neosavvy
188	receipts	188.jpg	IMG_20110826_221825.jpg	2011/08/26	application/octet-stream	neosavvy
189	receipts	188.jpg	IMG_20110826_221825.jpg	2011/08/26	\N	neosavvy
190	receipts	190.jpg	IMG_20110826_221908.jpg	2011/08/26	application/octet-stream	neosavvy
191	receipts	191.jpg	IMG_20110826_222011.jpg	2011/08/26	application/octet-stream	neosavvy
192	receipts	192.jpg	IMG_20110826_222044.jpg	2011/08/26	application/octet-stream	neosavvy
193	receipts	193.jpg	IMG_20110826_222119.jpg	2011/08/26	application/octet-stream	neosavvy
194	receipts	194.jpg	IMG_20110827_095357.jpg	2011/08/27	application/octet-stream	neosavvy
195	receipts	194.jpg	IMG_20110827_095357.jpg	2011/08/27	\N	neosavvy
196	receipts	196.jpg	IMG_20110909_140909.jpg	2011/09/09	application/octet-stream	neosavvy
197	receipts	196.jpg	IMG_20110909_140909.jpg	2011/09/09	\N	neosavvy
198	receipts	198.jpg	IMG_20110909_140935.jpg	2011/09/09	application/octet-stream	neosavvy
199	receipts	198.jpg	IMG_20110909_140935.jpg	2011/09/09	\N	neosavvy
200	receipts	200.jpg	IMG_20110909_141005.jpg	2011/09/09	application/octet-stream	neosavvy
201	receipts	200.jpg	IMG_20110909_141005.jpg	2011/09/09	\N	neosavvy
202	receipts	202.jpg	IMG_20110909_141025.jpg	2011/09/09	application/octet-stream	neosavvy
203	receipts	202.jpg	IMG_20110909_141025.jpg	2011/09/09	\N	neosavvy
204	receipts	204.jpg	IMG_20111125_170544.jpg	2011/11/25	application/octet-stream	neosavvy
205	receipts	204.jpg	IMG_20111125_170544.jpg	2011/11/25	\N	neosavvy
206	receipts	206.jpg	IMG_20111125_170613.jpg	2011/11/25	application/octet-stream	neosavvy
207	receipts	206.jpg	IMG_20111125_170613.jpg	2011/11/25	\N	neosavvy
208	receipts	208.jpg	IMG_20111125_170632.jpg	2011/11/25	application/octet-stream	neosavvy
209	receipts	208.jpg	IMG_20111125_170632.jpg	2011/11/25	\N	neosavvy
210	receipts	210.jpg	IMG_20111125_170655.jpg	2011/11/25	application/octet-stream	neosavvy
211	receipts	210.jpg	IMG_20111125_170655.jpg	2011/11/25	\N	neosavvy
212	receipts	212.jpg	IMG_20111125_170715.jpg	2011/11/25	application/octet-stream	neosavvy
213	receipts	212.jpg	IMG_20111125_170715.jpg	2011/11/25	\N	neosavvy
214	receipts	214.jpg	IMG_20111125_170736.jpg	2011/11/25	application/octet-stream	neosavvy
215	receipts	214.jpg	IMG_20111125_170736.jpg	2011/11/25	\N	neosavvy
216	receipts	216.jpg	IMG_20111125_170756.jpg	2011/11/25	application/octet-stream	neosavvy
217	receipts	216.jpg	IMG_20111125_170756.jpg	2011/11/25	\N	neosavvy
218	receipts	218.jpg	IMG_20111221_204857.jpg	2011/12/21	application/octet-stream	neosavvy
219	receipts	218.jpg	IMG_20111221_204857.jpg	2011/12/21	\N	neosavvy
220	receipts	220.jpg	IMG_20111221_204939.jpg	2011/12/21	application/octet-stream	neosavvy
221	receipts	220.jpg	IMG_20111221_204939.jpg	2011/12/21	\N	neosavvy
222	receipts	222.jpg	IMG_20111221_205037.jpg	2011/12/21	application/octet-stream	neosavvy
224	receipts	224.jpg	IMG_20111221_205104.jpg	2011/12/21	application/octet-stream	neosavvy
225	receipts	224.jpg	IMG_20111221_205104.jpg	2011/12/21	\N	neosavvy
230	receipts	230.jpg	IMG_20111221_205322.jpg	2011/12/21	application/octet-stream	neosavvy
231	receipts	230.jpg	IMG_20111221_205322.jpg	2011/12/21	\N	neosavvy
238	receipts	238.jpg	IMG_20111221_205847.jpg	2011/12/21	application/octet-stream	neosavvy
239	receipts	238.jpg	IMG_20111221_205847.jpg	2011/12/21	\N	neosavvy
246	receipts	246.jpg	IMG_20111221_210309.jpg	2011/12/21	application/octet-stream	neosavvy
247	receipts	246.jpg	IMG_20111221_210309.jpg	2011/12/21	\N	neosavvy
254	receipts	254.jpg	IMG_20111221_210536.jpg	2011/12/21	application/octet-stream	neosavvy
255	receipts	254.jpg	IMG_20111221_210536.jpg	2011/12/21	\N	neosavvy
256	receipts	256.jpg	IMG_20111221_210637.jpg	2011/12/21	application/octet-stream	neosavvy
257	receipts	256.jpg	IMG_20111221_210637.jpg	2011/12/21	\N	neosavvy
264	receipts	264.jpg	IMG_20111221_211007.jpg	2011/12/21	application/octet-stream	neosavvy
265	receipts	264.jpg	IMG_20111221_211007.jpg	2011/12/21	\N	neosavvy
270	receipts	270.jpg	IMG_20111221_211200.jpg	2011/12/21	application/octet-stream	neosavvy
271	receipts	270.jpg	IMG_20111221_211200.jpg	2011/12/21	\N	neosavvy
278	receipts	278.jpg	IMG_20111221_211452.jpg	2011/12/21	application/octet-stream	neosavvy
279	receipts	278.jpg	IMG_20111221_211452.jpg	2011/12/21	\N	neosavvy
288	receipts	288.jpg	IMG_20111221_211755.jpg	2011/12/21	application/octet-stream	neosavvy
289	receipts	288.jpg	IMG_20111221_211755.jpg	2011/12/21	\N	neosavvy
226	receipts	226.jpg	IMG_20111221_205133.jpg	2011/12/21	application/octet-stream	neosavvy
234	receipts	234.jpg	IMG_20111221_205618.jpg	2011/12/21	application/octet-stream	neosavvy
242	receipts	242.jpg	IMG_20111221_210128.jpg	2011/12/21	application/octet-stream	neosavvy
250	receipts	250.jpg	IMG_20111221_210427.jpg	2011/12/21	application/octet-stream	neosavvy
260	receipts	260.jpg	IMG_20111221_210815.jpg	2011/12/21	application/octet-stream	neosavvy
268	receipts	268.jpg	IMG_20111221_211100.jpg	2011/12/21	application/octet-stream	neosavvy
274	receipts	274.jpg	IMG_20111221_211328.jpg	2011/12/21	application/octet-stream	neosavvy
282	receipts	282.jpg	IMG_20111221_211553.jpg	2011/12/21	application/octet-stream	neosavvy
227	receipts	226.jpg	IMG_20111221_205133.jpg	2011/12/21	\N	neosavvy
229	receipts	228.jpg	IMG_20111221_205225.jpg	2011/12/21	\N	neosavvy
237	receipts	236.jpg	IMG_20111221_205738.jpg	2011/12/21	\N	neosavvy
245	receipts	244.jpg	IMG_20111221_210227.jpg	2011/12/21	\N	neosavvy
253	receipts	252.jpg	IMG_20111221_210457.jpg	2011/12/21	\N	neosavvy
259	receipts	258.jpg	IMG_20111221_210745.jpg	2011/12/21	\N	neosavvy
267	receipts	266.jpg	IMG_20111221_211031.jpg	2011/12/21	\N	neosavvy
273	receipts	272.jpg	IMG_20111221_211246.jpg	2011/12/21	\N	neosavvy
281	receipts	280.jpg	IMG_20111221_211533.jpg	2011/12/21	\N	neosavvy
287	receipts	286.jpg	IMG_20111221_211727.jpg	2011/12/21	\N	neosavvy
228	receipts	228.jpg	IMG_20111221_205225.jpg	2011/12/21	application/octet-stream	neosavvy
236	receipts	236.jpg	IMG_20111221_205738.jpg	2011/12/21	application/octet-stream	neosavvy
244	receipts	244.jpg	IMG_20111221_210227.jpg	2011/12/21	application/octet-stream	neosavvy
252	receipts	252.jpg	IMG_20111221_210457.jpg	2011/12/21	application/octet-stream	neosavvy
258	receipts	258.jpg	IMG_20111221_210745.jpg	2011/12/21	application/octet-stream	neosavvy
266	receipts	266.jpg	IMG_20111221_211031.jpg	2011/12/21	application/octet-stream	neosavvy
272	receipts	272.jpg	IMG_20111221_211246.jpg	2011/12/21	application/octet-stream	neosavvy
280	receipts	280.jpg	IMG_20111221_211533.jpg	2011/12/21	application/octet-stream	neosavvy
286	receipts	286.jpg	IMG_20111221_211727.jpg	2011/12/21	application/octet-stream	neosavvy
232	receipts	232.jpg	IMG_20111221_205519.jpg	2011/12/21	application/octet-stream	neosavvy
240	receipts	240.jpg	IMG_20111221_205934.jpg	2011/12/21	application/octet-stream	neosavvy
248	receipts	248.jpg	IMG_20111221_210352.jpg	2011/12/21	application/octet-stream	neosavvy
262	receipts	262.jpg	IMG_20111221_210850.jpg	2011/12/21	application/octet-stream	neosavvy
276	receipts	276.jpg	IMG_20111221_211359.jpg	2011/12/21	application/octet-stream	neosavvy
284	receipts	284.jpg	IMG_20111221_211638.jpg	2011/12/21	application/octet-stream	neosavvy
290	receipts	290.jpg	IMG_20111221_211817.jpg	2011/12/21	application/octet-stream	neosavvy
233	receipts	232.jpg	IMG_20111221_205519.jpg	2011/12/21	\N	neosavvy
241	receipts	240.jpg	IMG_20111221_205934.jpg	2011/12/21	\N	neosavvy
249	receipts	248.jpg	IMG_20111221_210352.jpg	2011/12/21	\N	neosavvy
263	receipts	262.jpg	IMG_20111221_210850.jpg	2011/12/21	\N	neosavvy
277	receipts	276.jpg	IMG_20111221_211359.jpg	2011/12/21	\N	neosavvy
285	receipts	284.jpg	IMG_20111221_211638.jpg	2011/12/21	\N	neosavvy
291	receipts	290.jpg	IMG_20111221_211817.jpg	2011/12/21	\N	neosavvy
235	receipts	234.jpg	IMG_20111221_205618.jpg	2011/12/21	\N	neosavvy
243	receipts	242.jpg	IMG_20111221_210128.jpg	2011/12/21	\N	neosavvy
251	receipts	250.jpg	IMG_20111221_210427.jpg	2011/12/21	\N	neosavvy
261	receipts	260.jpg	IMG_20111221_210815.jpg	2011/12/21	\N	neosavvy
269	receipts	268.jpg	IMG_20111221_211100.jpg	2011/12/21	\N	neosavvy
275	receipts	274.jpg	IMG_20111221_211328.jpg	2011/12/21	\N	neosavvy
283	receipts	282.jpg	IMG_20111221_211553.jpg	2011/12/21	\N	neosavvy
292	receipts	292.jpg	IMG_20111221_211858.jpg	2011/12/21	application/octet-stream	neosavvy
293	receipts	292.jpg	IMG_20111221_211858.jpg	2011/12/21	\N	neosavvy
294	receipts	294.jpg	IMG_20111221_211924.jpg	2011/12/21	application/octet-stream	neosavvy
295	receipts	294.jpg	IMG_20111221_211924.jpg	2011/12/21	\N	neosavvy
296	receipts	296.jpg	IMG_20111221_211949.jpg	2011/12/21	application/octet-stream	neosavvy
297	receipts	296.jpg	IMG_20111221_211949.jpg	2011/12/21	\N	neosavvy
298	receipts	298.jpg	IMG_20111221_212013.jpg	2011/12/21	application/octet-stream	neosavvy
299	receipts	298.jpg	IMG_20111221_212013.jpg	2011/12/21	\N	neosavvy
300	receipts	300.jpg	IMG_20111221_212050.jpg	2011/12/21	application/octet-stream	neosavvy
301	receipts	300.jpg	IMG_20111221_212050.jpg	2011/12/21	\N	neosavvy
302	receipts	302.jpg	IMG_20111221_213728.jpg	2011/12/21	application/octet-stream	neosavvy
303	receipts	302.jpg	IMG_20111221_213728.jpg	2011/12/21	\N	neosavvy
304	receipts	304.jpg	IMG_20111223_153237.jpg	2011/12/23	application/octet-stream	neosavvy
305	receipts	304.jpg	IMG_20111223_153237.jpg	2011/12/23	\N	neosavvy
306	receipts	306.jpg	IMG_20111223_153304.jpg	2011/12/23	application/octet-stream	neosavvy
307	receipts	306.jpg	IMG_20111223_153304.jpg	2011/12/23	\N	neosavvy
308	receipts	308.jpg	IMG_20111223_153327.jpg	2011/12/23	application/octet-stream	neosavvy
309	receipts	308.jpg	IMG_20111223_153327.jpg	2011/12/23	\N	neosavvy
310	receipts	310.jpg	IMG_20111223_153348.jpg	2011/12/23	application/octet-stream	neosavvy
311	receipts	310.jpg	IMG_20111223_153348.jpg	2011/12/23	\N	neosavvy
312	receipts	312.jpg	IMG_20111223_161443.jpg	2011/12/23	application/octet-stream	neosavvy
313	receipts	312.jpg	IMG_20111223_161443.jpg	2011/12/23	\N	neosavvy
314	receipts	314.jpg	IMG_20111223_162107.jpg	2011/12/23	application/octet-stream	neosavvy
315	receipts	314.jpg	IMG_20111223_162107.jpg	2011/12/23	\N	neosavvy
316	receipts	316.jpg	IMG_20111223_165050.jpg	2011/12/23	application/octet-stream	neosavvy
317	receipts	316.jpg	IMG_20111223_165050.jpg	2011/12/23	\N	neosavvy
318	receipts	318.jpg	IMG_20111223_165328.jpg	2011/12/23	application/octet-stream	neosavvy
319	receipts	318.jpg	IMG_20111223_165328.jpg	2011/12/23	\N	neosavvy
320	receipts	320.jpg	IMG_20111223_165449.jpg	2011/12/23	application/octet-stream	neosavvy
321	receipts	320.jpg	IMG_20111223_165449.jpg	2011/12/23	\N	neosavvy
322	receipts	322.jpg	IMG_20111223_165529.jpg	2011/12/23	application/octet-stream	neosavvy
323	receipts	322.jpg	IMG_20111223_165529.jpg	2011/12/23	\N	neosavvy
324	receipts	324.jpg	IMG_20111223_165904.jpg	2011/12/23	application/octet-stream	neosavvy
325	receipts	324.jpg	IMG_20111223_165904.jpg	2011/12/23	\N	neosavvy
326	receipts	326.jpg	IMG_20111223_171244.jpg	2011/12/23	application/octet-stream	neosavvy
327	receipts	326.jpg	IMG_20111223_171244.jpg	2011/12/23	\N	neosavvy
\.


--
-- Data for Name: user_company_role; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_company_role (id, role_fk, company_fk, user_fk) FROM stdin;
1	1	1	1
2	2	1	2
3	1	2	3
4	1	3	4
5	2	3	5
6	1	4	6
7	1	5	7
8	1	6	8
9	2	6	9
10	2	6	10
11	1	7	11
12	1	8	12
\.


--
-- Data for Name: user_invite; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_invite (id, middle_name, last_name, email_address, contact_phone_number, first_name, registration_token, company_fk) FROM stdin;
1	\N	Parrish	aparrish@neosavvy.com	\N	Adam	D96C5681A8A518F2	1
2	\N	Parrish	aparrish@neosavvy.com	\N	Adam	D258134C7767342A	2
5	\N	Roberts	alanroberts@air-watch.com	\N	Alan	091204561705E3E7	3
6	\N	Roberts	loraroberts@air-watch.com	\N	Lora	49FCA215181B6523	3
7	\N	Parrish	aparrish@neosavvy.com	\N	Adam	A280086A909BCD5A	6
8	\N	Hamlett	dhamlett@neosavvy.com	\N	Dana	7122338F512EEAF6	6
9	\N	Brouillette	cbrouillette@globalite.ca	\N	Carl	57E33847155BEB42	7
\.


--
-- Data for Name: user_receipts; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_receipts (user_fk, receipt_fk) FROM stdin;
3	2
3	4
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY user_sessions (id, username, creation_date) FROM stdin;
98F75AA2-7FDF-4D90-8CB9-BBAF25962D51	neosavvy	2011-01-24 02:47:17.884+00
A2DEAAC8-2A43-4D25-BE8B-E7A3C911DFAF	adamparrish	2011-01-25 03:37:02.529+00
B8ECBBD5-94BF-4C29-A4A9-FAC94AEBF79E	andre	2011-01-26 14:58:45.324+00
B6C586B0-896B-4FCF-A3E0-C7751476229B	andre	2011-01-26 14:59:58.774+00
5838D18E-4EB7-4FAA-9D8B-F60201DA0A4D	andre	2011-01-28 04:11:31.943+00
60B62B6E-5118-41C8-B443-3A5798D7AB2E	neosavvy	2011-01-29 14:52:21.806+00
8B271E5A-695B-47FC-9A07-754BA3BFAB48	neosavvy	2011-01-31 03:32:49.222+00
12C0273D-8C68-4820-B6AE-F25BD521790B	neosavvy	2011-02-05 23:58:00.406+00
2041ABFC-D1B2-4E23-A830-7CF0C3C3ED2A	neosavvy	2011-02-06 15:20:25.008+00
34AD4372-5FEC-48F9-9378-E2D71CFB757B	neosavvy	2011-02-08 02:36:11.075+00
18795A40-467E-451D-9872-F3B6F6717E68	neosavvy	2011-03-02 22:03:03.333+00
26D6953F-0256-487C-A26E-222C9C8ABD7F	neosavvy	2011-03-03 04:43:43.194+00
578DECA3-0705-4E83-9568-74B3B248EB63	neosavvy	2011-03-11 12:26:53.383+00
6C27D276-08B9-4621-BD38-B1F00DE8904B	neosavvy	2011-03-12 18:52:23.18+00
694D7103-C30A-44EE-BC96-E84004907023	neosavvy	2011-03-14 20:08:56.829+00
30852AB4-3E47-4A47-9C89-1EAB0A6D5454	neosavvy	2011-03-14 20:09:11.129+00
3CB34278-11F0-4299-A7D4-6CD63A27C19F	neosavvy	2011-03-14 20:13:51.579+00
B618BCC7-5A11-4BB4-A51E-00D4ECCC1376	neosavvy	2011-03-20 04:10:36.48+00
AC67246E-CBAC-44F8-A052-93520BBE068A	neosavvy	2011-03-28 02:38:50.667+00
0E1137B3-F56F-4122-9D2C-44866D12CA29	neosavvy	2011-04-02 19:43:42.571+00
7AE87F15-BC01-4D3D-AB93-76CF9FD6E274	neosavvy	2011-04-03 00:33:53.877+00
6CB7D584-34D5-41D1-BEB4-B24508657B5B	neosavvy	2011-04-03 13:45:19.726+00
EB1DB4BC-16A5-4AA4-BABC-260AD7A11E28	airwatch	2011-04-05 10:48:07.069+00
C6CE794D-6578-411C-A5D2-1D88FBBEA42C	lroberts	2011-04-06 01:41:33.23+00
764F1186-1DAF-4710-824A-96DD11F0CF1B	neosavvy	2011-04-12 12:37:58.892+00
DB787A30-DA92-44F2-B54A-1E42643CC289	neosavvy	2011-04-15 12:32:55.011+00
624967C9-7113-4CAC-982E-F1D690C6EDAB	neosavvy	2011-04-15 15:27:31.011+00
13C9EFDF-92AB-4065-989A-666F4FD13DDB	neosavvy	2011-04-23 17:23:24.447+00
A870B216-D239-45B4-8772-3C166A8C1624	neosavvy	2011-05-01 21:01:16.667+00
27FA75DB-7E0A-4358-BC08-D0931CB493EF	neosavvy	2011-05-20 20:21:30.726+00
3A99C2ED-583A-45B1-A002-2DB5B5EBDDC3	neosavvy	2011-05-24 01:08:03.739+00
463F7BBA-8105-4D88-883C-1551F8D53C37	neosavvy	2011-05-30 18:44:49.957+00
1F40901C-F567-4438-9252-A9C2B1E4D247	neosavvy	2011-06-01 02:18:07.192+00
70364A0D-CA48-4382-A764-B97A5E3D228E	neosavvy	2011-06-01 02:44:45.092+00
04A6DB6A-A06D-477F-9977-DCA176CBF6A8	neosavvy	2011-06-01 02:46:22.562+00
DDA9F795-DBEF-4D4B-81EE-7C8644590457	neosavvy	2011-06-01 02:53:18.632+00
BC83C1C3-196F-4DA3-B163-DDBC1AF83753	neosavvy	2011-06-02 23:13:41.924+00
D6F73E44-8D29-4658-B44D-5642A608AAB1	neosavvy	2011-06-02 23:14:25.994+00
01CEF584-1A61-4E9F-9198-11B5BC40A1AF	neosavvy	2011-06-03 03:03:08.106+00
198DB320-4DD9-4F36-BF8F-7351F669E271	neosavvy	2011-06-03 03:10:36.736+00
B5E9DAE5-CBBB-4B8A-9BC9-2CB5D2C9AB9A	neosavvy	2011-06-03 03:19:01.466+00
2BC1EBA0-503D-4588-B90E-71BB6A72DC3E	neosavvy	2011-06-03 03:28:55.506+00
DB962514-B016-4447-AF98-911B367C239F	neosavvy	2011-06-04 23:49:14.531+00
83A8AF00-789E-4ABC-BE77-F1A301286004	neosavvy	2011-06-05 00:31:51.457+00
200D161D-904C-4BB5-9280-E23197DF5E0B	neosavvy	2011-06-05 00:36:33.277+00
BDE55469-495D-4C70-A268-D8174E82AC1A	neosavvy	2011-06-05 00:44:54.727+00
24228157-94E3-4000-A948-9F8176EC1233	neosavvy	2011-06-05 00:45:48.637+00
FA4E68F2-2FED-4557-AFE1-47C9B39677EC	neosavvy	2011-06-05 02:15:48.759+00
9D22CFF6-BCBD-4AE5-BEEA-466487DD1147	neosavvy	2011-06-05 02:27:08.429+00
AEE53F2F-2124-49CA-9B22-3A8C779D58CF	neosavvy	2011-06-06 06:31:45.693+00
0AD68331-ECB2-4BBD-9F8E-3AAFCF590531	neosavvy	2011-06-07 02:41:45.972+00
4CD58AFD-8CE0-46B7-9AD9-547D90B66F02	neosavvy	2011-06-17 12:10:25.661+00
F5567AF5-0551-4E95-8D23-F8DFA1FC13AD	neosavvy	2011-06-17 12:10:35.701+00
CBE68822-579B-4E17-885F-F5D40661C0AE	neosavvy	2011-06-19 22:17:52.099+00
723248AB-ADA1-4E26-9E15-7103527A811E	neosavvy	2011-06-23 00:37:04.134+00
63B69237-EEC7-4588-A067-6973FBAB2C22	neosavvy	2011-06-24 19:57:59.992+00
1B2C928C-8F79-45DE-8C46-481A3C734DDB	neosavvy	2011-06-28 23:33:34.501+00
A81FAE95-E5BD-4613-A71F-1E6BCE18DE47	neosavvy	2011-06-28 23:49:13.751+00
A7B39FED-26A5-4D6D-938B-563BA2A788BB	neosavvy	2011-06-28 23:55:19.601+00
7F9E4905-F017-4323-9796-4C6F353914FB	neosavvy	2011-06-29 00:08:39.865+00
BF130303-B307-43D9-BD3B-1785C493CF64	neosavvy	2011-06-29 02:02:25.413+00
3C0D7689-27CF-4D47-83BC-5907CA9133A1	neosavvy	2011-06-29 02:08:48.473+00
41AC4B13-155F-42C3-A3E2-7830B6CF1E22	danspeca	2011-06-29 02:48:33.513+00
CA957F65-2B5A-4BE9-AC00-238A3644B88B	neosavvy	2011-06-29 03:17:35.566+00
F38D872D-3CC0-4EEA-9AD4-63D2011DBD70	neosavvy	2011-06-29 03:26:04.916+00
4E243B45-DAEE-4ECB-B2B0-D717441C55A4	neosavvy	2011-07-08 01:39:25.711+00
00362637-8903-45FF-BDCD-2F5BE1B7C396	neosavvy	2011-07-12 02:33:56.862+00
34ED7233-6E19-493D-8581-09BBEAF93292	aparrish_ra	2011-07-12 02:52:52.742+00
6C6ABFDD-48B3-4814-97C7-F61579C514C6	neosavvy	2011-07-12 02:54:04.762+00
61D4D54A-21BA-4D5B-AB75-F2B069F9B3BF	aparrish_ra	2011-07-12 03:05:07.646+00
ED0154D2-802B-4BC4-8A55-88E5D31FF495	aparrish_ra	2011-07-12 03:50:51.876+00
1672F99C-BCA1-4EC2-8024-908BB4DC080F	neosavvy	2011-07-12 23:33:10.941+00
1F303005-4C74-4883-8A1C-773F007FC4E5	neosavvy	2011-07-20 13:33:26.054+00
FDC65BC5-03B5-4B4E-BDB6-FC9F0BF14935	neosavvy	2011-07-22 17:27:22.301+00
62E0A5E4-4B52-428B-83AC-6EDB8B794AC6	neosavvy	2011-08-12 13:17:22.303+00
33C1DF97-E070-4398-AD7D-16925CF17CA1	neosavvy	2011-08-14 21:53:23.887+00
D3D70621-C071-41F4-878D-9EB394FC5895	neosavvy	2011-08-14 22:23:47.831+00
5906FF2A-9D24-4661-A14E-2F90D44DB7F3	neosavvy	2011-08-24 20:30:15.313+00
E6ED83E6-0A18-4B31-8A6E-83A2917BFD5A	neosavvy	2011-08-27 02:27:36.722+00
99F91788-F0D2-4B51-A4FB-869960F57A34	neosavvy	2011-08-27 13:53:39.721+00
7A78F82C-8987-4242-B7E7-C0C12FDA58A9	neosavvy	2011-09-07 21:45:15.537+00
2201E32D-A364-4194-94BB-D682195893C1	neosavvy	2011-09-09 17:01:43.331+00
75159304-D024-4487-9AC9-E6E2359A8F81	neosavvy	2011-09-09 18:08:52.366+00
B89F1FF6-9DD3-4615-B171-92B7F2D35DAF	neosavvy	2011-09-15 23:07:32.169+00
41D66709-FD0C-4DAC-B80B-AF5C2CA18BFF	neosavvy	2011-09-27 18:04:02.03+00
62796E8B-40DD-4ECF-99E0-C1C4CE294E1B	neosavvy	2011-10-03 07:01:58.981+00
F39ABA3D-8F8B-4554-B263-76A4EFCEE048	neosavvy	2011-10-12 11:44:22.762+00
F56FAE05-8591-4989-A6F5-02A20CF8AB7E	neosavvy	2011-10-17 04:01:19.155+00
372890C5-8B0A-4012-9F4D-A0E03D9C7F19	neosavvy	2011-10-20 02:37:16.516+00
E29FE137-7421-40A1-95D1-5A46DF9A7CD9	neosavvy	2011-10-26 03:13:37.888+00
A4D79C85-ACDE-4915-947F-F8480B5CC7B3	neosavvy	2011-11-08 00:14:55.572+00
5D106F4F-60BA-4EA0-81DF-D1A5A17BD09A	neosavvy	2011-11-09 17:13:47.643+00
4864D75C-B116-4244-819A-4748DA44CC2C	neosavvy	2011-11-17 13:15:48.862+00
B277386E-61D2-4D6C-952A-413428D7908C	neosavvy	2011-11-23 03:37:46.639+00
B5FE722B-F96E-4A3D-8B2E-2D047F97585D	neosavvy	2011-11-25 22:05:27.769+00
ABBCFDAF-9791-4563-BFC7-7EA9D7ACA03E	neosavvy	2011-11-25 22:10:14.879+00
D8A7D2C1-6DA3-4E69-A984-8AA975DB504F	neosavvy	2011-11-30 02:56:36.274+00
1AEAD340-A033-4960-97AE-B9E5BF0CB9B6	neosavvy	2011-12-01 21:11:07.135+00
4B1745C7-130C-42D1-8F76-F360175D631D	neosavvy	2011-12-02 20:58:03.675+00
98B3521F-CDEA-4FD9-94EB-531439E4A854	neosavvy	2011-12-06 18:41:45.712+00
EF2CB47E-AC39-4C8C-8FA5-B5B8E6026B91	neosavvy	2011-12-08 19:44:11.554+00
C7F65CEF-52E3-4063-8597-30C40DEF4512	neosavvy	2011-12-22 01:48:05.376+00
2E6F8DB7-01D6-4EC7-8E49-4EE1080844E3	neosavvy	2011-12-22 02:21:37.847+00
6E42126C-500D-43E4-AE58-28C1CE0EAE0A	neosavvy	2011-12-23 20:15:57.771+00
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: commonsuser; Owner: commonsuser
--

COPY users (id, middle_name, last_name, email_address, contact_phone_number, password, username, active, first_name, confirmed_registration, reg_token, password_reset) FROM stdin;
3	de	Cavaignac	aparrish@neosavvy.com	\N	test	andre	t	Andre	t	3AC83FF4B2B0965B	f
2		Parrish	aparrish@neosavvy.com	\N	014B20D2	adamparrish	t	Adam	t	D96C5681A8A518F2	f
1		Parrish	aparrish@neosavvy.com	\N	winter69	neosavvy	t	Adam	t	EAF55BE44C1AEB36	f
5		Roberts	loraroberts@air-watch.com	\N	bonita03	lroberts	t	Lora	t	49FCA215181B6523	f
4	\N	Roberts	alanroberts@airwatch.com	\N	zidik	airwatch	t	Alan	t	663BC0E16C2A0B95	f
6	\N	Chen	rav4ski@yahoo.com	\N	D8BC89A4	j4njusa	f	Jason	f	8DA7DF0BA8DC5474	t
7	\N	speca	dspeca@mobiquityinc.com	\N	camille	danspeca	t	dan	t	CF6826FB76EFE989	f
8	\N	Hust	aparrish@neosavvy.com	\N	roundarch	roundarch	t	Caitlin	t	93CC9F1B738FF77C	f
9		Parrish	aparrish@neosavvy.com	\N	neosavvy	aparrish_ra	t	Adam	t	A280086A909BCD5A	f
10		Hamlett	dhamlett@neosavvy.com	\N	neosavvy	dhamlett_ra	t	Dana 	t	7122338F512EEAF6	f
11	\N	Brouillette	cbrouillette@globalite.ca	\N	GlobaliteDog!	cbrouillette@globalite.ca	t	Carl	t	BE9932C203866D30	f
12	\N	User	test@example.com	\N	testing	netsuser	f	Test	f	72C348E6E0A6FD1F	f
\.


--
-- Name: acl_class_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_class
    ADD CONSTRAINT acl_class_pkey PRIMARY KEY (id);


--
-- Name: acl_entry_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT acl_entry_pkey PRIMARY KEY (id);


--
-- Name: acl_object_identity_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_pkey PRIMARY KEY (id);


--
-- Name: acl_sid_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_sid
    ADD CONSTRAINT acl_sid_pkey PRIMARY KEY (id);


--
-- Name: attribute_descriptor_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY attribute_descriptor
    ADD CONSTRAINT attribute_descriptor_pkey PRIMARY KEY (id);


--
-- Name: attribute_enum_value_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY attribute_enum_value
    ADD CONSTRAINT attribute_enum_value_pkey PRIMARY KEY (id);


--
-- Name: client_company_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY client_company
    ADD CONSTRAINT client_company_pkey PRIMARY KEY (id);


--
-- Name: client_user_contact_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY client_user_contact
    ADD CONSTRAINT client_user_contact_pkey PRIMARY KEY (id);


--
-- Name: company_expense_item_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY company_expense_item_type
    ADD CONSTRAINT company_expense_item_type_pkey PRIMARY KEY (id);


--
-- Name: company_payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY company_payment_method
    ADD CONSTRAINT company_payment_method_pkey PRIMARY KEY (id);


--
-- Name: company_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- Name: expense_item_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_item_type
    ADD CONSTRAINT expense_item_type_pkey PRIMARY KEY (id);


--
-- Name: expense_item_value_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_pkey PRIMARY KEY (id);


--
-- Name: expense_report_item_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_pkey PRIMARY KEY (id);


--
-- Name: expense_report_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_report
    ADD CONSTRAINT expense_report_pkey PRIMARY KEY (id);


--
-- Name: payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (id);


--
-- Name: pk_databasechangelog; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY databasechangelog
    ADD CONSTRAINT pk_databasechangelog PRIMARY KEY (id, author, filename);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: pk_expense_report_audit_history; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT pk_expense_report_audit_history PRIMARY KEY (id);


--
-- Name: pk_file_refs; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY file_refs
    ADD CONSTRAINT pk_file_refs PRIMARY KEY (id);


--
-- Name: pk_user_sessions; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY user_sessions
    ADD CONSTRAINT pk_user_sessions PRIMARY KEY (id);


--
-- Name: project_approvers_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_approvers
    ADD CONSTRAINT project_approvers_pkey PRIMARY KEY (user_id, project_id);


--
-- Name: project_participants_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_participants
    ADD CONSTRAINT project_participants_pkey PRIMARY KEY (user_id, project_id);


--
-- Name: project_payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_payment_method
    ADD CONSTRAINT project_payment_method_pkey PRIMARY KEY (id);


--
-- Name: project_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY project_type
    ADD CONSTRAINT project_type_pkey PRIMARY KEY (id);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: standard_expense_item_type_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY standard_expense_item_type
    ADD CONSTRAINT standard_expense_item_type_pkey PRIMARY KEY (id);


--
-- Name: standard_payment_method_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY standard_payment_method
    ADD CONSTRAINT standard_payment_method_pkey PRIMARY KEY (id);


--
-- Name: unq_acl_class_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_class
    ADD CONSTRAINT unq_acl_class_0 UNIQUE (class);


--
-- Name: unq_acl_entry_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT unq_acl_entry_0 UNIQUE (acl_object_identity, ace_order);


--
-- Name: unq_acl_object_identity_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT unq_acl_object_identity_0 UNIQUE (object_id_class, object_id_identity);


--
-- Name: unq_acl_sid_0; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY acl_sid
    ADD CONSTRAINT unq_acl_sid_0 UNIQUE (sid, principal);


--
-- Name: unq_role_1; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT unq_role_1 UNIQUE (short_name);


--
-- Name: unq_users_1; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT unq_users_1 UNIQUE (username);


--
-- Name: user_company_role_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_pkey PRIMARY KEY (id);


--
-- Name: user_invite_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY user_invite
    ADD CONSTRAINT user_invite_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: expense_item_value_yy10mm01_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm01_expense_item_id ON expense_item_value_yy10mm01 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy10mm01_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm01_partition_date ON expense_item_value_yy10mm01 USING btree (partition_date);


--
-- Name: expense_item_value_yy10mm06_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm06_expense_item_id ON expense_item_value_yy10mm06 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy10mm06_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy10mm06_partition_date ON expense_item_value_yy10mm06 USING btree (partition_date);


--
-- Name: expense_item_value_yy11mm01_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm01_expense_item_id ON expense_item_value_yy11mm01 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy11mm01_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm01_partition_date ON expense_item_value_yy11mm01 USING btree (partition_date);


--
-- Name: expense_item_value_yy11mm06_expense_item_id; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm06_expense_item_id ON expense_item_value_yy11mm06 USING btree (expense_item_fk);


--
-- Name: expense_item_value_yy11mm06_partition_date; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX expense_item_value_yy11mm06_partition_date ON expense_item_value_yy11mm06 USING btree (partition_date);


--
-- Name: ix_acl_class_unq_acl_class_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_class_unq_acl_class_0 ON acl_class USING btree (class);


--
-- Name: ix_acl_entry_unq_acl_entry_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_entry_unq_acl_entry_0 ON acl_entry USING btree (acl_object_identity, ace_order);


--
-- Name: ix_acl_object_identity_unq_acl_object_identity_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_object_identity_unq_acl_object_identity_0 ON acl_object_identity USING btree (object_id_class, object_id_identity);


--
-- Name: ix_acl_sid_unq_acl_sid_0; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_acl_sid_unq_acl_sid_0 ON acl_sid USING btree (sid, principal);


--
-- Name: ix_role_unq_role_1; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_role_unq_role_1 ON role USING btree (short_name);


--
-- Name: ix_users_unq_users_1; Type: INDEX; Schema: commonsuser; Owner: commonsuser; Tablespace: 
--

CREATE INDEX ix_users_unq_users_1 ON users USING btree (username);


--
-- Name: expense_item_value_insert_yy10mm01; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy10mm01 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2010-01-01'::date) AND (new.partition_date < '2010-06-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy10mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: expense_item_value_insert_yy10mm06; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy10mm06 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2010-06-01'::date) AND (new.partition_date < '2011-01-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy10mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: expense_item_value_insert_yy11mm01; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy11mm01 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2011-01-01'::date) AND (new.partition_date < '2011-06-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy11mm01 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: expense_item_value_insert_yy11mm06; Type: RULE; Schema: commonsuser; Owner: commonsuser
--

CREATE RULE expense_item_value_insert_yy11mm06 AS ON INSERT TO expense_item_value WHERE ((new.partition_date >= '2011-06-01'::date) AND (new.partition_date < '2012-01-01'::date)) DO INSTEAD INSERT INTO expense_item_value_yy11mm06 (id, string_value, partition_date, enumerated_value_id, expense_item_fk, descriptor_id) VALUES (new.id, new.string_value, new.partition_date, new.enumerated_value_id, new.expense_item_fk, new.descriptor_id);


--
-- Name: acl_entry_acl_object_identity_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT acl_entry_acl_object_identity_fkey FOREIGN KEY (acl_object_identity) REFERENCES acl_object_identity(id);


--
-- Name: acl_entry_sid_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_entry
    ADD CONSTRAINT acl_entry_sid_fkey FOREIGN KEY (sid) REFERENCES acl_sid(id);


--
-- Name: acl_object_identity_object_id_class_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_object_id_class_fkey FOREIGN KEY (object_id_class) REFERENCES acl_class(id);


--
-- Name: acl_object_identity_owner_sid_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_owner_sid_fkey FOREIGN KEY (owner_sid) REFERENCES acl_sid(id);


--
-- Name: acl_object_identity_parent_object_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY acl_object_identity
    ADD CONSTRAINT acl_object_identity_parent_object_fkey FOREIGN KEY (parent_object) REFERENCES acl_object_identity(id);


--
-- Name: attribute_enum_value_descriptor_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY attribute_enum_value
    ADD CONSTRAINT attribute_enum_value_descriptor_id_fkey FOREIGN KEY (descriptor_id) REFERENCES attribute_descriptor(id);


--
-- Name: client_company_client_user_contact_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY client_company
    ADD CONSTRAINT client_company_client_user_contact_fk_fkey FOREIGN KEY (client_user_contact_fk) REFERENCES client_user_contact(id);


--
-- Name: client_company_parent_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY client_company
    ADD CONSTRAINT client_company_parent_company_fk_fkey FOREIGN KEY (parent_company_fk) REFERENCES company(id);


--
-- Name: company_expense_item_type_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_expense_item_type
    ADD CONSTRAINT company_expense_item_type_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: company_expense_item_type_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_expense_item_type
    ADD CONSTRAINT company_expense_item_type_id_fkey FOREIGN KEY (id) REFERENCES expense_item_type(id);


--
-- Name: company_payment_method_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_payment_method
    ADD CONSTRAINT company_payment_method_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: company_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY company_payment_method
    ADD CONSTRAINT company_payment_method_id_fkey FOREIGN KEY (id) REFERENCES payment_method(id);


--
-- Name: expense_item_descriptor_expense_item_type_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_descriptor
    ADD CONSTRAINT expense_item_descriptor_expense_item_type_fk_fkey FOREIGN KEY (expense_item_type_fk) REFERENCES expense_item_type(id);


--
-- Name: expense_item_descriptor_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_descriptor
    ADD CONSTRAINT expense_item_descriptor_id_fkey FOREIGN KEY (id) REFERENCES attribute_descriptor(id);


--
-- Name: expense_item_value_descriptor_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_descriptor_id_fkey FOREIGN KEY (descriptor_id) REFERENCES attribute_descriptor(id);


--
-- Name: expense_item_value_enumerated_value_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_enumerated_value_id_fkey FOREIGN KEY (enumerated_value_id) REFERENCES attribute_enum_value(id);


--
-- Name: expense_item_value_expense_item_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_item_value
    ADD CONSTRAINT expense_item_value_expense_item_fk_fkey FOREIGN KEY (expense_item_fk) REFERENCES expense_report_item(id);


--
-- Name: expense_report_item_expense_item_type_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_expense_item_type_fk_fkey FOREIGN KEY (expense_item_type_fk) REFERENCES expense_item_type(id);


--
-- Name: expense_report_item_expense_report_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_expense_report_fk_fkey FOREIGN KEY (expense_report_fk) REFERENCES expense_report(id);


--
-- Name: expense_report_item_payment_method_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_payment_method_fk_fkey FOREIGN KEY (payment_method_fk) REFERENCES payment_method(id);


--
-- Name: expense_report_item_project_type_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT expense_report_item_project_type_fk_fkey FOREIGN KEY (project_type_fk) REFERENCES project_type(id);


--
-- Name: expense_report_owner_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report
    ADD CONSTRAINT expense_report_owner_fk_fkey FOREIGN KEY (owner_fk) REFERENCES users(id);


--
-- Name: expense_report_project_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report
    ADD CONSTRAINT expense_report_project_fk_fkey FOREIGN KEY (project_fk) REFERENCES project(id);


--
-- Name: fk_expense_report_audit_history_expense_report_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT fk_expense_report_audit_history_expense_report_fk FOREIGN KEY (expense_report_fk) REFERENCES expense_report(id);


--
-- Name: fk_expense_report_audit_history_owner_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT fk_expense_report_audit_history_owner_fk FOREIGN KEY (owner_fk) REFERENCES users(id);


--
-- Name: fk_expense_report_audit_history_user_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_audit_history
    ADD CONSTRAINT fk_expense_report_audit_history_user_fk FOREIGN KEY (user_fk) REFERENCES users(id);


--
-- Name: fk_expense_report_item_receipt_file_ref_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY expense_report_item
    ADD CONSTRAINT fk_expense_report_item_receipt_file_ref_fk FOREIGN KEY (receipt_file_ref_fk) REFERENCES file_refs(id);


--
-- Name: fk_receipt_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_receipts
    ADD CONSTRAINT fk_receipt_fk FOREIGN KEY (receipt_fk) REFERENCES file_refs(id);


--
-- Name: fk_storage_service_file_refs_id; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY storage_service_file_refs
    ADD CONSTRAINT fk_storage_service_file_refs_id FOREIGN KEY (id) REFERENCES file_refs(id);


--
-- Name: fk_user_fk; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_receipts
    ADD CONSTRAINT fk_user_fk FOREIGN KEY (user_fk) REFERENCES users(id);


--
-- Name: project_approvers_project_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_approvers
    ADD CONSTRAINT project_approvers_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_approvers_user_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_approvers
    ADD CONSTRAINT project_approvers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: project_client_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_client_company_fk_fkey FOREIGN KEY (client_company_fk) REFERENCES client_company(id);


--
-- Name: project_parent_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_parent_company_fk_fkey FOREIGN KEY (parent_company_fk) REFERENCES company(id);


--
-- Name: project_participants_project_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_participants
    ADD CONSTRAINT project_participants_project_id_fkey FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_participants
    ADD CONSTRAINT project_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: project_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_payment_method
    ADD CONSTRAINT project_payment_method_id_fkey FOREIGN KEY (id) REFERENCES payment_method(id);


--
-- Name: project_payment_method_project_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY project_payment_method
    ADD CONSTRAINT project_payment_method_project_fk_fkey FOREIGN KEY (project_fk) REFERENCES project(id);


--
-- Name: standard_expense_item_type_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY standard_expense_item_type
    ADD CONSTRAINT standard_expense_item_type_id_fkey FOREIGN KEY (id) REFERENCES expense_item_type(id);


--
-- Name: standard_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY standard_payment_method
    ADD CONSTRAINT standard_payment_method_id_fkey FOREIGN KEY (id) REFERENCES payment_method(id);


--
-- Name: user_company_role_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: user_company_role_role_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_role_fk_fkey FOREIGN KEY (role_fk) REFERENCES role(id);


--
-- Name: user_company_role_user_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_company_role
    ADD CONSTRAINT user_company_role_user_fk_fkey FOREIGN KEY (user_fk) REFERENCES users(id);


--
-- Name: user_invite_company_fk_fkey; Type: FK CONSTRAINT; Schema: commonsuser; Owner: commonsuser
--

ALTER TABLE ONLY user_invite
    ADD CONSTRAINT user_invite_company_fk_fkey FOREIGN KEY (company_fk) REFERENCES company(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

